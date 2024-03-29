#!/usr/bin/env ruby

class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],

    [0,3,6],
    [1,4,7],
    [2,5,8],

    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, value = "X")
    @board[index] = value
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != nil
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    counter = 0
    @board.each do |element|
      if (element == "X") || (element == "O")
        counter += 1
      end
    end
    counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combination|
      win_index1 = win_combination[0]
      win_index2 = win_combination[1]
      win_index3 = win_combination[2]

      ( @board[win_index1] == "X" && @board[win_index2] == "X" && @board[win_index3] == "X" ) ||
      ( @board[win_index1] == "O" && @board[win_index2] == "O" && @board[win_index3] == "O" )

    end
  end

  def full?
    @board.all? do |element|
      position_taken?(@board.index(element))
    end
  end

  def draw?
    !(!!won?) && full?
  end

  def over?
    !!won? || draw? || full?
  end

  def winner
    !!won? ? @board[won?[0]] : nil
  end

  def turn
    puts "Please enter 1-9: "
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player())
      display_board
    else
      turn
    end
  end

  def play
    while !over?
  	   turn
    end

    if !!won?
      puts "Congratulations #{winner}!"
    elsif full?
      puts "Cat's Game!"
    end

  end

end

TicTacToe1 = TicTacToe.new
TicTacToe1.play
