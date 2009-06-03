# :title:Test Agent tasks
# = Name
# Test Agent tasks
# = Synopsis
#
#     # in your rakefile
#     require 'tasks/agent.rb'
#
# = Description
#
# Start a logging process that runs all the tests and publishes the
# result to a log file.  Then publish the last entry in the log file
# to a remote (HTML) file, overwriting the old published version.

namespace :agent do

  require 'www.rb'

  desc "publish all test results to the log every half hour"

  task :monitor do

    log 30*60, "log/agent.txt", lambda{`rake test`}

  end

end
