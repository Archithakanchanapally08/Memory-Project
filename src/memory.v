//--> Impelmenttaion of memory_design file:-

module memory(clk_i,rst_i,wr_rd_i,addr_i,wdata_i,rdata_o,valid_i,ready_o);
//--> Parameters declaration:-
	parameter DEPTH = 16;
	parameter WIDTH = 8;
	parameter ADDR_WIDTH= $clog2(DEPTH);

//--> input & output ports declaration:-
	input clk_i,rst_i;
	input wr_rd_i;
	input valid_i;
	output reg ready_o;
	input [ADDR_WIDTH-1:0] addr_i;
	input [WIDTH-1:0] wdata_i;
	output reg [WIDTH-1:0] rdata_o;

//--> Memory Allocation:-
	reg [WIDTH-1:0] mem [DEPTH-1:0];
	integer i;

//--> Memory Model:-
	always@(posedge clk_i)begin 
		if(rst_i==1)begin
			rdata_o =0;
			ready_o =0;
			for(i=0; i<DEPTH; i=i+1)begin 
				mem[i] =0;	
			end
		end
		else begin  
			if(valid_i==1)begin 
				ready_o=1;
				if(wr_rd_i==1) mem[addr_i] = wdata_i; //intA[i] = $urandom_range(10,90); 
				else rdata_o = mem[addr_i];
			end
			else ready_o=0;
		end
	end
endmodule
