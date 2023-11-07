module inst_mem #(
    int XLEN = 32,
    int ILEN = 32
) (
    output wire [ILEN-1:0] inst,
    input logic [XLEN-1:0] pc,
    input logic [ILEN-1:0] wdata,
    input logic write_en,
    input logic clock,
    input logic reset_n
);

  logic [7:0] mem[1024];

  always_ff @(posedge clock) begin
    if (write_en && !reset_n) begin
      mem <= '{default: '0};
    end else if (write_en) begin
      {mem[pc+3], mem[pc+2], mem[pc+1], mem[pc+0]} <= wdata;
    end
  end

  assign inst = {mem[pc+3], mem[pc+2], mem[pc+1], mem[pc+0]};

endmodule