classdef example_class < handle
    properties
        a
        b = 1
    end
    methods
        function self = example_class(a_0, b_0)
            self.a = a_0;
            self.b = b_0;
        end
        function result = add_two_numbers(self)
            result = self.a + self.b;
        end
    end
end