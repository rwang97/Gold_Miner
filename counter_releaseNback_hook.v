
module counter_releaseNback_hook(input clk, input enable_my_counter, output enable_next);
		
		wire enable_frame;
		Delay_Counter2 d0(clk, enable_my_counter, enable_frame);
		Frame_Counter2 f0(clk, enable_my_counter, enable_frame, enable_next);
		
endmodule

module Delay_Counter2(input clk, input enable_my_counter, output reg enable_frame);
		reg [19:0] delay_counter = 20'b0;
		always @(posedge clk) begin
			if (enable_my_counter) begin
				if (delay_counter == 20'd250000/*20'd833334*/) begin  //11001011011100110110 8333334  //11001011011100110101 8333333
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

module Frame_Counter2(input clk, input enable_my_counter, input enable_frame, output reg enable_next);
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