class Controller

    load 'code.rb'
    load 'user_turn.rb'

    def initialize()
        game()

    end

    def game()
        secret_code = Code.new()
        check_guess(user_guess(),secret_code)


       


    end

    def user_guess()
        user_turn = UserTurn.new()
        return user_turn.user_turn
    end

    def check_guess(guess,secret_code)

        pos_exact = 0
        color_match = 0

        (0..3).each do |x|
            if(guess[x] == secret_code.code[x])
                pos_exact += 1

            end
        end

        temp = secret_code.code.clone()

        (0..3).each do |x|

                if(temp.include?(guess[x]))
                    temp.delete(guess[x])
                    puts(temp.to_s + "-----------")
                    color_match += 1
                end
            
        end
        color_match = color_match - pos_exact 



        if(guess == secret_code.code)
            puts "win"
        else
            puts(secret_code.code.to_s + '------')

        end

        puts "Matched Correct Position #{pos_exact} times"
        puts "Matched Correct Color But Not Position #{color_match} times"

    end

end

x = Controller.new()
