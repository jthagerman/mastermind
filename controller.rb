class Controller

    load 'codebreaker.rb'
    load 'codemaker.rb'

    def initialize()
        puts "Welcome to Masterind!\nCreated By: John Hagerman\n\n\n"
        puts "Would you like to be the Codemaker or Codebreaker?"
        setup_game()
    end


    def setup_game()


        puts "Enter 'm' for Codemaker or 'b for Codebreaker"
        case(gets.chomp.downcase)
        when 'm'
            codemaker()
        when 'b'
            codebreaker()
        else
            puts "Invalid Input, please try again"
            setup_game()
        end
    end

    def codebreaker()
        puts("Computer has generated a 4 color code")
        breaker = Codebreaker.new()
    end

    def codemaker()
        maker = Codemaker.new()
    end
    
end
