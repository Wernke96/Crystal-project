require "db"
require "sqlite3"

module AWPriceTracker
  class Database
    def self.setup
      DB.open "sqlite3:./price_history.db" do |db|
        db.exec "CREATE TABLE IF NOT EXISTS price_history (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          price REAL NOT NULL,
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )"
      end
    end

    def self.connection
      DB.open "sqlite3:./price_history.db"
    end
  end
end 