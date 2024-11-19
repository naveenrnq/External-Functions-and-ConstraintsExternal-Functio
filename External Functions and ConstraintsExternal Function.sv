class generator;

  randc bit [3:0] a,b;  // rand or randc
  bit [3:0] y;
 
  // To recognise the constraint outside the class
  extern constraint data; // External constraint has semicolon
  
  extern function void display();
endclass

// We come external to the class and define constraint
// Scope operator ::
constraint generator::data {
  a inside {[0:3]};
  b inside {[12:15]};
}; // Here also semicolon

function void generator::display();
   $display("Value of a: %0d, Value of b: %0d",a,b);
endfunction

module tb;
 generator g;
 int i = 0;
 int status = 0; // this is to store the result of randomization
 
 initial begin
   g = new();
   for(i = 0; i < 20; i++) begin
     assert(g.randomize()) else $display("Randomization Failed");
     g.display();
     #10; 
   end
 end

endmodule
