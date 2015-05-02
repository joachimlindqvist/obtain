module Obtain

  module Path

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

end