def get_timestamp

  now = Time.now

  str = now.to_i.to_s
  str << ": "
  str << now.to_s

end

