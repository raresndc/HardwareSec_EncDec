`timescale 1ns/1ps

module encryptor_message_tb;

  parameter MSG_LEN = 22; // Length of the message to encrypt
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
    // Overwrite the plaintext and key in the encryptor
    uut.text_in[0] = "H"; uut.text_in[1] = "E"; uut.text_in[2] = "L"; uut.text_in[3] = "L"; uut.text_in[4] = "O";
    uut.text_in[5] = "T"; uut.text_in[6] = "H"; uut.text_in[7] = "I"; uut.text_in[8] = "S";
    uut.text_in[9] = "I"; uut.text_in[10] = "S"; uut.text_in[11] = "A";
    uut.text_in[12] = "T"; uut.text_in[13] = "E"; uut.text_in[14] = "S"; uut.text_in[15] = "T";
    uut.text_in[16] = "M"; uut.text_in[17] = "E"; uut.text_in[18] = "S"; uut.text_in[19] = "S";
    uut.text_in[20] = "A"; uut.text_in[21] = "G"; // Message: "HELLOTHISISATESTMESSAGE"

    uut.secret[0] = "K"; // Key: K, E, Y
    uut.secret[1] = "E";
    uut.secret[2] = "Y";

    #10;

    // Display encrypted text
    $display("Encrypted message:");
    foreach (text_out[i]) begin
      $write("%0d ", text_out[i]); // Print encrypted numeric values
    end
    $display("");

    $stop;
  end

endmodule
