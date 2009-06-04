# slurp file line-by-line and treat blocks of lines as blocks broken
# up by identifiers

# for each block, print 1 message per failure or error found

def parse_message_from_log_entry

  unique_messages = { }

  id = ""

  ARGF.each do |line|

    block_id = line.match(/Loaded suite (.*)/)
    failure_msg = line.match(/[1-9]+ failures/)
    err_msg = line.match(/[1-9]+ errors/)

    if ! block_id.nil?

      id = block_id[1]

    elsif ! failure_msg.nil?

      unique_messages["FAIL: #{id}"] = ""

    elsif ! err_msg.nil?

      unique_messages["ERROR: #{id}"] = ""

    end


  end

  puts unique_messages.keys.join("\n")


end


