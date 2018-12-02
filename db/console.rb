require('pry')
require_relative('../models/customers.rb')
require_relative('../models/films.rb')
require_relative('../models/tickets.rb')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'Harold Wiezenberg',
  'funds' => "100",
  })

  customer1.save()

customer2 = Customer.new({
  'name' => 'Turin Hemmingway',
  'funds' => '70',
  })

  customer2.save()

customer3 = Customer.new({
  'name' => 'Jose Aldo',
  'funds' => "50",
  })

  customer3.save()

customer4 = Customer.new({
  'name' => 'Jon Stark',
  'funds' => "20",
  })

  customer4.save()

film1 = Film.new({
  'title' => 'Ex Machina',
  'price' => "20"
  })
  film1.save()

film2 = Film.new({
  'title' => 'Venom',
  'price' => "15"
  })
  film2.save()

film3 = Film.new({
  'title' => 'Independence Day',
  'price' => "10"
  })
  film3.save()

film4 = Film.new({
  'title' => 'Black Hawk Down',
  'price' => "12"
  })
  film4.save


  ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id});
  ticket1.save()

  ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id});
  ticket2.save()

  ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id});
  ticket3.save()

  ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film4.id});
  ticket4.save()

  ticket5 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film1.id});
  ticket5.save()

  customer1.ticket_sale(film1)
  customer2.ticket_sale(film2)
  customer1.ticket_count()
  film1.film_count()
  # film1.film_count()

  all_films = Film.all()
  all_customers = Customer.all()
  all_tickets = Ticket.all()
binding.pry
nil
