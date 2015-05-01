require "obtainer/version"
require 'rubygems'
require 'securerandom'
require 'fileutils'
require 'net/http'
require 'obtainer/http'

module Obtain

  def self.url_to_dir(url, dir)
    path = self.generate_location(dir)
    self.fetch(url, path)
  end

  def self.fetch(url, path)

    @uri = URI::parse(url)
    connection = self.establish_connection

    self.create_dir(File.dirname(path))

    File.open(path, 'wb') { |file|
      connection.request_get(@uri.path) { |res| 
        res.read_body { |seg|
          file << seg
          sleep 0.005
        }
      }
    }

    path
  end

  def self.establish_connection
    connection = Net::HTTP.new(@uri.host, @uri.port)
    connection.https!(@uri)
  end

  def self.generate_location(dir)

    location = self.random_path(dir)

    while File.file?(location) do 
      location = self.random_path(dir)
    end

    location
  end 

  def self.random_path(dir)
    File.join(dir, SecureRandom.hex)
  end

  def self.create_dir(dir)
    if !Dir.exists?(dir)
      FileUtils.mkdir_p(dir)
    end
  end
end
