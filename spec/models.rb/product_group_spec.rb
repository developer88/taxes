require 'spec_helper'
require 'rails_helper'

RSpec.describe ProductGroup, type: :model do

  subject { ProductGroup.new }
  let(:simple_product) { {name: 'Product1', price: 10.2} }
  let(:imported_product) { {name: 'ImportedProduct1', price: 20.2, imported: true} }

  describe '#add' do

    it 'should add an instance of Product class to list variable' do
      subject.add simple_product
      expect(subject.list.size).to eq(1)
      expect(subject.list.first.class).to eq(Product)
    end

  end

  describe '#to_hash' do

    before do 
      subject.add simple_product
    end

    it 'should return count param inside product objects for several identical products' do
      subject.add simple_product
      expect(subject.to_hash.size).to eq(2)
    end

    it 'should return products objects without count param' do
      expect(subject.to_hash.size).to eq(1)
      expect(subject.to_hash.class).to eq(Array)
    end

  end

  describe '#total' do

    it 'should get overall price of all goods in the cart' do
      subject.add simple_product
      subject.add simple_product
      subject.add imported_product
      expect(subject.list.size).to eq(3)
      expect(subject.total).to eq(simple_product[:price]*2 + imported_product[:price])
    end

  end

  describe '#taxes' do

    it 'should get overall taxes of all goods in the cart' do
      subject.add simple_product
      subject.add simple_product
      subject.add imported_product
      expect(subject.list.size).to eq(3)
      taxes = 1 # Lets say we know the result (avoid lots of calculation here)
      expect(subject.taxes).to eq(taxes)
    end

  end

  describe '7Pixel srl test' do

    context 'with data from the letter' do

      context 'Input 1' do

        before do
          subject.add({ name:'book', price:12.49 })
          subject.add({ name:'music CD', price: 14.99})
          subject.add({ name:'chocolate bar', price: 0.85})
        end

        it 'should properly calculate total price' do
          expect(subject.total).to eq(29.83)
        end

        it 'should properly calculate total taxes' do
          expect(subject.taxes).to eq(1.50)
        end

      end

      context 'Input 2' do

        before do
          subject.add({name: 'box of chocolates', price: 10.00, imported: true})
          subject.add({name: 'bottle of perfume', price: 47.50, imported: true})
        end

        it 'should properly calculate total price' do
          expect(subject.total).to eq(65.15)
        end

        it 'should properly calculate total taxes' do
          expect(subject.taxes).to eq(7.65)
        end

      end

      context 'Input 3' do

        before do
          subject.add({name: 'bottle of perfume', price: 27.99, imported: true})
          subject.add({name: 'bottle of perfume', price: 18.99})
          subject.add({name: 'packet of headache pills', price: 9.75})
          subject.add({name: 'box of chocolates', price: 11.25, imported: true})
        end

        it 'should properly calculate total price' do
          expect(subject.total).to eq(74.68)
        end

        it 'should properly calculate total taxes' do
          expect(subject.taxes).to eq(6.70)
        end

      end

    end

  end

end