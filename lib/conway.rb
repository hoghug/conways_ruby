class Conway
  attr_reader :grid_size, :spaces, :neighbor_count, :future_array, :next_gen

  def initialize(grid_size)
    @grid_size = grid_size
    @spaces = Array(0...(grid_size**2))
    @next_gen
  end

  def toggle(live_cells)
    live_cells.each do |num|
      @spaces.map! {|space| space == num ? '*' : space }
    end
  end

  def board_reset
    @spaces.map! {|space| space != '*' ? '-' : '*' }
  end

  def check_live_neighbors(cell)
    rows = [@grid_size * -1, 0, @grid_size]
    cols = [-1, 0, 1]
    if cell % @grid_size == 0 #left edge
      cols.delete(-1)
    elsif cell % grid_size == @grid_size - 1 #right edge
      cols.delete(1)
    end

    live_neighbors = []

    rows.each do |r|
      cols.each do |c|
        if spaces[cell + (r + c)] == '*' && cell + r + c != cell
          live_neighbors << cell + (r + c)
        end
      end
    end

    live_neighbors
  end

  def make_future_array(current_gen)
    @future_array = Array(0...(grid_size**2))

    current_gen.each_with_index do |space, index|
      if space == "*"
        if check_live_neighbors(index).length == 2 || check_live_neighbors(index).length == 3
          @future_array[index] = "*"
        end
      else
        if check_live_neighbors(index).length == 3
          @future_array[index]  = "*"
        end
      end
    end
          # puts @future_array
    @future_array.map! { |num| num != '*' ? '-' : '*' }
    @spaces = @future_array
    @future_array
  end
end
