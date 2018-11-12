class Tamagotchi
  attr_reader :health, :hungry, :energiness, :cleanliness

  STEP = 10
  MIN = 0
  MAX = 100

  def initialize
    self.health = 100
    self.hungry = 50
    self.energiness = 100
    self.cleanliness = 50
  end

  def feed
    self.hungry -= STEP
    self.health += STEP
    self.energiness += STEP
  end

  def clean
    self.cleanliness += STEP
    self.energiness -= STEP
    self.health -= STEP if self.energiness == MIN
  end

  def sleep
    self.energiness += STEP
    self.cleanliness -= STEP
    self.hungry += STEP
    self.health -= STEP if self.cleanliness == MIN
    self.health -= STEP if self.hungry == MAX
  end

  def dead?
    self.health.zero?
  end

  private

  def in_range(value)
    value = MIN if value < MIN
    value = MAX if value > MAX
    value
  end

  def health=(value)
    @health = in_range(value)
  end

  def hungry=(value)
    @hungry = in_range(value)
  end

  def energiness=(value)
    @energiness = in_range(value)
  end

  def cleanliness=(value)
    @cleanliness = in_range(value)
  end
end
