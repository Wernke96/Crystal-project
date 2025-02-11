# Crystal-project
# Crystal Price Scraper

This application is a web scraper built with Crystal that tracks product prices and stores them in SQLite. It runs in Docker using Docker Compose for easy setup and deployment.

## Prerequisites

- Docker
- Docker Compose

## Project Structure

```
.
├── docker/
│   └── Dockerfile
├── src/
│   └── index.cr
│   └── aw_price_tracker.cr
│   └── mirgation.cr
    ├── models/
      └── database.cr
    ├── services/
      └── price_scrapper.cr
    ├── views/
        └── index.ecr
    ├── web/
        └── server.cr
├── shard.yml
├── docker-compose.yml
└── README.md
```

## Getting Started



1. Start the application using Docker Compose:
   ```bash
   docker-compose up -d
   docker compose exec crystal_app crystal run src/mirgation.cr
   ```

1. run service scraper in the background 
   ```bash
   docker-compose up -d
   docker compose exec crystal_app crystal run src/aw_price_tracker.cr
   ```


   This command will:
   - Build the Docker image using the Dockerfile in ./docker
   - Install Crystal dependencies (shards)
   - Run the application on port 3000
   - Mount your local directory to /app in the container

1. To stop the application:
   ```bash
   docker-compose down
   ```

## Development

The application uses volume mounting, so any changes you make to the source code will be reflected in the container. However, you'll need to restart the container to see the changes:

```bash
docker-compose restart
```

If the container fails to start:
1. Check the logs:
   ```bash
   docker-compose logs crystal_app
   ```

2. Access the container directly:
   ```bash
   docker-compose exec crystal_app sh
   ```

## Container Commands

Common Docker Compose commands:

```bash
# Build the container
docker-compose build

# Start the container in the background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down

# Rebuild and restart the container
docker-compose up --build

# Run a one-off command
docker-compose run --rm crystal_app crystal_app spec
```

## Additional Notes

- The application runs on port 3000 by default
- All application files are mounted to /app in the container
- Changes to Crystal files require a container restart
- The SQLite database persists in the mounted volume

# Links to learning crystal
- https://crystal-lang.org/reference/1.15/tutorials/index.html
- https://crystal-lang.org/reference/1.15/syntax_and_semantics/index.html
- https://kemalcr.com/guide/
- https://crystal-lang.org/reference/1.15/database/index.html

# Database schema
```sql
CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  price REAL NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```