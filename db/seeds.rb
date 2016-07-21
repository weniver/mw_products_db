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
                 color: color,
                 brand_id: 2)
end

estampados = {'Twitcher' => 'TWIT',
              'Twitcher Mini' => 'TWMI',
              'Casita Nochtototl' => 'TOTL',
              'Wolfi' => 'WOLF',
              'Plumifero' => 'PLUM',
              'Saeta' => 'SAET',
              'Espiguilla' => 'ESPI',
              'Primavera' => 'PRIM',
              'Flower' => 'FLOR',
              'Señor Gatucho' => 'SRGA',
              'Wolfi Pet' => 'WPET',
              'Casita Grande' => 'CASA',
              'Jardín' => 'JARD',
              'Stars' => 'STAR',
              'Manchas' => 'MANC',
              '7 gatos' => '7GAT',
              'Gansos' => 'GANS' }

estampados.each { |estampado, codigo|
  Pattern.create!(name: estampado,
                  code: codigo,
                  brand_id: 2)
}

color_sampler = ('0'..'9').to_a
color_specials = color_sampler + ['n','s']
5.times do
  hue = color_specials.sample
  tone = color_sampler.sample
  darkness = color_sampler.sample
  Color.create!(hue: hue,
                tone: tone,
                darkness: darkness)
end

products = Product.all
colors = Color.ids
patterns = Pattern.ids
fabrics = Fabric.ids
20.times do
  fabric_id = fabrics.sample
  color_id =  colors.sample
  pattern_id = patterns.sample
  product_id = products.sample
  price_modifier = rand(1.0..2.0)
  sold = Faker::Boolean.boolean
  products.each { |product| product.categories.first.units.create!(quantity: 4,
                                                                   colors: '123',
                                                                   product_id: product.id,
                                                                   fabric_id: fabric_id,
                                                                   color_id: color_id,
                                                                   pattern_id: pattern_id,
                                                                   price_modifier: price_modifier,
                                                                   sold: sold) }

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
