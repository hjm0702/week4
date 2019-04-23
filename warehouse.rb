require 'minitest/autorun'
require 'json'
require 'mocha/minitest'

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
  end

  def generate_shipments
    @shipments = []
    # Naive implementation: one box per item
    @shopping_cart.products.each do |product|
      box = Box.new
      box.size = "Large"
      box.products = [product]
      box.tracking_number = generate_tracking_number
      @shipments.push(box)
    end
  end

  def generate_tracking_number
    return "1Z#{rand(10000000..99999999)}"
  end

end


class ShoppingCartTest < Minitest::Test

  def test_calculate_total
    cart = ShoppingCart.new

    cart.add('B01DFKC2SO')
    cart.add('B01JP436TS')

    assert_equal 49.99+108.00, cart.total
  end

end

class WarehouseTest < Minitest::Test

  def test_one_shipment_per_item
    cart = ShoppingCart.new
    cart.add('B01DFKC2SO')
    cart.add('B01JP436TS')

    warehouse = WarehouseOrder.new(cart)
    warehouse.generate_shipments

    assert_equal 2, warehouse.shipments.length

  end

  def test_tracking_number_applied_to_box
    cart = ShoppingCart.new
    cart.add('B01DFKC2SO')
    warehouse = WarehouseOrder.new(cart)
    warehouse.expects(:generate_tracking_number).returns("1Z123456789")

    warehouse.generate_shipments
  end
end
