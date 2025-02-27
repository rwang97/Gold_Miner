
module counter_move_hook(input clk, input enable_my_counter, output enable_next, input [1:0] levels);
		
		wire enable_frame;
		Delay_Counter d0(clk, enable_my_counter, enable_frame, levels);
		Frame_Counter f0(clk, enable_my_counter, enable_frame, enable_next);
		
endmodule

module Delay_Counter(input clk, input enable_my_counter, output reg enable_frame, input [1:0] levels);
		reg [19:0] select_speed = 20'b0;
		
		always @(*) begin
			case (levels)
			2'd1: select_speed = 20'd750000;
			2'd2: select_speed = 20'd370000;
			2'd3: select_speed = 20'd200000;
			default: select_speed = 20'd0;
			
			endcase
		end
			
		
		reg [19:0] delay_counter = 20'b0;
		always @(posedge clk) begin
			if (enable_my_counter) begin
				if (delay_counter == select_speed) begin  //11001011011100110110 8333334  //11001011011100110101 8333333
					delay_counter <= 20'b0;
					enable_frame <= 1;
				end
			
				else begin
					delay_counter <= delay_counter + 1'b1;
					enable_frame <= 0;
				end
			end
			
			else begin
				delay_counter <= 20'b0;
				enable_frame <= 0;
			end
			
		end
		
endmodule

module Frame_Counter(input clk, input enable_my_counter, input enable_frame, output reg enable_next);
		reg [3:0] frame_counter = 4'b0;
		always @(posedge clk) begin
			if (enable_my_counter) begin
				if (frame_counter == 4'd1) begin
					enable_next <= 1;
					frame_counter <= 4'b0;
				end	
				
				else if (enable_frame) begin
					frame_counter <= frame_counter + 1'b1;
					enable_next <= 0;
				end
			end
			
			else begin
				frame_counter <= 4'b0;
				enable_next <= 0;
			end
			
		end
endmodule