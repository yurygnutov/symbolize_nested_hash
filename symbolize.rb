def symbolize_keys(my_hash)
  my_hash.inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo}
end

def deep_symbolize(h)
  # return symbolized nested hash

  document = symbolize_keys(h)

  document.each do |key, value|
    if [Hash, BSON::Document].include? value.class
      document[key] = deep_symbolize(value)

    elsif value.class == Array
      document[key] = value.map do |v|
        if [Hash, BSON::Document].include? v.class
          deep_symbolize(v)
        else
          v
        end
      end
    end
  end
  document
end
