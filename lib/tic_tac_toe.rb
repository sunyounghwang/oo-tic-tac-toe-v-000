class TicTacToe
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end
  
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end
  
  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index)
      display_board(board)
    else
      turn(board)
    end
  end
  
  def turn_count(board)
    turn_counter = 0
    board.each do |position|
      if position == "X" || position == "O"
        turn_counter += 1
      end
    end
    turn_counter
  end
  
  def current_player(board)
    turn_count(board).even? ? "X" : "O"
  end
  
  def won?(board)
    WIN_COMBINATIONS.each do |combo|
      if combo.all? {|index| board[index] == "X"}
        return combo
      elsif combo.all? {|index| board[index] == "O"}
        return combo
      end
    end
    return false
  end
  
  def full?(board)
    board.all? {|position| position_taken?(board, board.index(position))}
  end
  
  def draw?(board)
    !won?(board) && full?(board)
  end
  
  def over?(board)
    won?(board) || draw?(board) || full?(board)
  end
  
  def winner(board)
    if won?(board)
      winning_index = won?(board)[0]
      return board[winning_index]
    end
  end
end
