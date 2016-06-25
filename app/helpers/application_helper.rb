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
    current_user.nil? ? "Iniciar Sesión": current_user.brands.first.name
  end

  #Gets login_path if not logged in
  def logo_link_path
    current_user.nil? ? login_path : root_path
  end
end
