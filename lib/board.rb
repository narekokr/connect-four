require './lib/player.rb'

class Board
    attr_accessor :board, :players

    def initialize(player1 = nil, player2 = nil)
        @board = Array.new(6) { Array.new(7) { "  " } }
        @players = []
        @players[0] = player1
        @players[1] = player2
        over = false
    end

    def print
        output = "\n"
        6.times do |ind1|
            7.times do |ind2|
                output << "|" << @board[ind1][ind2]
                unless @board[ind1][ind2] == "  "
                    output << " "
                end
            end
            output << "|\n----------------------\n"
        end
        output << " 1  2  3  4  5  6  7\n"
        output
    end

    def setup(player1, player2)
        @players[0] = player1
        @players[1] = player2
    end

    def get_input(player)
        puts "#{player.name} your turn, input a column"
        col = gets.chomp.to_i
        while col < 1 || col > 7
            puts "Bruh, input again"
            col = gets.chomp.to_i
        end
        col
    end


    def check_col(col)
        return @board[0][col - 1] == "  "
    end

    def update_board(col, player)
        if check_col(col - 1)
            puts 'Invalid move bruh'
            return false
        end
        (-1).downto(-7) do |index|
            if @board[index][col - 1] == "  "
                @board[index][col - 1] =(player.first? ? '●' : '○')
                break
            end
        end
    end

    def check_winner
        if check_horizontal[0]
            check_horizontal
        elsif check_vertical
            check_vertical
        else 
            check_diagonal
        end
    end

    def check_horizontal
        6.times do |index|
            row = @board[index].join
            if row.include?("●●●●")
                return [true, 0]
            elsif row.include?("○○○○")
                return [true, 1]
            end
        end
        return [false, nil]
    end

    def check_vertical
        7.times do |index|
            col = ""
            6.times do |index2|
                col << @board[index2][index]
            end
            if col.include?("●●●●")
                return [true, 0]
            elsif col.include?("○○○○")
                return [true, 1]
            end
        end
        return [false, nil]
    end

    def check_diagonal
        max_x = 7
        max_y = 6
        directions = [[1,-1],[1,1]]
        directions.each do |dir|
            dx = dir[0]
            dy = dir[1]
            0.upto(6) do |x|
                0.upto(5) do |y|
                    last_x = x + 3 * dx
                    last_y = y + 3 * dy
                    if (0 <= last_x && last_x < max_x && 0 <= last_y && last_y <= max_y)
                        w = @board[x][y]
                        if (w != "  " && w == @board[x+dx][y+dy] && w == @board[x+2*dx][y+2*dy] && w == @board[last_x][last_y])
                            return [true, (w == "●") ? 0 : 1]
                        end
                    end
                end
            end
        end
        return [false, nil]
    end

    def play
        puts "Hello, welcome to Connect Four"
        if players[0].nil? || players[0].nil?
            puts "Player 1, input your name"
            name = gets.chomp
            player1 = Player.new(name)
            puts "Player 2, input your name"
            name = gets.chomp
            player2 = Player.new(name, 2)
            setup(player1, player2)
        end
        42.times do |index|
            puts self.print
            input = get_input(players[index % 2])
            p check_col(input)
            if check_col(input)
                update_board(input, players[index % 2])
            end
            a, b = check_winner
            if a
                puts "Congrats, #{players[b].name}, you win the game!"
                puts self.print
                return
            end
        end
    end
end

board = Board.new
board.play