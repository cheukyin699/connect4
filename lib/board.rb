class Board
  attr_accessor :g

  def initialize
    # 7 columns; 6 rows
    # Bottom left one represented by [0][0]
    # Values are:
    #  0 - blank
    #  1 - player 1
    #  2 - player 2
    @g = Array.new(7)  {Array.new(6, 0)}
  end

  def put(c, v)
    # c - column
    # v - value [1,2]
    success = false
    for i in 0...@g[c].length
      if @g[c][i] == 0
        @g[c][i] = v
        return i
      end
    end

    raise "column is full" unless success
  end

  def check(x, y)
    c = @g[x][y]
    m = [check_horizontal(x,y), check_vertical(x,y), check_diagonal(x,y)].max

    if m >= 4
      c
    elsif not @g.any? {|a| a.any? {|i| i == 0}}
      -2
    else
      0
    end
  end

  def to_s
    s = ""
    for y in 0...6
      for x in 0...7
        s += @g[x][5-y].to_s
      end
      s += "\n"
    end
    s
  end

  private
  def check_horizontal(x, y)
    matches = 0
    c = @g[x][y]

    for i in 1..x
      if @g[x-i][y] == c
        matches += 1
      else
        break
      end
    end

    for i in x...@g.length
      if @g[i][y] == c
        matches += 1
      else
        break
      end
    end

    matches
  end

  private
  def check_vertical(x, y)
    matches = 0
    c = @g[x][y]

    for i in 1..y
      if @g[x][y-i] == c
        matches += 1
      else
        break
      end
    end

    for i in y...@g[x].length
      if @g[x][i] == c
        matches += 1
      else
        break
      end
    end

    matches
  end

  private
  def check_diagonal(x, y)
    matches_a, matches_b = 0, 0
    c = @g[x][y]

    # Top left to bottom right; offset [-1,+1] [+1,-1]
    tlbr_up_offsets = (1..x).to_a.zip((y+1...@g[x].length).to_a)
    for i,j in tlbr_up_offsets.delete_if {|i| i.include? nil}
      if @g[x-i][j] == c
        matches_a += 1
      else
        break
      end
    end

    tlbr_dwn_offsets = (x...@g.length).to_a.zip((0..y).to_a)
    for i,j in tlbr_dwn_offsets.delete_if {|i| i.include? nil}
      if @g[i][y-j] == c
        matches_a += 1
      else
        break
      end
    end

    # Bottom left to top right; offset [-1,-1] [+1,+1]
    bltr_dwn_offsets = (1..x).to_a.zip((1..y).to_a)
    for i,j in bltr_dwn_offsets.delete_if {|i| i.include? nil}
      if @g[x-i][y-j] == c
        matches_b += 1
      else
        break
      end
    end

    bltr_up_offsets = (x...@g.length).to_a.zip((y...@g[x].length).to_a)
    for i,j in bltr_up_offsets.delete_if {|i| i.include? nil}
      if @g[i][j] == c
        matches_b += 1
      else
        break
      end
    end

    puts "#{matches_a}, #{matches_b}"
    [matches_a, matches_b].max
  end
end
