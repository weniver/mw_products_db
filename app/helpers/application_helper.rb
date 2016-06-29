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

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
