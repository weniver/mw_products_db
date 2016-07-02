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
65.times do
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

products = Product.all
products.each do |product|
  unless product.categories.any?
    name = product.name
    price = Faker::Commerce.price
    product.categories.create!(name:  name,
                               price: price)
  end
end

5.times do
  material = ['Algodón', 'Lino', 'Seda'].sample
  color = Faker::Color.color_name
  Fabric.create!(material: material,
                 color: color)
end

categories = Category.all
20.times do
  product_code = SecureRandom.base64
  ink_color = Faker::Color.color_name
  print_style = Faker::Team.creature
  fabric_id = rand(1..5)
  price_modifier = rand(1.0..2.0)
  sold = Faker::Boolean.boolean
  categories.each { |category| category.units.create!(product_code: product_code,
                                                      ink_color: ink_color,
                                                      print_style: print_style,
                                                      price_modifier: price_modifier,
                                                      sold: sold,
                                                      fabric_id: fabric_id) }

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
