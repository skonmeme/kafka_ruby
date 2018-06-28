class Hash

  def strictly_update!(hash)
    self.merge!(hash.dup.delete_if { |key| !self.has_key?(key) })
  end

  def required
    keys = self.reject { |key, value| value }.keys
    raise Kafka::MissingRequiredArugment.new(keys) if keys.size > 0
    self
  end

end
