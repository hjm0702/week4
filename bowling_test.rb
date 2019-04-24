require 'minitest/autorun'
require_relative 'bowling'

class GameTest < Minitest::Test

  def test_gutter_game
    game = Game.new
    20.times do
      game.roll 0
    end

    assert_equal 0, game.score
  end

  def test_all_ones
    game = Game.new
    20.times do
      game.roll 1
    end

    assert_equal 20, game.score
  end

  def test_one_spare
    game = Game.new
    game.roll 6
    game.roll 4
    game.roll 3
    17.times do
      game.roll 0
    end
    assert_equal 16, game.score
  end

  def test_one_strike
    game = Game.new
    game.roll 10
    game.roll 4
    game.roll 3
    16.times do
      game.roll 0
    end
    assert_equal 24, game.score
  end

  def test_perfect_game
    game = Game.new
    12.times do
      game.roll 10
    end
    assert_equal 300, game.score
  end

end
