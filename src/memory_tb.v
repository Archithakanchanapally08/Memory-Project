`include "memory.v"

`define PRINT_F 0
module top;
//--> Parameters declaration:-
	parameter DEPTH = 16;
	parameter WIDTH = 16;
	parameter ADDR_WIDTH= $clog2(DEPTH);

//--> inputs as reg & output's as wire:-
	reg clk_i,rst_i;
	reg wr_rd_i;
	reg [ADDR_WIDTH-1:0] addr_i;
	reg [WIDTH-1:0] wdata_i;
	wire [WIDTH-1:0] rdata_o;
	reg valid_i;
	wire ready_o;

	integer i;
	reg [25*8:0] testname;

	memory #(.DEPTH(DEPTH),.WIDTH(WIDTH)) dut(
												.clk_i		(clk_i),
												.rst_i		(rst_i),
												.wr_rd_i	(wr_rd_i),
												.addr_i		(addr_i),
												.wdata_i	(wdata_i),
												.rdata_o	(rdata_o),
												.valid_i	(valid_i),
												.ready_o	(ready_o));
	//--> Clock_Generation:-
	initial begin  
		clk_i=0; 
		forever #5 clk_i=~clk_i; 
	end

	initial begin  
		reset_mem();
		$value$plusargs("testname=%0s",testname);
		$display("\n****************************************************************"); 
		$display("\t--> Passing Testcase_name:- %0s",testname); 
		$display("****************************************************************\n"); 

		case(testname) 
			"test_1wr":write_mem(5,6);
			"test_5wr":write_mem(6,11);
			"test_nwr":write_mem(0,8);
			"test_1wr_1rd":begin 
				write_mem(5,6);
				read_mem(5,6);
			end
			"test_5wr_5rd":begin
				write_mem(6,11);
				read_mem(6,11);
			end
			"test_nwr_nrd":begin
				write_mem(0,8);
				read_mem(0,8);
			end
			"test_1st_portion_wr":write_mem(0,(DEPTH/4));
			"test_2nd_portion_wr":write_mem(0,(DEPTH/2));
			"test_3rd_portion_wr":write_mem(0,3*(DEPTH/4));
			"test_4th_portion_wr":write_mem(0,DEPTH);
			"test_1st_portion_wr_rd":begin 
				write_mem(0,(DEPTH/4));
				read_mem(0,(DEPTH/4));
			end
			"test_2nd_portion_wr_rd":begin 
				write_mem(0,(DEPTH/2));
				read_mem(0,(DEPTH/2));
			end
			"test_3rd_portion_wr_rd":begin 
				write_mem(0,3*(DEPTH/4));
				read_mem(0,3*(DEPTH/4));
			end
			"test_4th_portion_wr_rd":begin 
				write_mem(0,DEPTH);
				read_mem(0,DEPTH);
			end

			"test_only_1portion_wr":write_mem(0,(DEPTH/4));
			"test_only_2portion_wr":write_mem((DEPTH/4),(DEPTH/2));
			"test_only_3portion_wr":write_mem((DEPTH/2),3*(DEPTH/4));
			"test_only_4portion_wr":write_mem(3*(DEPTH/4),DEPTH);
			"test_only_1portion_wr_rd":begin 
				write_mem(0,(DEPTH/4));
				read_mem(0,(DEPTH/4));
			end
			"test_only_2portion_wr_rd":begin 
				write_mem((DEPTH/4),(DEPTH/2));
				read_mem((DEPTH/4),(DEPTH/2));
			end
			"test_only_3portion_wr_rd":begin 
				write_mem((DEPTH/2),3*(DEPTH/4));
				read_mem((DEPTH/2),3*(DEPTH/4));
			end
			"test_only_4portion_wr_rd":begin 
				write_mem(3*(DEPTH/4),DEPTH);
				read_mem(3*(DEPTH/4),DEPTH);
			end

	//--> Back_door Test_cases:-
			"test_bd_wr_bd_rd":begin 
				mem_bd_write();	
				mem_bd_read();	
			end
			"test_bd_wr_fd_rd":begin 
				mem_bd_write();	
				read_mem(0,DEPTH);
			end
			"test_fd_wr_bd_rd":begin 
				write_mem(0,DEPTH);
				mem_bd_read();	
			end
			"test_fd_wr_fd_rd":begin 
				write_mem(0,DEPTH);
				read_mem(0,DEPTH);
			end
			"test_rand_wr_rd":begin 
				write_mem(0,DEPTH);
				read_mem(0,DEPTH);
			end
		endcase
		#100;
		$finish(2);
	end

//--> Memory_reset_task:-
	task reset_mem();
		begin 
			rst_i=1; 
			wr_rd_i=0;
			addr_i=0;
			wdata_i=0;
			valid_i=0;
			repeat(2)@(posedge clk_i);
			rst_i=0; 
		end 
	endtask

//--> Memory_write_task:-
	integer temp_addr[DEPTH-1:0];
	task write_mem(input integer start_loc, end_loc);
	begin 
		if(`PRINT_F==1)$display("\t--> Writing the Data into the memory\n"); 
		for(i=start_loc; i<end_loc; i=i+1)begin 
			@(posedge clk_i);
			valid_i = 1;
			wait(ready_o==1);
			wr_rd_i = 1; //--> write_mode
			if(testname=="test_rand_wr_rd")begin 
				addr_i = $random();
				temp_addr[i] = addr_i;
			end
			else addr_i = i; // 0 1 2 3 4 5 .... DEPTH no.of loc
			wdata_i =  $random();
			if(`PRINT_F==1)	$display("\t--> Address:- %0d || Write_data:- %0h",addr_i,wdata_i); 
		end
			@(posedge clk_i);
			valid_i = 0;
			wr_rd_i = 0;
			addr_i = 0;
			wdata_i = 0;
	end
	endtask
	
//--> Memory_Read_task:-
	task read_mem(input integer start_loc,end_loc);
	begin 
		if(`PRINT_F==1)	$display("================================================="); 
		if(`PRINT_F==1)	$display("\t--> Reading the Data from the memory\n"); 
		for(i=start_loc; i<end_loc; i=i+1)begin 
			@(posedge clk_i);
			valid_i = 1;
			wait(ready_o==1);
			wr_rd_i = 0; //--> read_mode
			if(testname=="test_rand_wr_rd")addr_i = temp_addr[i]; 
			else addr_i = i;
			if(`PRINT_F==1)	$monitor("\t--> Address:- %0d || Read_data:- %0h",addr_i,rdata_o); 
		end
			@(posedge clk_i);
			valid_i = 0;
			wr_rd_i = 0;
			addr_i = 0;
	end
	endtask

//--> back_door write_into the memory:-
	task mem_bd_write();
		begin 
			for(i=0; i<DEPTH; i=i+1)begin 
				$readmemh("write_data_mem.hex", dut.mem);	
			end
		end
	endtask

//--> back_door read from the memory:-
	task mem_bd_read();
		begin 
			for(i=0; i<DEPTH; i=i+1)begin 
				$writememb("read_data_mem.bin", dut.mem);	
			end
		end
	endtask

endmodule
