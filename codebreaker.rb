class Codebreaker

    load 'code.rb'
    load 'user_turn.rb'

    def initialize()
        @turns = 11
        game()
    end

    def game()
        secret_code = Code.new()  
        while(@turns > 0) 
            puts "\n\n\n#{@turns} Turns to go! Enter your guess."
            turn = user_guess()         
            check_guess(turn,secret_code)
            @turns -= 1

            if(check_win(turn,secret_code))
               puts "You Win!"
               break
            end
        end    
    end

    def user_guess()
        user_turn = UserTurn.new()
        return user_turn.user_turn
    end

    def check_win(guess, secret_code)
        win = false
        (0..3).each do |x|
            if(guess[x] == secret_code.code[x])
                win = true
            else
                win = false
                break
            end     
        end
        return win   
    end

    def check_guess(guess,secret_code)

        pos_exact = 0
        color_match = 0
        guess = guess.clone()
        key = secret_code.code.clone()

        (0..3).each do |x|
            if(guess[x] == key[x])
                pos_exact += 1
                matches.push(key[x])
            end
        end

        guess.each do |x|
            color_match += key.count(x)
            key.delete(x)
        end
        color_match = color_match - pos_exact

        if(pos_exact != 4)
            puts "\n\nYou Guessed: #{Code.fancy_s(guess)}"
            puts secret_code.code.to_s
            puts "Matched Correct Position #{pos_exact} times"
            puts "Matched Correct Color But Not Position #{color_match} times"
        end
    end
end

