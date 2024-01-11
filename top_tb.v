module top_tb;
reg clk;
reg rst;
integer i;
integer f;

top tie(.clk(clk),.rst(rst));

initial begin
   $readmemb("result.asm", tie.InstructionMemory.rom); 
   $display("rom load successfully\n");
   reset_dm;
   $display("RAM has been initalised\n");
   rst <= 1'b1;
   clk <= 1'b0;
   #2 rst <= 1'b0;
   #1 rst <= 1'b1;
   $display("CPU has been initialised\n");
   for(i=0;i<10000;i=i+1) begin
     #3 clk = ~clk;
   end
   display_all_regs;
   display_dm;
end

task display_all_regs;
		begin
			$display("display_all_regs:");
			$display("------------------------------");
			$display("   ACC      X      Y  ");
			$write("%d ",tie.ACC_value);
			$write("%d ",tie.X_value);
			$write("%d \n",tie.Y_value);
			$display("------------------------------");
			$display("FLAGS\n");
			$display("Z\tN\tC\tO\n");
			$display("%d\t%d\t%d\t%d\n",tie.FlagsRegister.ZERO,tie.FlagsRegister.NEGATIVE,tie.FlagsRegister.CARRY,tie.FlagsRegister.OVERFLOW);
		end
	endtask
	
task reset_dm;
    begin
      for(i=0;i<512;i=i+1) begin
          tie.DataMemory.ram[i] = 16'd0;
      end
    end
endtask
	
task display_dm;
    begin
      f = $fopen("mem.txt","w");
      $display("Writing Data Memory contents to file..");
      for(i=0;i<512;i=i+1) begin
          $fwrite(f,"%d : %d\n",i,tie.DataMemory.ram[i]);
      end
    end
endtask

endmodule

