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

productos = {  'Mandil'        => ['Pollos','Peces', 'Lady','Marchante'],
               'Relleno'        => ['Grande','Chico'],
               'Cojín'         => ['Grande','Chico','Gato','Casita'],
               'Mochila'        => ['Estandar'],
               'Cartera'        => ['Mediana','Mini'],
               'Funda'          => ['iPad','Laptop','Kindle'],
               'Bolsa'          => ['Alta', 'Ancha', 'Tote', 'Weekend Bag',
                                     'Satchel'],
               'Cosmetiquera'   => ['Grande','Chica'],
               'Estuche'        => ['XL', 'Estandar'],
               'Lapicero'       => ['Estandar'],
               'Monedero'       => ['Mini', 'Largo', 'Estandar'] }

brand = Brand.second
productos.each do |producto,categorias|
  last_product = brand.products.create!(name: producto)
  categorias.each do |categoria|
    last_product.categories.create!(name:  categoria,
                                    price: 1)
  end
end

telas = { 'Algodón' => ['Negro', 'Gris Oxford', 'Gris Perla', 'Rojo', 'Blanco'],
          'Lino'    => ['Verde'],
          'Popelina'=> ['Azul','Negra'],
          'n/a'=> ['n/a'] }

telas.each { |tela,colores|
  colores.each {|color|
    Fabric.create!(material: tela,
                   color: color,
                   brand_id: 2)
  }
}

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
              'Gansos' => 'GANS',
              'Varios' => 'VAR',
              'n/a' => 'n/a' }

estampados.each { |estampado, codigo|
  Pattern.create!(name: estampado,
                  code: codigo,
                  brand_id: 2)
}

color_sampler = ('0'..'9').to_a
color_specials = color_sampler + ['n','s']
20.times do
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
  sold = Faker::Boolean.boolean
  products.each { |product| product.categories.first.units.create!(quantity: 4,
                                                                   colors: '123',
                                                                   product_id: product.id,
                                                                   fabric_id: fabric_id,
                                                                   color_id: color_id,
                                                                   pattern_id: pattern_id,
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
10.times do |n|
   name = Faker::Pokemon.name
   address = Faker::Address.city + ', ' + Faker::Address.street_name+ ', ' + Faker::Address.street_address+ ', '
   rfc = 'VECJ880326XXX'
   phone = Faker::PhoneNumber.cell_phone
   email = Faker::Internet.email
   Store.create!(name: name,
                 address: address,
                 rfc: rfc,
                 phone: phone,
                 email: email)
end
