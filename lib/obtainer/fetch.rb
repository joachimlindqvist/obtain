module Obtain

  module Fetch

    def self.fetch(uri, path)

      connection = self.establish_connection(uri)
      Obtain::Path.create_dir(File.dirname(path))

      File.open(path, 'wb') { |file|
        connection.request_get(uri.path) { |res| 
          res.read_body { |seg|
            file << seg
            sleep 0.005
          }
        }
      }

      File.realpath(path)
    end

    def self.establish_connection(uri)
      connection = Net::HTTP.new(uri.host, uri.port)
      connection.https!(uri)
    end

  end

end