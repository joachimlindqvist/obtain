require 'spec_helper'

describe Obtain::Path do

  before(:each) do
    @dir = './tmp/download/'
  end

  it 'generates a file path' do
    file_path = Obtain::Path.generate_location(@dir)
    file_name = file_path.sub(@dir, '')
    expect(file_name).to match(/^[a-f0-9]{32}$/)
  end  

  it 'generates a random file path' do
    file_path = Obtain::Path.random_path(@dir)
    file_name = file_path.sub(@dir, '')
    expect(file_name).to match(/^[a-f0-9]{32}$/)
  end

  it 'creates a dir' do
    Obtain::Path.create_dir(@dir)
    expect(Dir.exists?(@dir)).to eq(true)
  end

  it 'creates a dir nonexistent dir' do
    nonexistent_dir = File.join(@dir, 'this-directory-does-not-exist')
    expect(Dir.exists?(nonexistent_dir)).to eq(false)
    Obtain::Path.create_dir(nonexistent_dir)
    expect(Dir.exists?(nonexistent_dir)).to eq(true)
    Dir.rmdir(nonexistent_dir)
  end
end