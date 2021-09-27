class Board
    def initialize(game)
        @game = game
        restart_board
    end
    def restart_board
        @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    end
    def coordinates_from_play(play)
        i = (play - 1) / 3
        j = (play - 1) % 3
        return [i, j]
    end
    def check_playable_spot(play)
        coords = coordinates_from_play(play)
        i = coords[0]
        j = coords[1]
        return @board[i][j] != 'o' && @board[i][j] != 'x'
    end
    def check_win(player)
        sym = player.symbol
        (0..2).each do |i|
            if @board[i][0] == sym && @board[i][1] == sym && @board[i][2] == sym
                return true
            elsif @board[0][i] == sym && @board[1][i] == sym && @board[2][i] == sym
                return true
            end
        end
        if @board[0][0] == sym && @board[1][1] == sym && @board[2][2] == sym
            return true
        elsif @board[0][2] == sym && @board[1][1] == sym && @board[2][0] == sym
            return true
        end
        return false
    end
    def check_draw
        (0..2).each do |i|
            (0..2).each do |j|
                if @board[i][j] != 'o' && @board[i][j] != 'x'
                    return false
                end
            end
        end
        return true
    end
    def print_board
        puts "#{@board[0][0]}|#{@board[0][1]}|#{@board[0][2]}"
        puts '-+-+-'
        puts "#{@board[1][0]}|#{@board[1][1]}|#{@board[1][2]}"
        puts '-+-+-'
        puts "#{@board[2][0]}|#{@board[2][1]}|#{@board[2][2]}"
    end
    def play(player, play)
        coords = coordinates_from_play(play)
        i = coords[0]
        j = coords[1]
        @board[i][j] = player.symbol
        if check_win(player)
            print_board
            puts "Player #{player.symbol} wins!"
            puts "Press Enter for a new game"
            gets.chomp
            @game.new_game
        elsif check_draw
            print_board
            puts "Game Draw!"
            puts "Press Enter for a new game"
            gets.chomp
            @game.new_game
        else
            @game.next_player
            @game.next_turn       
        end
    end
end

class TicTacToe
    def initialize
        @board = Board.new(self)
        new_game
    end
    def new_game
        @board.restart_board
        @players = [Player.new('o'), Player.new('x')]
        @current_player = @players[0]
        next_turn
    end
    def next_player
        @current_player = (@current_player == @players[0]) ? @players[1] : @players[0]
    end
    def next_turn
        @board.print_board
        player = @current_player
        while true
            print "It is the turn for player #{@current_player.symbol}. What's the play? "
            play = gets.chomp.to_i
            if play >= 1 && play <= 9
                if @board.check_playable_spot(play)
                    @board.play(player, play)
                    break
                end
            end
            puts "That spot can't be played. Please choose another one."
        end
    end
end

class Player
    attr_reader :symbol
    def initialize(symbol)
        @symbol = symbol
    end
end

game = TicTacToe.new()
