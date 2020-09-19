
class Board
  attr_accessor :coordinate_hash
  def initialize
    @coordinate_hash = {
    "a1" => "[ ]", "a2" => "[ ]", "a3" => "[ ]",
    "b1" => "[ ]", "b2" => "[ ]", "b3" => "[ ]",
    "c1" => "[ ]", "c2" => "[ ]", "c3" => "[ ]"
    }
  end
  
  def generate_board
    puts (
      "
      . 1  2  3
      A#{@coordinate_hash["a1"]}#{@coordinate_hash["a2"]}#{@coordinate_hash["a3"]}
      B#{@coordinate_hash["b1"]}#{@coordinate_hash["b2"]}#{@coordinate_hash["b3"]}
      C#{@coordinate_hash["c1"]}#{@coordinate_hash["c2"]}#{@coordinate_hash["c3"]}
      "
    )
  end

  def move_made(player_coordinate, player_mark)
    if @coordinate_hash.any? { |key, item| player_coordinate == key && item == "[ ]" }
      @coordinate_hash[player_coordinate] = "[#{player_mark}]"
      return true
    else
      return false
    end
  end

  def winner_check(mark)
    win_array = [
      [@coordinate_hash["a1"], @coordinate_hash["a2"], @coordinate_hash["a3"]],
      [@coordinate_hash["b1"], @coordinate_hash["b2"], @coordinate_hash["b3"]],
      [@coordinate_hash["c1"], @coordinate_hash["c2"], @coordinate_hash["c3"]],
      [@coordinate_hash["a1"], @coordinate_hash["b2"], @coordinate_hash["c3"]],
      [@coordinate_hash["c1"], @coordinate_hash["b2"], @coordinate_hash["a3"]],
      [@coordinate_hash["a1"], @coordinate_hash["b1"], @coordinate_hash["c1"]],
      [@coordinate_hash["a2"], @coordinate_hash["b2"], @coordinate_hash["c2"]],
      [@coordinate_hash["a3"], @coordinate_hash["b3"], @coordinate_hash["c3"]]
    ]
    winner = [false, 0]
    win_array.each do |item|
      if item == ["[#{mark}]"]*3
        winner[0] = true
        winner[1] = mark
      end
    end
    return winner
  end
end

class Player
  attr_accessor :name, :mark
  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def make_a_move
    puts "Where do you want to put your #{@mark}?"
    player_coordinate = gets.chomp
    return player_coordinate
  end
end

class Game
  def initialize
    @game_name = "round 1"
  end

  def start_game
    @round_1 = Board.new
    @round_1.generate_board 
    
    @player_1 = Player.new("joe", "X")
    @player_2 = Player.new("bob", "O")
  end

  def play_round
    is_player_1_turn = true
    winner = [false, 0]
    while winner[0] == false 
      if is_player_1_turn
        is_player_1_turn = false
        winner = player_move(@player_1)
      else
        is_player_1_turn = true
        winner = player_move(@player_2)
      end
    end
    puts "#{winner[1]} is the winner!" 
  end

  def player_move(player)
    move_confirm = false
    while move_confirm == false
      players_move = player.make_a_move
      move_confirm = @round_1.move_made(players_move, player.mark)
      if move_confirm == true
        @round_1.generate_board
        winner = @round_1.winner_check(player.mark)
        return winner
      else 
        puts "Incorrect move: try again"
      end
    end
  end
end

game1 = Game.new
game1.start_game
game1.play_round
