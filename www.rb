# logbot

# pollbot
#     poll 1, lambda{"foo"}   

def poll delay, fn

  while true do
    #puts "ping"
    fn.call()
    sleep delay
    poll delay, fn    
  end


end
c
