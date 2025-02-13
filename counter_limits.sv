// Parent Class - Counter
class counter;
    int count;
    int min; 
    int max;
    // Method to set up limits
    function void check_limit(int limit1, int limit2);
        if (limit1 > limit2) begin
            max = limit1;
            min = limit2;
        end else begin
            max = limit2;
            min = limit1;
        end
    endfunction 
    // Method to check if count is within limits
    function void check_set(int value);
        if (value > max) begin
            $display("Warning: %0d is above max limit %0d. Using max.", value, max);
            count = max;
        end else if (value < min) begin
            $display("Warning: %0d is below min limit %0d. Using min.", value, min);
            count = min;
        end else begin
            count = value;
        end
    endfunction
    // Constructor to initialize values
    function new(int initial_value = 0, int upper_limit = 100, int lower_limit = 0);
        check_limit(upper_limit, lower_limit);
        check_set(initial_value);
    endfunction 
    // Load function to assign a value within limits
    function void load(int value);
        check_set(value);
    endfunction 
    // Added getter function to access count value
    function int getcount();
        return count;
    endfunction
endclass

// Upcounter Class
class upcounter extends counter;
    function new(int initial_value = 0, int upper_limit = 100, int lower_limit = 0);
        super.new(initial_value, upper_limit, lower_limit);
    endfunction 
    function void next();
        if (count == max) begin
            count = min; // Roll over to min if max is reached
        end else begin
            count++;
        end
        $display("Upcounter: %0d", count);
    endfunction
endclass 

// Downcounter Class
class downcounter extends counter;
    function new(int initial_value = 0, int upper_limit = 100, int lower_limit = 0);
        super.new(initial_value, upper_limit, lower_limit);
    endfunction
    function void next();
        if (count == min) begin
            count = max; // Roll under to max if min is reached
        end else begin
            count--;
        end
        $display("Downcounter: %0d", count);
    endfunction
endclass

// Testbench Module
module tb1;
    upcounter uc; // Upcounter instance
    downcounter dc1; // Downcounter instance
    
    // Upcounter test
    initial begin
        $display("\nStarting Testbench");
        uc = new(0, 5, 0);
        $display("\nTesting upcounter with limits [0:5]:");
        repeat(7) begin
            $display("Count: %0d", uc.getcount());
            uc.next();
            #10; // Added delay between iterations
        ends
    end
    
    // Downcounter test
    initial begin
        dc1 = new(5, 5, 0);
        $display("\nTesting downcounter with limits [5:0]:");
        repeat(7) begin
            $display("Count: %0d", dc1.getcount());
            dc1.next();
            #10; // Added delay between iterations
        end
    end

    // Added simulation finish
    initial begin
        #200; // Allow enough time for both tests
        $finish;
    end
endmodule