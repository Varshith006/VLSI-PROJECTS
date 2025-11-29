module fifo_dc_tb;
reg clk_r,clk_w, rst, re_en, wr_en;
 reg [7:0] buf_in;

    // Outputs
    wire [7:0] buf_out;
    wire [7:0] count;
    wire buf_full, buf_emp;

    fifo_dc dut (
        .clk_w(clk_w),
        .clk_r(clk_r),
        .rst(rst),
        .re_en(re_en),
        .wr_en(wr_en),
        .buf_in(buf_in),
        .buf_out(buf_out),
        .count(count),
        .buf_full(buf_full),
        .buf_emp(buf_emp));

always #5 clk_r=~clk_r;
always #5 clk_w=~clk_w;
 initial begin
        // Initialize signals
        clk_w = 0;clk_r=0; rst = 1; re_en = 0; wr_en = 0; buf_in = 8'h00;
        
        // Apply reset
        #10 rst = 0;
        
        // Write few values into FIFO
        $display("Writing Data");
        repeat(5) begin
            @(negedge clk_w);
            wr_en = 1; re_en = 0;
            buf_in = buf_in + 8'h11; // increment input data
        end

        @(negedge clk_w);
        wr_en = 0;

        // Read few values from FIFO
        $display("Reading Data");
        repeat(3) begin
            @(negedge clk_r);
            wr_en = 0; re_en = 1;
        end

        @(negedge clk_r);
        re_en = 0;

        // Simultaneous read/write
        $display("Simultaneous Read/Write");
        repeat(4) begin
            @(negedge clk_r or negedge clk_w );
            wr_en = 1; re_en = 1;
            buf_in = buf_in + 8'h22;
        end

        @(negedge clk_r or negedge clk_w);
        wr_en = 0; re_en = 0;

        // End simulation
        #20;
        $display("Simulation complete.");
        $stop;
    end

endmodule
