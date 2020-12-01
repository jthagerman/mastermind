class UserTurn

    load 'code.rb'

    TURNS = ["First", "Second", "Third","Fourth"]

    def initialize()

       @UserTurn = Array.new()

       (1..4).each do |x|
            get_guesses(x)
       end



        
    end

    def get_guesses(i)

        puts "colors are: r,b,g,y,w,p"
        puts "Please Enter Your Guess For The #{TURNS[i-1]} Position"
        t1 = gets.chomp
        if(!Code.COLORS(t1))
            raise "error"
        end
        rescue => error
            puts "\n\ninvalid input!\n"
            get_guesses(i)
        else
            @UserTurn.push(t1)



    end



    def to_s
        @UserTurn
    end



end

x = UserTurn.new()