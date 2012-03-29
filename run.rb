require 'server.rb'
require 'string.rb'

if port = ARGV[0] && ARGV[0].to_i!
        Server.new.run( port )
else
        puts "usage: #{$0} [port-no]"
end
