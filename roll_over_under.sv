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
class upcounter extends counter;
    bit carry; // Indicates roll-over

    function new(int initial_value = 0, int upper_limit = 100, int lower_limit = 0);
        super.new(initial_value, upper_limit, lower_limit);
        carry = 0; // Initialize carry flag
    endfunction 

    function void next();
        if (count == max) begin
            count = min; // Roll over to min
            carry = 1; // Set carry flag
        end else begin
            count++;
            carry = 0; // Reset carry flag
        end
        $display("Upcounter: %0d, Carry: %b", count, carry);
    endfunction
endclass
class downcounter extends counter;
    bit borrow; // Indicates roll-under

    function new(int initial_value = 0, int upper_limit = 100, int lower_limit = 0);
        super.new(initial_value, upper_limit, lower_limit);
        borrow = 0; // Initialize borrow flag
    endfunction

    function void next();
        if (count == min) begin
            count = max; // Roll under to max
            borrow = 1; // Set borrow flag
        end else begin
            count--;
            borrow = 0; // Reset borrow flag
        end
        $display("Downcounter: %0d, Borrow: %b", count, borrow);
    endfunction
endclass
module tb1;
    upcounter uc; // Upcounter instance
    downcounter dc1; // Downcounter instance

    // Upcounter test
    initial begin
        $display("\nStarting Testbench");
        uc = new(4, 5, 0); // Upcounter with min=0, max=5, starts at 4

        $display("\nTesting upcounter with limits [0:5]:");
        repeat(3) begin
            $display("Count: %0d, Carry: %b", uc.getcount(), uc.carry);
            uc.next();
            #10; // Added delay between iterations
        end
    end

    // Downcounter test
    initial begin
        dc1 = new(1, 5, 0); // Downcounter with min=0, max=5, starts at 1

        $display("\nTesting downcounter with limits [5:0]:");
        repeat(3) begin
            $display("Count: %0d, Borrow: %b", dc1.getcount(), dc1.borrow);
            dc1.next();
            #10; // Added delay between iterations
        end
    end

    // End simulation
    initial begin
        #100;
        $finish;
    end
endmodule
