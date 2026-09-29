module alu_WIDTH_bit #(
    parameter WIDTH = 16
)(
    input [WIDTH - 1:0] A,
    input [WIDTH - 1:0] B,

    input logic [1:0] control,
    input logic [2:0] op,
    input logic sel,

    output logic [WIDTH - 1:0] result,
    output logic C,
    output logic Z,
    output logic S,
    output logic V
);

    logic [WIDTH:0] temp;

    always_comb begin : alu_logic
        result = 'b0;
        C = 1'b0;
        Z = 1'b0;
        S = 1'b0;
        V = 1'b0;
        temp = 'b0;

        case(control)

            2'b00 : begin

                case(op)

                    3'b000 : begin

                        temp = {1'b0, A} + {1'b0, B};
                        result = temp[WIDTH - 1:0];
                        C = temp[WIDTH];

                        //signed overflow
                        V = (~(A[WIDTH - 1] ^ B[WIDTH - 1])) & (result[WIDTH - 1] ^ A[WIDTH - 1]);

                    end

                    3'b001 : begin

                        temp = {1'b0, A} + {1'b0, ~B} + 1'b1;
                        result = temp[WIDTH - 1:0];
                        //C = 1 means no borrow
                        C = temp[WIDTH];

                        V = ((A[WIDTH - 1] ^ B[WIDTH - 1])) & (result[WIDTH - 1] ^ A[WIDTH -1]);

                    end

                    default result = 'b0;

                endcase

            end

            2'b01 : begin

                case(op)

                    3'b000 : result = A & B;

                    3'b001 : result = A | B;

                    3'b010 : result = A ^ B;

                    3'b011 : result = sel ? ~B : ~A;

                    default : result = 'b0;

                endcase

            end

            2'b11 : begin

                case(op)

                    3'b000 : result = sel ? (B << 1) : (A << 1);

                    3'b001 : result = sel ? (B >> 1) : (A >> 1);

                    default : result = 'b0;

                endcase

            end

            default : result = 'b0;

        endcase
            
        if(result == 8'b0) Z = 1'b1;
        else Z = 1'b0;

        S = result[WIDTH - 1];

    end

endmodule
