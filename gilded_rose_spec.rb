require 'rspec/autorun'
require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.describe GildedRose do
  describe 'reduce item variables' do
    # let(:item) { [Item.new('foo', 5, 10)] }
    it 'does not change the name' do
      item = [Item.new('foo', 5, 10)]
      GildedRose.new(item).update_quality()
      expect(item[0].name).to eq('foo')
    end

    it 'reduce sell_in' do
      item = [Item.new('foo', 5, 10)]
      GildedRose.new(item).update_quality()
      expect(item[0].sell_in).to eq(4)
    end

    it 'reduce quality' do
      item = [Item.new('foo', 5, 10)]
      GildedRose.new(item).update_quality()
      expect(item[0].quality).to eq(9)
    end

    it 'reduce sell_in for Conjured' do
      item = [Item.new('Conjured', 5, 10)]
      GildedRose.new(item).update_quality()
      expect(item[0].sell_in).to eq(4)
    end

    it 'reduce quality for Conjured' do
      item = [Item.new('Conjured', 5, 10)]
      GildedRose.new(item).update_quality()
      expect(item[0].quality).to eq(8)
    end

  end

  describe 'features' do
    it 'Once the sell by date has passed, Quality degrades twice as fast' do
      item = [Item.new('foo', 1, 10)]
      GildedRose.new(item).update_quality()
      expect(item[0].quality).to eq(5)
    end

    it 'The Quality of an item is never negative 1' do
      expect{(Item.new('foo', 0, -10)).to raise_error(Errors::ArgumentError)}
    end

    it 'The Quality of an item is never negative 2' do
      item = [Item.new('foo', 1, 0)]
      GildedRose.new(item).update_quality()
      expect(item[0].quality).to eq(0)
    end

    describe 'Aged Brie' do
      it 'Aged Brie actually increases in Quality' do
        item = [Item.new('Aged Brie', 15, 15)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(16)
      end
      it 'sellin less than 5' do
        item = [Item.new('Aged Brie', 2, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(13)
      end
      it 'sellin equal than 5' do
        item = [Item.new('Aged Brie', 5, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(13)
      end
      it 'sellin less than 10' do
        item = [Item.new('Aged Brie', 8, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(12)
      end
      it 'sellin equal than 10' do
        item = [Item.new('Aged Brie', 10, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(12)
      end
      it 'drops to zero' do
        item = [Item.new('Aged Brie', 1, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(0)
      end
      it 'drops to zero' do
        item = [Item.new('Aged Brie', 0, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(0)
      end
    end

    it 'The Quality of an item is never more than 50' do
      item = [Item.new('Aged Brie', 10, 50)]
      GildedRose.new(item).update_quality()
      expect(item[0].quality).to eq(50)
    end

    describe 'Sulfuras, being a legendary item' do
      it 'never has to be sold' do
        item = [Item.new('Sulfuras', 10, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].sell_in).to eq(10)
      end
      it 'never has to decrease quality' do
        item = [Item.new('Sulfuras', 10, 10)]
        GildedRose.new(item).update_quality()
        expect(item[0].quality).to eq(10)
      end
    end
  end
end
