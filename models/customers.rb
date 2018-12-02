require_relative("../db/sql_runner.rb")
require_relative("./films.rb")
class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers_array = SqlRunner.run(sql)
    customers = customers_array.map {|customer| Customer.new(customer)}
    return customers
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql ="SELECT films.* FROM films INNER JOIN
    tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films_array = SqlRunner.run(sql, values)
    result = films_array.map {|film| Film.new(film)}
    return result
  end

  def bought_ticket(film)
    @funds -= film.price.to_i
  end

  def ticket_sale(film)
    bought_ticket(film)
    sql = "UPDATE customers SET funds = $1 WHERE id = $2"
    values = [@funds, @id]
    SqlRunner.run(sql, values)
  end

  def tickets_bought(film)
    sql = "SELECT COUNT(*) FROM tickets WHERE customer.id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def ticket_count()
    sql = "SELECT COUNT(*) FROM tickets WHERE customer_id = $1"
    values = [@id]
    ticket_hash = SqlRunner.run(sql, values)
    return ticket_hash[0]["count"].to_i
  end

#   SELECT Pupils.Name, Pupils.Parents, Marks.Subject, Marks.Mark
# FROM Pupils
# LEFT JOIN Marks ON Pupils.Name = Marks.PupilName


end
