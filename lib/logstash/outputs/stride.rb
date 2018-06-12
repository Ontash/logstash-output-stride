# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require 'net/http'
require 'uri'

# An example output that does nothing.
class LogStash::Outputs::Stride < LogStash::Outputs::Base
  
  config_name "stride"
  
  # the access token, cloud_id and conversation id of the stride room
  config :access_token, :validate => :string, :required => true
  config :cloud_id, :validate => :string, :required => true
  config :conversation_id, :validate => :string, :required => true

  # message variable contains the default message retreived inside logstash
  # Examples:-
  # for nxlog default message is in `Message` variable
  # for filebeat & log4j default message is in `message` variable
  config :message, :validate => :string, :default => "%{message}"

  # the host contains the IP, type is the type of log and severity denotes priority
  config :host, :validate => :string, :default => "%{host}"
  config :type, :validate => :string, :default => "%{type}"
  config :priority, :validate => :string, :default => "%{priority}"
  
  public
  def register
  end # def register

  public
  def receive(event)
    
    # initialize all variables
    access_token = event.sprintf(@access_token)
    cloud_id = event.sprintf(@cloud_id)
    conversation_id = event.sprintf(@conversation_id)
    host = event.sprintf(@host)
    type = event.sprintf(@type)
    message = event.sprintf(@message)
    priority = event.sprintf(@priority)

    post_message(access_token,cloud_id,conversation_id,host,type,priority,message)
    
  rescue Exception => e
    puts '**** ERROR ****'
    puts e.message
  end

  # sends the message to stride
  public
  def post_message(access_token,cloud_id,conversation_id,host,type,priority,message)
    
    # format of the log
    message = %Q|#{Time.now} : #{message}|
    message = %Q|#{host} : #{message}| if host
    message = %Q|#{type} : #{message}| if type
    message = %Q|#{priority} : #{message}| if priority

    # prep and send the http request 
    uri = URI.parse("https://api.atlassian.com/site/#{cloud_id}/conversation/#{conversation_id}/message")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer #{access_token}"
    request.body = '{"version":1,"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"'+message+'"}]}]}'
    req_options = { use_ssl: uri.scheme == "https", }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

  end
  
end # class LogStash::Outputs::Stride
