def populate(db, server, weight=1)
  db.execute_batch('INSERT INTO servers(upstream, weight) VALUES (?, ?);', server, weight)
end

db = SQLite3::Database.new('/var/lib/apache2/dyn-proxy.db')
db.execute_batch <<SQL
  CREATE TABLE servers (
    upstream VARCHAR(255),
    weight INTEGER
  );
SQL
populate db, "http://127.0.0.1:4567", 6
populate db, "http://127.0.0.1:4568", 3
populate db, "http://127.0.0.1:4569", 1

res = db.execute('SELECT COUNT(*) FROM servers;')
if res.next[0] == 3
  puts "OK!"
end