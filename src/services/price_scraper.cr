require "http/client"
require "xml"

module AWPriceTracker
  class PriceScraper
    PRODUCT_URL = "https://bush-daisy-tellurium.glitch.me" # Replace with actual URL

    def self.scrape_price
      headers = HTTP::Headers{
        "Referer" => "https://bush-daisy-tellurium.glitch.me/",
      }
      response = HTTP::Client.get(PRODUCT_URL, headers: headers)
      return extract_price(response.body)
    
    end

    private def self.extract_price(html : String)
      doc = XML.parse_html(html)

      # Find all product cards
      doc.xpath_nodes("//div[@class='product-card']").each do |card|
        # Get the product title
        title = card.xpath_node(".//h3")
        next unless title && title.content == "AW SuperFast Roadster"
          if price = card.xpath_node(".//div[@class='price']").try &.content
          priceFixed = price.gsub(/[$,]/, "").to_f
          self.save_price(priceFixed)
          return priceFixed
          end 

      # If we found the right product, get its price
      end
    end

    private def self.save_price(price : Float64)
      puts price
      Database.connection.exec(
        "INSERT INTO price_history (price) VALUES (?)",
        price
      )
    end
  end
end
