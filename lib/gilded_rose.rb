class GildedRose
  attr_reader :name, :days_remaining, :quality, :item

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    update_days_remaining!

    @item = Item.build(name: @name, days_remaining: @days_remaining, quality: @quality)
    @item.tick

    @days_remaining = item.days_remaining
    @name = item.name
    @quality = item.quality
  end

  def decrease_quality!
    @quality = @quality - 1
  end

  def increase_quality!
    @quality = @quality + 1
  end

  def update_days_remaining!
    @days_remaining -= 1 unless @name == "Sulfuras, Hand of Ragnaros"
  end

  class Item
    attr_reader :name, :days_remaining
    attr_accessor :quality

    def self.build(name:, days_remaining:, quality:)
      case name
      when 'Aged Brie'
        AgedBrie.new(name: name, days_remaining: days_remaining, quality: quality)
      when "Sulfuras, Hand of Ragnaros"
        HandOfRagnaros.new(name: name, days_remaining: days_remaining, quality: quality)
      when "Backstage passes to a TAFKAL80ETC concert"
        BackstagePasses.new(name: name, days_remaining: days_remaining, quality: quality)
      else
        new(name: name, days_remaining: days_remaining, quality: quality)
      end
    end

    def initialize(name:, days_remaining:, quality:)
      @name = name
      @days_remaining = days_remaining
      @quality = quality
    end

    def tick
      if days_remaining < 0
        decrease_quality!(by: 2)
      else
        decrease_quality!
      end
    end

    def increase_quality!(by: 1)
      new_quality = quality + by

      # Quality cannot exceed 50
      @quality = [ 50, new_quality ].min
    end

    def decrease_quality!(by: 1)
      new_quality = quality - by

      @quality = [ 0, new_quality ].max
    end
  end

  class BackstagePasses < Item
    def tick
      decrease_quality!(by: quality) and return if @days_remaining < 0

      increase_quality!
      increase_quality! if @days_remaining < 10
      increase_quality! if @days_remaining < 5
    end
  end

  class HandOfRagnaros < Item
    def quality
      80
    end

    def tick
    end
  end

  class AgedBrie < Item
    def tick
      return unless quality < 50

      if days_remaining < 0
        increase_quality!(by: 2)
      else
        increase_quality!
      end
    end
  end
end
