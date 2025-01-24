`timescale 1ns/1ps

module encryptor_tb;

  // Parameters for the encryptor module
  localparam MSG_LEN = 6;
  localparam SEC_LEN = 3;

  // Signals for the DUT (Device Under Test)
  reg [7:0] text_in [0:MSG_LEN-1];
  reg [7:0] secret [0:SEC_LEN-1];
  wire [7:0] text_out [0:MSG_LEN-1];

  // Instantiate the encryptor module
  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) uut (
    .text_in(text_in),
    .secret(secret),
    .text_out(text_out)
  );

  integer i;

  // Testbench process
  initial begin
    // Initialize plaintext and secret
    text_in[0] = "H"; text_in[1] = "E"; text_in[2] = "L"; text_in[3] = "L"; text_in[4] = "O"; text_in[5] = "W";
    secret[0] = "K"; secret[1] = "E"; secret[2] = "Y";

    // Wait for combinational outputs to stabilize
    #10;

    // Display the results
    $display("Encrypted text:");
    for (i = 0; i < MSG_LEN; i = i + 1) begin
      $write("%s", text_out[i]);
    end
    $display("");

    // End simulation
    $stop;
  end

endmodule
