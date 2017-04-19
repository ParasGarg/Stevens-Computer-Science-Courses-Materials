#!/usr/bin/env ruby
#
# This program is used for collecting web server visit information.
#
# Author: A. Genius
#

require 'optparse'

def print_usage
    puts "USAGE: visit_server -d DNS_NAME"
    exit
end

# add option switch and handler
options = {}

option_parser = OptionParser.new do |opts|
  
    # DNS_NAME argument
    options[:dns_name] = nil
    opts.on('-d', '--dns-name DNS_NAME', 'Specify a DNS NAME') { |dns_name| options[:dns_name] = dns_name } 

    # HELP argument
    options[:help] = nil
    opts.on('-h', '--help', 'Display usage') { |help| options[:help] = help }

end

option_parser.parse!

# verify arguments
if options[:dns_name] then
    dns_name = options[:dns_name]
else
    puts "Please set a balancer's DNS."
    print_usage
    exit
end

if options[:help] then
    print_usage
    exit
end

# Keep STDOUT
# orig_stdout = $stdout
# redirect stdout to /dev/null
#$stdout = File.new('/dev/null', 'w')
 
server1_visit_count = 0
server2_visit_count = 0
server3_visit_count = 0
server4_visit_count = 0

# starting to visit load balancing server
puts "Starting to visit load balancing server"

2000.times do
            # visit load balancer
            #o = `curl #{dns_name}`
            o = `curl -s #{dns_name}`

            if o =~ /server\s*1/i
                        server1_visit_count += 1
            elsif o =~ /server\s*2/i
                        server2_visit_count += 1
            elsif o =~ /server\s*3/i
                        server3_visit_count += 1
            elsif o =~ /server\s*4/i
                        server4_visit_count += 1
            end         

            print "."
end

# redirect output to stdout
#$stdout = orig_stdout

# print visit information
puts
puts '-------------------------'
puts ' Summary'
puts '-------------------------'
puts "Server1 visit counts : " + server1_visit_count.to_s
puts "Server2 visit counts : " + server2_visit_count.to_s
puts "Server3 visit counts : " + server3_visit_count.to_s
puts "Server4 visit counts : " + server4_visit_count.to_s
puts "Total visit counts : "   + (server1_visit_count + server2_visit_count + server3_visit_count + server4_visit_count).to_s