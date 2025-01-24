`timescale 1ns/1ps

module encryptor_single_tb;

  parameter MSG_LEN = 1; // Single letter to encrypt
  parameter SEC_LEN = 3; // Length of the key

  logic [7:0] text_out [0:MSG_LEN-1];

  // Instantiate the encryptor module
  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) uut (
    .text_out(text_out)
  );

  initial begin
    // Overwrite the plaintext and key in the encryptor
    uut.text_in[0] = "H"; // Single letter to encrypt
    uut.secret[0] = "K"; // First key character
    uut.secret[1] = "E"; // Second key character
    uut.secret[2] = "Y"; // Third key character

    #10;

    // Display encrypted text
    $display("Encrypted single letter:");
    foreach (text_out[i]) begin
      $write("%0d ", text_out[i]); // Print encrypted numeric value
    end
    $display("");

    $stop;
  end

endmodule
