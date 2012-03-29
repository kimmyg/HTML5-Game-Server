class HTTPHandler
        @@request_pattern = /^GET (.*) HTTP\/1\.1$/
        @@header_pattern = /^([^:]+): (.*)$/

        #def intialize( <some server reference to add/remove clients or something> )
        #end

        def handle( socket )
                if socket.readline.chomp.match @@request_pattern
                        headers = {}

                        while socket.readline.chomp.match @@header_pattern
                                headers[ $1 ] = $2
                        end

                        # do some processing
                else
                        # throw an error or something
                end
        end
end
