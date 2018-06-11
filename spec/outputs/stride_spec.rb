# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/outputs/stride"
require "logstash/codecs/plain"
require "logstash/event"

describe LogStash::Outputs::Stride do
  let(:sample_event) { LogStash::Event.new }
  let(:output) { LogStash::Outputs::Stride.new }

  before do
    output.register
  end

  describe "receive message" do
    subject { output.receive(sample_event) }
    end
  end
end
