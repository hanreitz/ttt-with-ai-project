require 'pry'
class Game
    attr_accessor :board, :player_1, :player_2
    WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        board.turn_count.to_i%2 == 0 ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if board.cells[combo[0]] == board.cells[combo[1]] && 
            board.cells[combo[1]] == board.cells[combo[2]] && 
            board.taken?(combo[0]+1)    
                return combo
            end
        end  
    end

    def draw? 
        board.full? & !won?
    end

    def over?
        draw? || won?
    end

    def winner
        won? ? board.cells[won?[0]] : nil
    end

    def turn
        player = current_player
        input = player.move(board)
        if board.valid_move?(input)
            board.update(input, player)
        else
            turn
        end #need to put in board display functionality
        board.display
    end

    def play
        turn until over?
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
    end

end