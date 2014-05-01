require 'rspec'
require 'conway'

describe Conway do
  it 'will create an instance of the Conway game' do
    new_game = Conway.new(3)
    new_game.should be_an_instance_of Conway
  end

  it 'will create spaces for the grid' do
    new_game = Conway.new(3)
    new_game.spaces.length.should eq 9
  end

  describe '#toggle' do
    it 'will take a given number (1-9) and turn it into an * showing that it is live... *s will not be changed into Xs when the board resets.' do
      new_game = Conway.new(3)
      new_game.toggle([2])
      new_game.spaces[2].should eq '*'
    end
  end

  describe '#board_reset' do
    it 'will take the spaces array and turn them all into -\'s for dead cells to start the game' do
      new_game = Conway.new(3)
      new_game.toggle([0,8])
      new_game.board_reset
      new_game.spaces.should eq ['*','-','-','-','-','-','-','-','*']
    end
  end

  describe '#check_live_neighbors' do
    it 'will check the surrounding cells of a given position, and count how many around it are alive' do
      new_game = Conway.new(3)
      new_game.toggle([2,4,6])
      new_game.board_reset
      new_game.check_live_neighbors(4).should eq [2,6]
    end

    it 'will check the surrounding cells of a given position, and count how many around it are alive' do
      new_game = Conway.new(3)
      new_game.toggle([0,1,2,4,7])
      new_game.board_reset
      new_game.check_live_neighbors(3).should eq [0,1,4,7]
    end

    it 'will check the surrounding cells of a given position, and count how many around it are alive' do
      new_game = Conway.new(3)
      new_game.toggle([2,4,6])
      new_game.board_reset
      new_game.check_live_neighbors(7).should eq [4,6]
    end
  end

  describe 'make_future_array' do
    it 'will push cells that meet the rules to be active in the next generation into an array. (if dead and neighborcount = 3 OR if alive and neighborcount = 2 or 3.'  do
      new_game = Conway.new(3)
      new_game.toggle([0,1,2])
      new_game.board_reset
      new_game.make_future_array
      new_game.future_array.should eq [1,4]
  end
end

end


