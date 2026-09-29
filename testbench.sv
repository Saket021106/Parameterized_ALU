`timescale 1ns / 1ps

module tb_alu_WIDTH_bit();

    parameter WIDTH = 16;

    reg  [WIDTH-1:0] A;
    reg  [WIDTH-1:0] B;
    reg  [1:0] control;
    reg  [2:0] op;
    reg  sel;
    wire [WIDTH-1:0] result;
    wire C;
    wire Z;
    wire S;
    wire V;

    alu_WIDTH_bit #(.WIDTH(WIDTH)) uut (
        .A(A), .B(B), .control(control), .op(op), .sel(sel),
        .result(result), .C(C), .Z(Z), .S(S), .V(V)
    );

    initial begin
        $dumpfile("alu_WIDTH_bit_tb.vcd");
        $dumpvars(0, tb_alu_WIDTH_bit);

        $monitor("Time=%0t | A=%h B=%h | control=%b op=%b sel=%b | result=%h | C=%b Z=%b S=%b V=%b",
                 $time, A, B, control, op, sel, result, C, Z, S, V);

        A = 16'h0001; B = 16'h0001; control = 2'b00; op = 3'b000; sel = 1'b0; #10;  
        A = 16'hFFFF; B = 16'h0001; control = 2'b00; op = 3'b000; sel = 1'b0; #10; 
        A = 16'h7FFF; B = 16'h0001; control = 2'b00; op = 3'b000; sel = 1'b0; #10; 
        A = 16'h8000; B = 16'h8000; control = 2'b00; op = 3'b000; sel = 1'b0; #10; 

        A = 16'h0003; B = 16'h0001; control = 2'b00; op = 3'b001; sel = 1'b0; #10; 
        A = 16'h0000; B = 16'h0001; control = 2'b00; op = 3'b001; sel = 1'b0; #10; 
        A = 16'h7FFF; B = 16'hFFFF; control = 2'b00; op = 3'b001; sel = 1'b0; #10; 
        A = 16'h8000; B = 16'h0001; control = 2'b00; op = 3'b001; sel = 1'b0; #10; 

        A = 16'hF0F0; B = 16'h0F0F; control = 2'b01; op = 3'b000; sel = 1'b0; #10; 
        A = 16'hF000; B = 16'h0F0F; control = 2'b01; op = 3'b001; sel = 1'b0; #10; 
        A = 16'hAAAA; B = 16'h0F0F; control = 2'b01; op = 3'b010; sel = 1'b0; #10; 
        A = 16'h00F0; B = 16'h1234; control = 2'b01; op = 3'b011; sel = 1'b0; #10; 
        A = 16'h00F0; B = 16'h1234; control = 2'b01; op = 3'b011; sel = 1'b1; #10;

        A = 16'h8001; B = 16'h1234; control = 2'b11; op = 3'b000; sel = 1'b0; #10; 
        A = 16'h1234; B = 16'h4001; control = 2'b11; op = 3'b000; sel = 1'b1; #10; 
        A = 16'h8001; B = 16'h1234; control = 2'b11; op = 3'b001; sel = 1'b0; #10; 
        A = 16'h1234; B = 16'h0001; control = 2'b11; op = 3'b001; sel = 1'b1; #10; 

        $finish;
    end

endmodule
