
class Board
  def initialize
    @board_hash = {
    "a1" => "[ ]", "a2" => "[ ]", "a3" => "[ ]",
    "b1" => "[ ]", "b2" => "[ ]", "b3" => "[ ]",
    "c1" => "[ ]", "c2" => "[ ]", "c3" => "[ ]"
    }
  end
  
  def display_board
    puts (
      "
      . 1  2  3
      A#{@board_hash["a1"]}#{@board_hash["a2"]}#{@board_hash["a3"]}
      B#{@board_hash["b1"]}#{@board_hash["b2"]}#{@board_hash["b3"]}
      C#{@board_hash["c1"]}#{@board_hash["c2"]}#{@board_hash["c3"]}
      "
    )
  end

  def move_made(player_coordinate, player_mark)
    if @board_hash.any? { |key, item| player_coordinate == key && item == "[ ]" }
      @board_hash[player_coordinate] = "[#{player_mark}]"
      return true
    else
      return false
    end
  end

  def winner_check(player)
    win_array = [
      [@board_hash["a1"], @board_hash["a2"], @board_hash["a3"]],
      [@board_hash["b1"], @board_hash["b2"], @board_hash["b3"]],
      [@board_hash["c1"], @board_hash["c2"], @board_hash["c3"]],
      [@board_hash["a1"], @board_hash["b2"], @board_hash["c3"]],
      [@board_hash["c1"], @board_hash["b2"], @board_hash["a3"]],
      [@board_hash["a1"], @board_hash["b1"], @board_hash["c1"]],
      [@board_hash["a2"], @board_hash["b2"], @board_hash["c2"]],
      [@board_hash["a3"], @board_hash["b3"], @board_hash["c3"]]
    ]
    win_array.each do |row|
      return player if row == ["[#{player.mark}]"]*3
    end
    false
  end

end

class Player
  attr_accessor :mark
  def initialize(mark)
    @mark = mark
  end

  def make_a_move
    puts "Where do you want to put your #{@mark}?"
    player_coordinate = gets.chomp
  end

end

class Game
  def initialize
    @round_1 = Board.new
    
    @player_1 = Player.new("X")
    @player_2 = Player.new("O")
  end

  def play_round
    is_player_1_turn = true
    winner = false

    while !winner
      @round_1.display_board
      if is_player_1_turn
        is_player_1_turn = false
        player = @player_1
      else
        is_player_1_turn = true
        player = @player_2
      end

      player_mover(player)
      winner = player_winner(player)
    end
  end
  
  private 

  def player_mover(player)
    move_ok = false
    while move_ok == false
      players_move = player.make_a_move
      move_ok = @round_1.move_made(players_move, player.mark)
      puts "Incorrect move: try again" if move_ok == false
    end
  end

  def player_winner(player)
    winner = @round_1.winner_check(player)
    return false if !winner
    game_over(player)
    true    
  end

  def game_over(player)
    @round_1.display_board
    puts "#{player.mark} is the winner!"
  end
  
end

# game1 = Game.new

# game1.play_round
