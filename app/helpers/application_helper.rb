module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Mama Wolf"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  #and the brand name of the user to the layout
  def brand_name_logo(name_of_the_brand = '')
    default = 'Tu marca aquí'
    if name_of_the_brand.empty?
      default
    else
      name_of_the_brand
    end
  end

  #Get the brand name if there is a user
  def get_brand_name
    brand_name = current_user.nil? ? "Tu marca aquí"
                                   : current_user.brands.first.name
  end
end
