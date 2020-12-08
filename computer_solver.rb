class Computer
    require_relative 'codebreaker'
    require_relative 'code'
    COLOR_LOOKUP = {1 => "r",2 =>  "b",3 =>  "g",4 =>  "y",5 =>  "w",6 =>  "p"}
    NUMBER_LOOKUP = {'r' => 1, 'b' => 2, 'g' => 3, 'y' => 4 ,'w' => 5, 'p' => 6 }

    def initialize(key)
        @sets = []
        @key = to_numeric_color_rep(key)
        createSetList
        @victory = false

        make_a_guess([1,1,2,2])
        turns = 10
        while(@victory == false)       
            if(@victory == true)
                break
            end
            puts("#{turns} turns left to go!")
            puts("press return for the computer's next move")
            refresh = gets.chomp

            puts "\n\n T h i n k i n g \n\n"
            sleep 1
            make_a_guess(@sets[ 0])
            turns -= 1
            if(turns == 0) && (@victory == false)
                puts "You Win, the computer is defeated"
                break
            end
        end
    end

    def createSetList
        (1..6).each do |x|
            (1..6).each do |y|
                (1..6).each do |z|
                    (1..6).each do |a|
                        @sets.push([x,y,z,a])
                    end
                end
            end
        end
    end

    def to_numeric_color_rep(colors)
        array = []
        colors.each do |x|
            array.push(NUMBER_LOOKUP[x])
        end
        return array
    end

    def to_str_color_rep(colors)
        array = []
        colors.each do |x|
            array.push(COLOR_LOOKUP[x])
        end
        return array
    end

    def make_a_guess(guess)

        pos_matches = Codebreaker.check_exacts(to_str_color_rep(guess),to_str_color_rep(@key))
        color_matches = Codebreaker.check_color_matches(to_str_color_rep(guess),to_str_color_rep(@key),pos_matches)

        puts("\n\n\nThe computer guesses: " + Code.fancy_s(to_str_color_rep(guess)))
        puts pos_matches.to_s + ": Exact matches \n" + color_matches.to_s + ": color matches\n\n"
        clear_list(pos_matches, color_matches, guess)
        @sets.delete(guess)
        #puts @sets.to_s
        #puts @sets.length()
    end

    def clear_list(pos_matches, color_matches, guess)
        if(pos_matches == 0)
            zero_matches(guess, color_matches)
        elsif(pos_matches == 1)
            one_matches(guess, color_matches)
        elsif(pos_matches == 2)
            two_matches(guess, color_matches)
        elsif(pos_matches == 3)
            three_matches(guess, color_matches)
        elsif(pos_matches == 4)    
            puts('You Lose: The Computer Cracked Your Code')   
            @victory = true
        end
    end

    def color_includer_checker(set_colors, guess_colors, color_matches)
        # ( (set_colors & guess_colors).length >= color_matches ) ? true : false   
        ( (((set_colors & guess_colors).flat_map { |n| [n]*[set_colors.count(n), guess_colors.count(n)].min })).length >= color_matches ) ? true : false   
     end

    def zero_matches(guess, color_matches)
        if(color_matches == 0)
             @sets = @sets.select { |x| (x & guess).empty? }  
        else
             @sets = @sets.select { |x| ((((x & guess).flat_map { |n| [n]*[x.count(n), guess.count(n)].min })).length() >= color_matches)}     #this does not eleminate all that it should   
        end
    end  
         
    def one_matches(guess, color_matches)
        if(color_matches == 0)
            @sets = @sets.select { |x| (  ((x[0] == guess[0] ) &&   ((   x[1,3] & guess[1,3]).empty? )|| 
                ((x[1] == guess[1] ) && ([x[0],x[2], x[3]] & [guess[0],guess[2],guess[3]]).empty?)||
                ((x[2] == guess[2] ) && ([x[0],x[1], x[3]] & [guess[0],guess[1],guess[3]]).empty? )|| 
                ((x[3] == guess[3] ) && ( x[0,3] & guess[0,3]).empty?)) )}
        else
            @sets = @sets.select { |x| ( ((x[0] == guess[0] ) && color_includer_checker([x[1],x[2], x[3]], guess[1,3], color_matches)) || 
                ((x[1] == guess[1] ) && color_includer_checker([x[0],x[2], x[3]], [guess[0],guess[2],guess[3]], color_matches))||
                ((x[2] == guess[2] ) && color_includer_checker([x[0],x[1], x[3]], [guess[0],guess[1],guess[3]], color_matches) )|| 
                ((x[3] == guess[3] ) && color_includer_checker(x[0,3],guess[0,3], color_matches)))}
        end
    end

    def two_matches(guess, color_matches)
        if(color_matches == 0)
            @sets = @sets.select { |x| (((x[0] == guess[0] ) && (x[1] == guess[1]) && ([x[2],x[3]] & [guess[2],guess[3]]  ).empty?)   || 
                (((x[1] == guess[1] ) && (x[2] == guess[2])) && ([x[0],x[3]] & [guess[0],guess[3]]).empty?  ) ||
                (((x[2] == guess[2] ) && (x[3] == guess[3])) && ([x[1],x[0]] & [guess[1],guess[0]]).empty?  ) || 
                (((x[0] == guess[0] ) && (x[3] == guess[3])) && ([x[1],x[2]] & [guess[1],guess[2]]).empty?  ) ||
                (((x[0] == guess[0] ) && (x[2] == guess[2])) && ([x[1],x[3]] & [guess[1],guess[3]]).empty?  ) ||
                (((x[1] == guess[1] ) && (x[3] == guess[3])) && ([x[2],x[0]] & [guess[2],guess[0]]).empty?  ) )}
        else
            @sets = @sets.select { |x| ( ((x[0] == guess[0] ) && (x[1] == guess[1]) && color_includer_checker([x[2],x[3]] , [guess[2],guess[3]] , color_matches  )  )   || 
                (((x[1] == guess[1] ) && (x[2] == guess[2])) && color_includer_checker([x[0],x[3]] , [guess[0],guess[3]]  , color_matches)  ) ||
                (((x[2] == guess[2] ) && (x[3] == guess[3])) && color_includer_checker([x[1],x[0]] , [guess[1],guess[0]]  , color_matches)  ) || 
                (((x[0] == guess[0] ) && (x[3] == guess[3])) && color_includer_checker([x[1],x[2]] , [guess[1],guess[2]]  , color_matches)  ) ||
                (((x[0] == guess[0] ) && (x[2] == guess[2])) && color_includer_checker([x[1],x[3]] , [guess[1],guess[3]]  , color_matches)  ) ||
                (((x[1] == guess[1] ) && (x[3] == guess[3])) && color_includer_checker([x[2],x[0]] , [guess[2],guess[0]]  , color_matches)  ) )}
        end   
    end

    def three_matches(guess, color_matches)
        @sets = @sets.select { |x|
               (((x[0] == guess[0] ) && (x[1] == guess[1]) && (x[2] == guess[2])) && (([x[3]] & [guess[3]]).empty?) || 
                ((x[1] == guess[1] ) && (x[2] == guess[2]) && (x[3] == guess[3])) && (([x[0]] & [guess[0]]).empty?) ||
                ((x[0] == guess[0] ) && (x[3] == guess[3]) && (x[1] == guess[1])) && (([x[2]] & [guess[2]]).empty?) || 
                ((x[0] == guess[0] ) && (x[3] == guess[3]) && (x[2] == guess[2])) && (([x[1]] & [guess[1]]).empty?) ) }
    end          
end

#x = Computer.new([rand(1..6),rand(1..6),rand(1..6),rand(1..6)])
