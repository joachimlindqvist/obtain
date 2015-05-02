require "obtainer/version"

require 'rubygems'
require 'fileutils'
require 'securerandom'
require 'net/http'

require 'obtainer/path'
require 'obtainer/fetch'
require 'obtainer/http'


module Obtain

  def self.url_to_dir(url, dir)
    path = Obtain::Path.generate_location(dir)
    Obtain::Fetch.fetch(URI::parse(url), path)
  end

end
