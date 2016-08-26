User.create!(name: "Diego",
             email: ENV["USER1_EMAIL"],
             password: ENV["USER1_PASS"],
             password_confirmation: ENV["USER1_PASS"],
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             brands_attributes: [name: 'Papa Wolf'])

User.create!(name: "Ivonne",
            email: ENV["USER2_EMAIL"],
            password: ENV["USER2_PASS"],
            password_confirmation: ENV["USER2_PASS"],
            admin: false,
            activated: true,
            activated_at: Time.zone.now,
            brands_attributes: [name: 'Mama Wolf'])

productos = {  'Mandil'        => ['Estandar', 'Lady','Marchante'],
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
          'No'=> ['aplica'] }

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
              'Pollos' => 'POLL',
              'Peces' => 'PEZ',
              'Varios' => 'VAR',
              'n/a' => 'n/a' }

estampados.each { |estampado, codigo|
  Pattern.create!(name: estampado,
                  code: codigo,
                  brand_id: 2)
}
