## Docker experiment

This is a small experimental setup for learning Docker, compose, and MySQL together.

- `docker-compose.yml` runs:
  - `mysql` database
  - `app` service built from a simple Python container

- `init.sql` creates a demo database and a sample table.
- `app.py` connects to MySQL, queries the demo table, and shows a plain text result.

### Run

<pre>
cd docker
docker compose up --build
</pre>

Then open http://localhost:8080

### Notes

- This is only for local testing and learning.
- The app retries a few times until MySQL becomes ready.
- The SQL file is loaded automatically by the MySQL image on startup.
