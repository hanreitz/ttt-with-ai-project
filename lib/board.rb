class Board
    attr_accessor :cells
    
    def initialize
        #see private methods
        empty_board
    end

    def reset!
        #used a private method to handle this because it's the same as initialize
        empty_board
    end

    def display
        #renders the board in a user-friendly way
        #there has to be a better way to code this
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "------------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "------------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(input)
        #renders the value of the board at the position requested
        @cells[input.to_i-1]
    end

    def full?
        #checks that there are no empty cells
        @cells.none? {|cell| cell == " "}
    end

    def turn_count
        #checks the number of cells occupied by any player token
        @cells.count {|cell| cell == "X" || cell == "O"}
    end

    def taken?(input)
        #checks whether the desired cell has any player token
        position(input) == "X" || position(input) == "O"
    end

    def valid_move?(input)
        #checks that the input is in the range 1-9
        #checks that the cell is NOT taken
        input.to_i.between?(1,9) && !taken?(input)
    end

    def update(input, player)
        #checks for a valid move
        #places the player's token in the cell if valid
        #might need to rewrite this to not have the horrible input.to_i-1 thing
        valid_move?(input) ? @cells[input.to_i-1] = player.token : nil
    end

    private
    def empty_board
        #wrote this as a single private method because of DRY since #initialize and #reset!
        #do the same thing
        @cells = Array.new(9){" "}
    end

end