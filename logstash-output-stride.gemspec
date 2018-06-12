Gem::Specification.new do |s|
  s.name = 'logstash-output-stride'
  s.version = '0.8.2'
  s.licenses = ['Apache-2.0']
  s.summary = "This logstash ouput plugin allows posting messages to stride rooms"
  s.description = "This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Vishnu Prasanth"]
  s.email = "vishnu@ontash.net"
  s.homepage = "http://www.ontash.net"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  #
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0", "<= 2.99"
  s.add_runtime_dependency "logstash-codec-plain", '~> 3.0', '>= 3.0.6'
  s.add_development_dependency 'logstash-devutils', '~> 1.3', '>= 1.3.6'
end
