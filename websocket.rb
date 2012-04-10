require 'md5'
require 'socket'

class TCPSocket
  def ws_handshake( path, headers )
    u = headers['Sec-WebSocket-Key1'].gsub( /\D/, '' ).to_i / headers['Sec-WebSocket-Key1'].gsub( /\S/, '' ).length
    v = headers['Sec-WebSocket-Key2'].gsub( /\D/, '' ).to_i / headers['Sec-WebSocket-Key2'].gsub( /\S/, '' ).length
    w = read( 8 )
    
    key = MD5.digest( [u].pack('N') + [v].pack('N') + w )
    
    write "HTTP/1.1 101 WebSocket Protocol Handshake\r\n"
    write "Upgrade: WebSocket\r\n"
    write "Connection: Upgrade\r\n"
    write "Sec-WebSocket-Origin: #{headers['Origin']}\r\n"
    write "Sec-WebSocket-Location: ws://#{headers['Host']}#{path}\r\n"
    write "\r\n"
    write "#{key}"
  end
  
  def ws_receive
    line = readline( "\377" )
    line[1,line.length-2]
  end
  
  def ws_send( s )
    write "\000#{s}\377"
  end
end
