class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    update_days_remaining!

    if @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
      if @quality > 0
        if @name != "Sulfuras, Hand of Ragnaros"
          decrement_quality!
        end
      end
    else
      if @quality < 50
        increment_quality!

        if @name == "Backstage passes to a TAFKAL80ETC concert"
          if @days_remaining < 10
            if @quality < 50
              increment_quality!
            end
          end

          if @days_remaining < 5
            if @quality < 50
              increment_quality!
            end
          end
        end
      end
    end

    if @days_remaining < 0
      if @name != "Aged Brie"
        if @name != "Backstage passes to a TAFKAL80ETC concert"
          if @quality > 0
            if @name != "Sulfuras, Hand of Ragnaros"
              decrement_quality!
            end
          end
        else
          @quality = @quality - @quality
        end
      else
        if @quality < 50
          increment_quality!
        end
      end
    end
  end

  def decrement_quality!
    @quality = @quality - 1
  end

  def increment_quality!
    @quality = @quality + 1
  end

  def update_days_remaining!
    @days_remaining -= 1 unless @name == "Sulfuras, Hand of Ragnaros"
  end
end
