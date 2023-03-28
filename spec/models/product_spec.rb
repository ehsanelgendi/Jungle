require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save without errors when all required fields are set' do
      category = Category.new(name: "Classic")
      product = Product.new(name: "Cactus", price: "200", quantity: 15, category: category)
      product.save!
      expect(product).to be_valid
    end

    it 'should be an error if name does not exist' do
      category = Category.new(name: "Classic")
      product = Product.new(name: nil, price: "200", quantity: 15, category: category)
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should be an error if price does not exist' do
      category = Category.new(name: "Classic")
      product = Product.new(name: "Cactus", price: nil, quantity: 15, category: category)
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should be an error if quantity does not exist' do
      category = Category.new(name: "Classic")
      product = Product.new(name: "Cactus", price: "200", quantity: nil, category: category)
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should be an error if quantity does not exist' do
      category = Category.new(name: "Classic")
      product = Product.new(name: "Cactus", price: "200", quantity: 15, category: nil)
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
