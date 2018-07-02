require 'socket'
require 'openssl'

module Kafka

  module Network

    class Socket

      def self.connect(host, port, timeout, ssl_context)
        # https://spin.atomicobject.com/2013/09/30/socket-connection-timeout-ruby/
        # Ruby’s default socket connection timeout can be too long in many situations
        #
        # Convert the passed host into structures the non-blocking calls
        # can deal with
        addr = Socket.getaddrinfo(host, nil)
        sockaddr = Socket.pack_sockaddr_in(port, addr[0][3])

        Socket.new(Socket.const_get(addr[0][0]), Socket::SOCK_STREAM, 0).tap do |socket|
          socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

          begin
            # Initiate the socket connection in the background. If it doesn't fail
            # immediatelyit will raise an IO::WaitWritable (Errno::EINPROGRESS)
            # indicating the connection is in progress.
            socket.connect_nonblock(sockaddr)

          rescue IO::WaitWritable
            # IO.select will block until the socket is writable or the timeout
            # is exceeded - whichever comes first.
            if IO.select(nil, [socket], nil, timeout)
              begin
                # Verify there is now a good connection
                socket.connect_nonblock(sockaddr)
              rescue Errno::EISCONN
                # Good news everybody, the socket is connected!
              rescue
                # An unexpected exception was raised - the connection is no good.
                socket.close
                raise
              end
            else
              # IO.select returns nil when the socket is not ready before timeout
              # seconds have elapsed
              socket.close
              raise "Connection timeout"
            end
          end
        end
      end

    end

  end

end