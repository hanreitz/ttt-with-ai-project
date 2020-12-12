require_relative '../player.rb'

module Players
    class Computer < Player
        attr_accessor :board
        WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]
        def move(board)
            valid_moves = []
            i=1
            while i <= board.cells.length
                if board.valid_move?(i)
                    valid_moves << "#{i}"
                end
                i += 1
            end
            valid_moves.sample
        end
        # def move(board)
        #     corners = [0,2,6,8] #the board's corner indices
        #     win_or_block = []
        #     WIN_COMBINATIONS.each do |combo|
        #         if (board.cells[combo[0]] == board.cells[combo[1]] && 
        #             board.taken?(combo[0]+1) && !board.taken?(combo[1]+1)) || 
        #             (board.cells[combo[1]] == board.cells[combo[2]] && 
        #             board.taken?(combo[1]+1) && !board.taken?(combo[0]+1)) || 
        #             (board.cells[combo[0]] == board.cells[combo[2]] && 
        #             board.taken?(combo[0]+1) && !board.taken(combo[1]+1))    
        #             win_or_block << combo
        #         end
        #     end #basically checking all the winning combos to see if anyone has 2/3 full - if it's us we can win,
        #         #if it's them we should block (hence win_or_block)
        #     one_player_paths = []
        #     WIN_COMBINATIONS.each do |combo|
        #         if (board.cells[combo[0]] == "#{self.token}" && board.cells[combo[1]] == " " && board.cells[combo[2]] == " ") ||
        #             (board.cells[combo[1]] == "#{self.token}" && board.cells[combo[0]] == " " && board.cells[combo[2]] == " ") ||
        #             (board.cells[combo[2]] == "#{self.token}" && board.cells[combo[0]] == " " && board.cells[combo[1]] == " ") 
        #             one_player_paths << combo
        #         end
        #     end #checking for 1/3 paths -- if we can't block or win, the next best thing to do is go into a winning path we're 
        #         #already on BY OURSELVES (just us and some spaces)
        #     if board.turn_count == 0
        #         board.update(5,"#{self.token}") #special rule: for the first turn, go in the middle
        #     elsif board.turn_count == 1
        #         if board.valid_move?(5, "#{self.token}")
        #             board.update(5,"#{self.token}") #special rule #2: for the second turn, go in the middle if you can
        #         else
        #             board.update(corners.sample + 1,"#{self.token}") #otherwise, pick a corner
        #         end
        #     elsif board.turn_count > 1 #OK HERE WE GO IT'S AI LOGIC TIME BABY
        #         if win_or_block.length == 3 #aight here we're saying there's ONE combo that gives us a win or a block
        #             if board.valid_move?(win_or_block[0]+1) #figure out which one is the valid move and TAKE IT 
        #                 board.update(win_or_block[0]+1, "#{self.token}")
        #             elsif board.valid_move?(win_or_block[1]+1)
        #                 board.update(win_or_block[1]+1, "#{self.token}")
        #             else
        #                 board.update(win_or_block[2]+1, "#{self.token}")
        #             end #WON or BLOCKED -- might need to add something here to stop the game but I THINK that logic is in Game rather than here
        #         elsif win_or_block.length > 3 #OK UH OH we've got either multiple ways to WIN (!!), to BLOCK (:X), or we've got ONE OF EACH
        #             if win_or_block[0] == "#{self.token}" || win_or_block[1] == "#{self.token}" || win_or_block[2] == "#{self.token}"
        #                 if board.valid_move?(win_or_block[0]+1)
        #                     board.update(win_or_block[0]+1, "#{self.token}")
        #                 elsif board.valid_move?(win_or_block[1]+1)
        #                     board.update(win_or_block[1]+1, "#{self.token}")
        #                 else
        #                     board.update(win_or_block[2]+1, "#{self.token}")
        #                 end #so first this section is saying, hey, can we win?
        #             elsif win_or_block[3] == "#{self.token}" || win_or_block[4] == "#{self.token}" || win_or_block[5] == "#{self.token}"
        #                 if board.valid_move?(win_or_block[3]+1)
        #                     board.update(win_or_block[3]+1, "#{self.token}")
        #                 elsif board.valid_move?(win_or_block[4]+1)
        #                     board.update(win_or_block[4]+1, "#{self.token}")
        #                 else
        #                     board.update(win_or_block[5]+1, "#{self.token}")
        #                 end #and so is this one--is the 2/3 us or them?
        #             elsif !win_or_block.include?("#{self.token}") #here we're going OK it's not us with 2/3 on a winner, let's block
        #                 possible_blocks = win_or_block.collect do |move| 
        #                     if board.valid_move?(move+1)
        #                         move
        #                     end
        #                 end #collecting all the valid moves included in win_or_block (might be unnecessary)
        #                 if possible_blocks.length == 1
        #                     board.update(possible_blocks[0]+1, "#{self.token}") #if there is one block, do it
        #                 elsif possible_blocks.length > 1
        #                     if possible_blocks[0] == possible_blocks[1]
        #                         board.update(possible_blocks[0]+1, "#{self.token}")
        #                     else
        #                         board.update(possible_blocks.sample + 1, "#{self.token}")
        #                     end
        #                 end #if there is more than one possible block, check first if it can be accomplished in one move, 
        #                     #else just pick one of them randomly (because you can't win)
        #             end
        #         elsif win_or_block.length == 0
        #             if one_player_paths.length >= 3
        #                 valid_corners = []
        #                 corners.each do |move|
        #                     if one_player_paths.include?(move) && board.valid_move?(move+1)
        #                         valid_corners << move #add the valid move which is also a corner to the list
        #                     end
        #                 end
        #                 if valid_corners.length > 0
        #                     board.update(valid_corners.sample + 1, "#{self.token}") #pick a valid corner, go into it
        #                 else
        #                     board.update(one_player_paths.sample + 1, "#{self.token}") #if no corners are in a path and valid,
        #                     #go somewhere else in one of your one player paths
        #                 end
        #             else
        #                 random_cell = board.cells.find {|cell| !board.taken?(cell + 1)}.index #when there's nothing better find a valid move and take it
        #                 board.update(random_cell+1, "#{self.token}")
        #             end 
        #         end
        #    end
        #end
    end
end 