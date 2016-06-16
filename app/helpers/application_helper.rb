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

  #Get the brand name if there is a user
  def get_brand_name
    brand_name = current_user.nil? ? "Tu marca aquí"
                                   : current_user.brands.first.name
  end
end
