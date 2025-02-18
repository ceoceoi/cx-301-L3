virtual class counter;
//A class in SV is a template for creating objects that have properties (variables) and methods (functions/tasks).*base class "parent"

//properties
int count;//belongs to each instance of the counter (class)

// Constructor with default value 0
    function new(int initial_value = 0);
    count = initial_value;
        $display("Created new counter with value: %0d", initial_value);    
endfunction


//method that returns the current value of count
    function int getcount ();
         return count;
    endfunction

 //method that allows setting the count value + takes an integer argument value and assigns it to count
    function void  load(int value);
        count = value;
    endfunction 

endclass //counter


//drivered classes "child"
 class upcounter extends counter;
     function new(int initial_value = 0);
      super.new(initial_value);
    endfunction 

    function void next();
        count++;
        $display("upcounter is: %0d",count );
    endfunction
endclass 

class downcounter extends counter;
   function new(int initial_value = 0);
        super.new(initial_value);
    endfunction

    function next();
        count--;
        $display("downcounter is: %0d",count );
     endfunction
endclass //className extends superClass


module tb;
//counter test
counter c1,c2; //just give it a name (istance)
initial begin
     //initial block is performing once / start the testing
counter c1,c2; //just give it a name (istance)
 c1 = new(); //will print 0 by defult
 c2 = new (5);
 $display("counter 1 value: %0d", c1.getcount());
 $display("counter 2 value: %0d", c2.getcount());
end

//upcounter test
upcounter uc; //just give it a name (instance)
initial begin
uc = new(5);
$display("init upcounter: %0d", uc.getcount());
uc.next();
uc.next();
end

//downcounter test
downcounter dc1; //just give it a name (instance)
initial begin
dc1 = new(5);
$display("init downcounter: %0d", dc1.getcount());
dc1.next();
dc1.next();
end
endmodule


//this contain simple class, constrcture, drived class.