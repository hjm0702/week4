class Game

  attr_accessor :total
  attr_accessor :rolls

  def initialize
    self.total = 0
    self.rolls = []
  end

  def roll(pins_knocked_down)
    self.rolls.push(pins_knocked_down)
  end

  def strike?(rollIndex)
    return self.rolls[rollIndex] == 10
  end

  def spare?(rollIndex)
    return self.rolls[rollIndex] + self.rolls[rollIndex + 1] == 10
  end

  def score
    rollIndex = 0
    self.total = 0
    10.times do
      if strike?(rollIndex)
        self.total += 10 + self.rolls[rollIndex + 1] + self.rolls[rollIndex + 2]
        rollIndex += 1
      elsif spare?(rollIndex)
        self.total += 10 + self.rolls[rollIndex + 2]
        rollIndex += 2
      else
        self.total += self.rolls[rollIndex] + self.rolls[rollIndex + 1]
        rollIndex += 2
      end
    end
    return self.total
  end
end
