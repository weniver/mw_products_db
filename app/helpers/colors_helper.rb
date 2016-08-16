module ColorsHelper
  def hue_word(value_string)
    case value_string
    when '0'
      word = 'Blanco'
    when '1'
      word = 'Negro'
    when '2'
      word = 'Rojo'
    when '3'
      word = 'Naranja'
    when '4'
      word = 'Amarillo'
    when '5'
      word = 'Verde'
    when '6'
      word = 'Azul'
    when '7'
      word = 'Morado'
    when '8'
      word = 'Magenta'
    when '9'
      word = 'Café'
    when 'n'
      word = 'Neón'
    when 's'
      word = 'Especial'
    end
    return word
  end

  def tone_word(value_string)
    case value_string
    when '0'
      word = 'blancuzco'
    when '1'
      word = 'negruzco'
    when '2'
      word = 'rojizo'
    when '3'
      word = 'naranjoso'
    when '4'
      word = 'amarillento'
    when '5'
      word = 'verdoso'
    when '6'
      word = 'azulado'
    when '7'
      word = 'moradozo'
    when '8'
      word = 'magentozo'
    when '9'
      word = 'cafezoso'
    end
    return word
  end

  def darkness_word(value_string)
    case value_string
    when '0'
      word = 'blanqueado'
    when '1'
      word = 'muy aclarado'
    when '2'
      word = 'aclarado'
    when '3'
      word = 'ligeramente aclarado'
    when '4'
      word = 'saturado'
    when '5'
      word = 'sucio'
    when '6'
      word = 'ligeramente oscuro'
    when '7'
      word = 'oscuro'
    when '8'
      word = 'muy oscuro'
    when '9'
      word = 'ennegrecido'
    end
    return word
  end
end
