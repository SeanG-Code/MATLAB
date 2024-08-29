a = 1;
b = "Hello World";

[n1, n2, n3] = example_function(4,2,7);

object1 = example_class(1,2);
object2 = example_class(3,4);

object1.add_two_numbers()

object1.a = 1;
object2.a = 2;
disp(object1.a)
disp(object2.a)

object3.a = 1;
% disp(object3.b)

function [output1, output2, output3] = example_function(input1, input2, input3)
    output1 = input1 + input2 + input3;
    output2 = input1*input2*input3;
    output3 = (input1-input2)*input3;
end