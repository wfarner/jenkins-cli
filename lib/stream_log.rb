#!/usr/bin/env ruby

require "trollop"

DEFAULT_JENKINS_URL = "http://localhost:8080"

OPTIONS = Trollop::options do
  opt :jenkins_url, "Jenkins main URL", :default => DEFAULT_JENKINS_URL
  opt :user, "Jenkins username", :default => nil, :type => String
  opt :password, "Jenkins password", :default => nil, :type => String
  opt :job, "Jenkins job to view the detail of", :default => nil, :type => String
end

Trollop::die :job, "Must specify a Jenkins job to view the details" if OPTIONS[:job].nil?

jenkins_username = "--username #{OPTIONS[:user]}"
jenkins_username = "" if OPTIONS[:user].nil?
jenkins_password = "--password #{OPTIONS[:password]}"
jenkins_password = "" if OPTIONS[:password].nil?

base_dir = File.dirname(__FILE__)

cmd = "java -jar #{base_dir}/jenkins-cli.jar -s #{OPTIONS[:jenkins_url]} groovy #{jenkins_username} #{jenkins_password} #{base_dir}/groovy/stream_log.groovy #{OPTIONS[:job]}"

system( cmd )
