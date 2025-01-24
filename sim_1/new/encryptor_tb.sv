`timescale 1ns/1ps

module encryptor_tb;

  parameter MSG_LEN = 6;
  parameter SEC_LEN = 3;

  logic [7:0] text_out [0:MSG_LEN-1];

  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) uut (
    .text_out(text_out)
  );

  integer i;
  integer combined_value;
  integer r_text, c_text;

  initial begin
    #10;

    // Display encrypted text as row-column pairs
    $display("Encrypted text (row, column pairs):");
    foreach (text_out[i]) begin
      combined_value = text_out[i];
      r_text = combined_value / 10; // Extract the row
      c_text = combined_value % 10; // Extract the column
      $write("%0d%0d ", r_text, c_text); // Display as row-column pair
    end
    $display(""); // Move to the next line

    $stop;
  end

endmodule
