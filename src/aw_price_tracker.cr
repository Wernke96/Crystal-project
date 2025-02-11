require "./services/*"
require "./models/*"
require "signal"

running = true

Signal::INT.trap do
  puts "Received SIGINT, exiting..."
  running = false
end

while running 
  puts AWPriceTracker::PriceScraper.scrape_price
  puts "Scraped price"
  sleep 60.seconds
end
