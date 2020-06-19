require './lib/board.rb'

describe Board do
    
    subject {Board.new(Player.new('Mike'),Player.new('John', 2))}
    
    describe "#print" do
        it "prints the board" do
            output = "\n" \
            "|  |  |  |  |  |  |  |\n" \
            "----------------------\n" \
            "|  |  |  |  |  |  |  |\n" \
            "----------------------\n" \
            "|  |  |  |  |  |  |  |\n" \
            "----------------------\n" \
            "|  |  |  |  |  |  |  |\n" \
            "----------------------\n" \
            "|  |  |  |  |  |  |  |\n" \
            "----------------------\n" \
            "|  |  |  |  |  |  |  |\n" \
            "----------------------\n" \
            " 1  2  3  4  5  6  7\n"
            expect(subject.print).to eql(output)
        end
    end

    describe "#setup" do
        it 'sets up the players' do
            player1 = Player.new('Alex')
            player2 = Player.new('John', 2)
            subject.setup(player1, player2)
            expect(subject.players).to eql [player1, player2]
        end
    end

    describe "#check_col" do
        it 'checks the column if it is full' do
            subject.board[3][3] = '●'
            expect(subject.check_col(3)).to eql(true)
        end
    end

    describe "#update_board" do
        it 'updates the board' do
            player1 = Player.new('qaq')
            subject.update_board(1, player1)
            expect(subject.board[5][1]).to eql('●')
        end
    end

    describe "check_if wins" do
        it "checks if someone wins horizontally" do
            subject.board[5][4] = "●"
            subject.board[5][3] = "●"
            subject.board[5][2] = "●"
            subject.board[5][1] = "●"
            expect(subject.check_winner).to eql true            
        end

        it "checks if someone wins vertically" do
            subject.board[5][4] = "●"
            subject.board[4][4] = "●"
            subject.board[3][4] = "●"
            subject.board[2][4] = "●"
            expect(subject.check_winner).to eql true
        end

        it "checks if someone wins diagonally" do
            subject.board[5][3] = "●"
            subject.board[4][2] = "●"
            subject.board[3][1] = "●"
            subject.board[2][0] = "●"
            expect(subject.check_winner).to eql true
        end
    end
end