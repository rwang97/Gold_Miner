
module draw_fail_page_control(
    input clk,
    input resetn,
    input start_fail_page,
    input draw_object_done,

    output reg [4:0] fail_page_type,
    output reg start_draw_fail_page, fail_page_done,
    output reg [8:0] x_fail_page,
    output reg [7:0] y_fail_page
	
    );

    reg [4:0] current_state, next_state; 

    localparam  S_WAIT_FOR_COMMAND		= 5'd0,
		S_LOAD_L1			= 5'd1,
		S_DRAW_L1			= 5'd2,
		S_LOAD_E1			= 5'd3,
		S_DRAW_E1			= 5'd4,
		S_LOAD_V			= 5'd5,
		S_DRAW_V			= 5'd6,
		S_LOAD_E2			= 5'd7,
		S_DRAW_E2			= 5'd8,
		S_LOAD_L2			= 5'd9,
		S_DRAW_L2			= 5'd10,
		S_LOAD_F			= 5'd11,
		S_DRAW_F			= 5'd12,
		S_LOAD_A			= 5'd13,
		S_DRAW_A			= 5'd14,
		S_LOAD_I			= 5'd15,
		S_DRAW_I			= 5'd16,
		S_LOAD_L3			= 5'd17,
		S_DRAW_L3			= 5'd18,
		S_LOAD_E3			= 5'd19,
		S_DRAW_E3			= 5'd20,		
		S_LOAD_D			= 5'd21,
		S_DRAW_D			= 5'd22,
		
		S_DONE_DRAW_FAIL_PAGE	= 5'd23;  
					 

    // Next state logic aka our state table
    always@(*)
    begin: state_table 
		case (current_state)
					
			S_WAIT_FOR_COMMAND: next_state = start_fail_page? S_LOAD_L1: S_WAIT_FOR_COMMAND;

			S_LOAD_L1: next_state = S_DRAW_L1;
			S_DRAW_L1: next_state = draw_object_done? S_LOAD_E1: S_DRAW_L1;			
			S_LOAD_E1: next_state = S_DRAW_E1;		
			S_DRAW_E1: next_state = draw_object_done? S_LOAD_V: S_DRAW_E1;		
			S_LOAD_V: next_state = S_DRAW_V;		
			S_DRAW_V: next_state = draw_object_done? S_LOAD_E2: S_DRAW_V;				
			S_LOAD_E2: next_state = S_DRAW_E2;		
			S_DRAW_E2: next_state = draw_object_done? S_LOAD_L2: S_DRAW_E2;			
			S_LOAD_L2: next_state = S_DRAW_L2;		
			S_DRAW_L2: next_state = draw_object_done? S_LOAD_F: S_DRAW_L2;			
			S_LOAD_F: next_state = S_DRAW_F;			
			S_DRAW_F: next_state = draw_object_done? S_LOAD_A: S_DRAW_F;			
			S_LOAD_A: next_state = S_DRAW_A;			
			S_DRAW_A: next_state = draw_object_done? S_LOAD_I: S_DRAW_A;			
			S_LOAD_I: next_state = S_DRAW_I;			
			S_DRAW_I: next_state = draw_object_done? S_LOAD_L3: S_DRAW_I;				
			S_LOAD_L3: next_state = S_DRAW_L3;			
			S_DRAW_L3: next_state = draw_object_done? S_LOAD_E3: S_DRAW_L3;			
			S_LOAD_E3: next_state = S_DRAW_E3;			
			S_DRAW_E3: next_state = draw_object_done? S_LOAD_D: S_DRAW_E3;				
			S_LOAD_D: next_state = S_DRAW_D;		
			S_DRAW_D: next_state = draw_object_done? S_DONE_DRAW_FAIL_PAGE: S_DRAW_D;				


			S_DONE_DRAW_FAIL_PAGE: next_state = start_fail_page? S_DONE_DRAW_FAIL_PAGE: S_WAIT_FOR_COMMAND;					
			
            default:   next_state = S_WAIT_FOR_COMMAND;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0

    		start_draw_fail_page = 1'b0;
		fail_page_done = 1'b0;	
		x_fail_page = 9'b0;
     		y_fail_page = 8'b0;
		fail_page_type = 5'd0;

        case (current_state)
		  
		S_DRAW_L1: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd121;
			y_fail_page = 8'd91;
			fail_page_type = 5'd21; 		
		end

		S_DRAW_E1: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd133;
			y_fail_page = 8'd91;
			fail_page_type = 5'd17; 
		end

		S_DRAW_V: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd145;
			y_fail_page = 8'd91;
			fail_page_type = 5'd28;  
		end

		S_DRAW_E2: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd157;
			y_fail_page = 8'd91;
			fail_page_type = 5'd17; 
		end

		S_DRAW_L2: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd169;
			y_fail_page = 8'd91;
			fail_page_type = 5'd21; 
		end

		S_DRAW_F: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd117;
			y_fail_page = 8'd115;
			fail_page_type = 5'd18; 
		end

		S_DRAW_A: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd129;
			y_fail_page = 8'd115;
			fail_page_type = 5'd15; 
		end

		S_DRAW_I: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd141;
			y_fail_page = 8'd115;
			fail_page_type = 5'd20; 
		end

		S_DRAW_L3: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd147;
			y_fail_page = 8'd115;
			fail_page_type = 5'd21; 
		end

		S_DRAW_E3: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd159;
			y_fail_page = 8'd115;
			fail_page_type = 5'd17; 
		end

		S_DRAW_D: begin
			start_draw_fail_page = 1'b1;
			x_fail_page = 9'd171;
			y_fail_page = 8'd115;
			fail_page_type = 5'd30; 
		end

		
		S_DONE_DRAW_FAIL_PAGE: fail_page_done = 1'b1;
		 

        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_WAIT_FOR_COMMAND;
        else
            current_state <= next_state;
    end // state_FFS
	 
endmodule

