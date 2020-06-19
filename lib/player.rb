class Player
    attr_accessor :num, :name

    def initialize(name, num = 1)
        @name = name
        @num = num
    end

    def first?
        @num == 1
    end
end