module fifo_dc(
    input clk_w,clk_r,rst,re_en,wr_en,
    input [7:0] buf_in,
    output reg [7:0] buf_out,
    output reg [7:0]count,
    output reg buf_full,buf_emp
    );
    reg [5:0]wr_ptr,rd_ptr;
    reg[7:0] u[63:0];
    always @(count) begin
        buf_full <= (count == 64);
        buf_emp  <= (count == 0);
end
    always@(posedge clk_w or posedge rst)begin
    if(rst)
        count<=0;
    else if(!buf_full && wr_en)
        count<=count+1;
        end
    always@(posedge clk_r or posedge rst)begin
    if(rst)
        count<=0;
    else if(!buf_emp && re_en)
        count<=count-1;  
    end
    always@(posedge clk_r or posedge rst)begin
    if(rst)
        buf_out<=0;
    else begin
        if(!buf_emp && re_en)
            buf_out<=u[rd_ptr];
       else
            buf_out<=buf_out;
     end
     end   
     always @(posedge clk_w)begin
        if(!buf_full && wr_en)
            u[wr_ptr]<=buf_in;
        else
            u[wr_ptr]<=u[wr_ptr];
     end 
     always@(posedge clk_w or posedge rst)begin
        if(rst)begin
            wr_ptr<=0;
         end
         else begin
            if(!buf_full && wr_en)
                wr_ptr<=wr_ptr+1;
            else
                wr_ptr<=wr_ptr;
            if(!buf_emp && re_en)
                rd_ptr<=rd_ptr+1;
            else
                rd_ptr<=rd_ptr;
          end
        end
         always@(posedge clk_r or posedge rst)begin
        if(rst)begin
            rd_ptr<=0;
         end
          else begin
            if(!buf_emp && re_en)
                rd_ptr<=rd_ptr+1;
            else
                rd_ptr<=rd_ptr;
          end
        end
endmodule
