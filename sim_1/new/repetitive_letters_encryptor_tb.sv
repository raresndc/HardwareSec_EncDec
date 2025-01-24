`timescale 1ns/1ps

module encryptor_repetitive_tb;

  parameter MSG_LEN = 20; // Length of the message
  parameter SEC_LEN = 3;  // Length of the key

  logic [7:0] text_out [0:MSG_LEN-1];

  // Instantiate the encryptor module
  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) uut (
    .text_out(text_out)
  );

  initial begin
    // Overwrite the plaintext with a message containing repetitive letters
    uut.text_in[0] = "A"; uut.text_in[1] = "A"; uut.text_in[2] = "B"; uut.text_in[3] = "B";
    uut.text_in[4] = "C"; uut.text_in[5] = "C"; uut.text_in[6] = "D"; uut.text_in[7] = "D";
    uut.text_in[8] = "E"; uut.text_in[9] = "E"; uut.text_in[10] = "A"; uut.text_in[11] = "A";
    uut.text_in[12] = "B"; uut.text_in[13] = "B"; uut.text_in[14] = "C"; uut.text_in[15] = "C";
    uut.text_in[16] = "D"; uut.text_in[17] = "D"; uut.text_in[18] = "E"; uut.text_in[19] = "E";

    // Overwrite the key
    uut.secret[0] = "K"; uut.secret[1] = "E"; uut.secret[2] = "Y";

    #10;

    // Display the encrypted text
    $display("Encrypted message:");
    foreach (text_out[i]) begin
      $write("%0d ", text_out[i]); // Print encrypted numeric values
    end
    $display("");

    $stop;
  end

endmodule
