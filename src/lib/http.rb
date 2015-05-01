class Net::HTTP
  def https! (uri)
    @use_ssl = (uri.scheme == 'https')
    self
  end
end