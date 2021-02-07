require "./tictactoe"

describe Board do
  let(:board) { Board.new }
  describe "#display_board" do
    it "shows board on terminal" do
      allow(board).to receive(:display_board)
      board.display_board
    end
  end

  describe "#move_made" do
    it "checks if a player is chosing a quare that is occupied" do
      expect(board.move_made("a1", "X")).to eq(true)
    end
    it "returns false if square occupied" do
      allow(board.move_made("a1", "X"))
      expect(board.move_made("a1", "O")).to eq(false)
    end
  end

  describe "#winner_check" do
    let(:moves) { move_arr.each { |m| board.move_made(m, mark) }}
    context "if top row is X" do
      let(:mark) { "X" }
      let(:move_arr) { ["a1", "a2", "a3"] }
      it "returns true" do 
        moves
        expect(board.winner_check("X")).to eql("X")
      end
    end
  end
end

describe Player do
  let(:player) { Player.new("X") }
  describe "#make_a_move" do
    it "takes player input" do
      allow($stdin).to receive(:gets).and_return('a1')
      player_coordinate = $stdin.gets

      expect(player.make_a_move).to eql("a1")
    end
  end
end

describe Game do
  let(:game) { Game.new }
  describe "#play_round" do
    context "if player is winner" do
      it "returns winner" do
        allow(game).to receive(:player_mover) { "X" }
        expect(game.play_round).to eql(puts "X is the winner!")
      end
    end
  end
  describe "#player_mover" do
    it "returns player's"
end
