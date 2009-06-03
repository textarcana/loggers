# :title:WWW.rb
# = Name
# WWW.rb
# = Synopsis
#     require 'www.rb'
#     log 1, "log.txt", lambda{`curl -s http://localhost`}
# = Description
# A specialized, minimal Web service framework in Ruby.

require 'log-util.rb'

# == logbot
#
# writes the result of fn to file
#
#     log 1, "log.txt", lambda{`curl -s http://localhost`}

def log delay, file, fn

  bot delay, lambda{format_log_entry file, fn.call()}

end

# == pollbot
#
#     poll 1, lambda{puts `curl -s http://localhost`}
#
# note that puts was needed in the lambda function to print the result
# of the poll, but is not needed for the logger

def poll delay, fn

  bot delay, fn

end

# bot factory

def bot delay, fn

  while true do

    fn.call()
    sleep delay
    bot delay, fn    

  end


end



