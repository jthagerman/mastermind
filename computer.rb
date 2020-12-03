class Computer


    COLOR_LOOKUP = {"1" => "r","2" =>  "b","3" =>  "g","4" =>  "y","5" =>  "w","6" =>  "p"}


    def initialize()
        @sets = []
        createSetList
        puts getPossiblitiesLength()
        trim([1,2,3])
        puts @sets.to_s
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

    def getPossiblitiesLength()
        return @sets.length()
    end
    

    def trim(numbers)

        numbers.each do |number|

            index_delete_list = []
            @sets.each_with_index do |x, index|
                if(!x.include?(number))
                    index_delete_list.push(index)
                end
            end
            index_delete_list = index_delete_list.reverse()
            index_delete_list.each do |x|
                @sets.delete_at(x)
            end
        end
    end



end



x = Computer.new()
puts x.getPossiblitiesLength()
#.createSetList()