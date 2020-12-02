class Codemaker

    load 'code.rb'
    POSITIONS = ['First', 'Second', 'Third', 'Forth']


    def initialize()
        createCode()

    end

    def createCode()

        code_array = []

        (0..3).each do |x|

            puts "Please Enter The Color For The #{POSITIONS[x]} Position"
          
            code_array.push(  get_color())
        end
    end
    
    def get_color()
       
        color_input = (gets.chomp.downcase)
        if(Code.COLORS(color_input))
        else
            puts "invalid color input, please try again"
            puts "colors are: r,b,g,y,w,p"
            get_color()
        end

        return color_input
    end

end


#x = Codemaker.new()