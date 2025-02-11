require "./services/*"
require "./models/*"
require "signal"

running = true

Signal::INT.trap do
  puts "Received SIGINT, exiting..."
  running = false
end

puts running
while running 
  AWPriceTracker::PriceScraper.scrape_price
  puts "Scraped price"
  sleep(60)
end
