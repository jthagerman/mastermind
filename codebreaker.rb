class Codebreaker

    require_relative 'code'
    require_relative 'user_turn'

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
                puts "The secret code was: " + Code.fancy_s(secret_code.code)
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

    def self.check_exacts(guess,key)
        pos_exact = 0
        guess = guess.clone()
        keys = key.clone()
        

        (0..3).each do |x|
            if(guess[x] == keys[x])
                pos_exact += 1
            end
        end

        return pos_exact
    end

    def self.total_color_matches(guess,key)
        color_match = 0
        guess = guess.clone()
        keys = key.clone()

        guess.each do |x|
            if(keys.count(x) > guess.count(x) )
                color_match += guess.count(x)
                keys.delete(x)

            else
                color_match += keys.count(x)
                keys.delete(x)
            end
        
        end
        #puts color_match
       return color_match

    end

    def self.check_color_matches(guess,key,exacts_matches)
        color_match = 0
        exacts_matches = exacts_matches
        guess = guess.clone()
        keys = key.clone()

        guess.each do |x|
            if(keys.count(x) > guess.count(x) )
                color_match += guess.count(x)
                keys.delete(x)

            else
                color_match += keys.count(x)
                keys.delete(x)
            end
        
        end
        color_match = color_match - exacts_matches

    end

    def check_guess(guess,secret_code)

        pos_exact = 0
        color_match = 0
        guess = guess.clone()
        key = secret_code.code.clone()
        

        (0..3).each do |x|
            if(guess[x] == key[x])
                pos_exact += 1
            end
        end

        guess.each do |x|
            if(key.count(x) > guess.count(x) )
                color_match += guess.count(x)
                key.delete(x)

            else
                color_match += key.count(x)
                key.delete(x)
            end
        
        end
        color_match = color_match - pos_exact

        if(pos_exact != 4)
            puts "\n\nYou Guessed: #{Code.fancy_s(guess)}"
        #   puts secret_code.code.to_s
            puts "Matched Correct Position #{pos_exact} times"
            puts "Matched Correct Color But Not Position #{color_match} times"
        end
    end
end


