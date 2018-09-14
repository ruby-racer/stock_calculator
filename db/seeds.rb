user = User.create(email: 'user@example.com', password: 'password')
10.times do |n|
  user.stocks.create(name: "Stock ##{n}", unit_price: rand(20) * 1000,
                     duration: rand(10), interest: rand(25))
end
