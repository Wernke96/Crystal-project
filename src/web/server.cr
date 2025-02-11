require "kemal"
require "../models/*"
require "../services/*"

module AWPriceTracker
  class Server
    def self.start
      get "/" do
        prices = Database.connection.query_all(
          "SELECT price, timestamp FROM price_history ORDER BY timestamp ASC",
          as: {Float64, Time}
        )
        render "src/views/index.ecr"
      end

      post "/scrape" do |env|
        price = PriceScraper.scrape_price
        env.response.content_type = "application/json"
        {price: price, timestamp: Time.utc}.to_json
      end

      Kemal.run
    end
  end
end 