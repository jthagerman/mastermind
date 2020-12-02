class UserTurn

    TURNS = ["First", "Second", "Third","Fourth"]
    attr_reader :user_turn

    def initialize()
       @user_turn = Array.new()
       (1..4).each do |x|
            get_guesses(x)
       end 
    end

    def get_guesses(i)

        puts "Please Enter Your Guess For The #{TURNS[i-1]} Position"
        t1 = gets.chomp
        if(!Code.COLORS(t1))
            raise "error"
        end
        rescue => error
            puts "\n\ninvalid input!\n"
            puts "colors are: r,b,g,y,w,p"
            get_guesses(i)
        else
            @user_turn.push(t1)
    end

    def to_s
        @user_turn
    end

end

