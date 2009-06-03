def get_timestamp

  now = Time.now

  str = now.to_i.to_s
  str << ": "
  str << now.to_s

end

def format_log_entry file, entry_body

  str = get_timestamp
  str << "\n"
  str << entry_body
  str << "\n\n"

  File.open(file, 'a') {|f| f.write(str) }

end
