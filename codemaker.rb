class Codemaker


    POSITIONS = ['First', 'Second', 'Third', 'Forth']
    attr_reader :code_array

    def initialize()
        createCode()
    end

    def createCode()
        @code_array = []

        (0..3).each do |x|
            puts "Please Enter The Color For The #{POSITIONS[x]} Position"
            code_array.push(get_color())
        end       
    end
    
    def get_color()
       
        color_input = (gets.chomp.downcase)
        if(['r','b','g','y','w','p'].include?(color_input))
        else
            puts "invalid color input, please try again"
            puts "colors are: r,b,g,y,w,p"
            get_color()
        end

        return color_input
    end
end


