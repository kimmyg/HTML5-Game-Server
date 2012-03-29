class String
        def to_i!
                i = to_i

                unless i == 0 and not ( @self == '0' )
                        i
                end
        end
end
