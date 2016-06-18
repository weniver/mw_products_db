User.create!(name: "Diego",
             email: "weniver@gmail.com",
             password: 'foobarbaz',
             password_confirmation: 'foobarbaz',
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             brands_attributes: [name: 'Papa Wolf'])

User.create!(name: "Ivonne",
            email: "iv@gmail.com",
            password: 'foobarbaz',
            password_confirmation: 'foobarbaz',
            admin: false,
            activated: true,
            activated_at: Time.zone.now,
            brands_attributes: [name: 'Mama Wolf'])

brand = Brand.second
15.times do
  name = Faker::Commerce.product_name
  brand.products.create!(name: name)
end

products = Product.take(10)
3.times do
  name = Faker::Book.title
  price = Faker::Commerce.price
  products.each { |product| product.categories.create!(name:  name,
                                                       price: price) }
end

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  brand = Faker::Company.name
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               brands_attributes: [name: brand])
end
