require_relative('../db/sql_runner.rb')
require_relative('./customers.rb')
require_relative('./films.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets_array = SqlRunner.run(sql)
    tickets = tickets_array.map {|ticket| Ticket.new(ticket)}
    return tickets
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tickets SET (@customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@id]
    customer_hash = SqlRunner.run(sql, values)[0]
    customer = Customer.new(customer_hash)
    return customer
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@id]
    film_hash = SqlRunner.run(sql, values)[0]
    films = Film.new(film_hash)
    return films
  end



  
end
