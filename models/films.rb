require_relative('../db/sql_runner.rb')
require_relative('./customers.rb')
class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films_array = SqlRunner.run(sql)
    films = films_array.map {|film| Film.new(film)}
    return films
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    customers_array = SqlRunner.run(sql, values)
    result = customers_array.map {|customer| Customer.new(customer)}
    return result
  end

  def film_count()
    sql = "SELECT COUNT(*) FROM tickets WHERE film_id = $1"
    values = [@id]
    ticket_hash = SqlRunner.run(sql, values)
    return ticket_hash[0]["count"].to_i
  end
end
