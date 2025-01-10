module State_Machine_Assignment(w, clk, z);
  output reg z;
  input w, clk;
  reg [3:0] state, nextstate;

  parameter S0 = 4'b0000,
            S1 = 4'b0001,
            S2 = 4'b0010,
            S3 = 4'b0011,
            S4 = 4'b0100,
            S5 = 4'b0101,
            S6 = 4'b0110,
            S7 = 4'b0111,
            S8 = 4'b1000,
            HOLD_ZERO = 4'b1001,
            HOLD_ONE  = 4'b1010;

  initial begin
    state = S0;
    nextstate = S0;
    z = 0;
  end

  always @(posedge clk) begin
    state <= nextstate;
  end

  always @(state, w) begin
    case (state)
      S0: begin
        if (w == 0) nextstate <= S1;
        else nextstate <= S5;
      end

      S1: begin
        if (w == 0) nextstate <= S2;
        else nextstate <= S5;
      end

      S2: begin
        if (w == 0) nextstate <= S3;
        else nextstate <= S5;
      end

      S3: begin
        if (w == 0) nextstate <= S4;
        else nextstate <= S5;
      end

      S4: begin
        if (w == 0) nextstate <= HOLD_ZERO;
        else nextstate <= S5;
      end

      HOLD_ZERO: begin
        if (w == 0) nextstate <= HOLD_ZERO;
        else nextstate <= S5;
      end

      S5: begin
        if (w == 1) nextstate <= S6;
        else nextstate <= S1;
      end

      S6: begin
        if (w == 1) nextstate <= S7;
        else nextstate <= S1;
      end

      S7: begin
        if (w == 1) nextstate <= S8;
        else nextstate <= S1;
      end

      S8: begin
        if (w == 1) nextstate <= HOLD_ONE;
        else nextstate <= S1;
      end

      HOLD_ONE: begin
        if (w == 1) nextstate <= HOLD_ONE;
        else nextstate <= S1;
      end

      default: nextstate <= S0;
    endcase
  end

  always @(state) begin
    case (state)
      HOLD_ZERO, HOLD_ONE: z <= 1;
      default: z <= 0;
    endcase
  end
endmodule
