module ProductsHelper
  def category_is_product_name(category)
    cat_name = category.name
    product_name = category.product.name
    return cat_name == product_name ? true : false
  end
end
