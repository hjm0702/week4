require 'minitest/autorun'
require 'json'
# require 'mocha/minitest'

class ShoppingCart

  attr_accessor :products
  attr_accessor :total

  def initialize
    self.products = []
    self.total = 0.0
  end

  def add(sku)
    catalog = JSON.parse(open("catalog.json").read)
    product = catalog.detect { |item| item["ASIN"] == sku }
    if !product
      raise "SKU not found."
    end
    self.products.push(product)
    self.total += product['price'].to_f
  end
end

class Box
  attr_accessor :size
  attr_accessor :tracking_number
  attr_accessor :products
end

class WarehouseOrder

  attr_accessor :shopping_cart
  attr_accessor :shipments

  def initialize(cart)
    @shopping_cart = cart
    generate_shipments
  end

  def generate_shipments
    # Naive implementation: One box per item
  end

end


class ShoppingCartTest < Minitest::Test

  def test_calculate_total
  end

end

class WarehouseTest < Minitest::Test

  def test_one_shipment_per_item

  end

  def test_tracking_number_applied_to_box

  end
end
