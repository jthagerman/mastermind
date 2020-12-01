class Code

    COLOR_LOOKUP = {"r" => "red","b" =>  "blue","g" =>  "green","y" =>  "yellow","w" =>  "white","p" =>  "purple"}
    COLORS = ['r','b','g','y','w','p']

    attr_reader :code
    

    def initialize()
        @code = Array.new
        generateCode
    end
  
    def generateCode()
        (1..4).each do
            @code.push(COLORS[rand(6)])
        end
    end

    def createCode(colors)
        colors.each do |x|
            @code.push(x)
        end 
    end

    def to_s
        str = ""
        @code.each do |x|
            str += COLOR_LOOKUP[x] + " "
        end
        return str
    end

    def self.COLORS(entry)
        if(COLORS.include? entry)
            return true
        else
            return false
        end
    end
end


x = Code.new()
puts x


