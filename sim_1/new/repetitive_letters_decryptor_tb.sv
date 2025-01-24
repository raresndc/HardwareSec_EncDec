`timescale 1ns/1ps

module decryptor_repetitive_tb;

  parameter MSG_LEN = 20; // Length of the message
  parameter SEC_LEN = 3;  // Length of the key

  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];

  // Instantiate the decryptor module
  decryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) uut (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );

  initial begin
    // Provide the encrypted text (output from the encryptor)
    encrypted_text[0] = 45; encrypted_text[1] = 37; encrypted_text[2] = 69; encrypted_text[3] = 46;
    encrypted_text[4] = 44; encrypted_text[5] = 75; encrypted_text[6] = 53; encrypted_text[7] = 45;
    encrypted_text[8] = 77; encrypted_text[9] = 54; encrypted_text[10] = 37; encrypted_text[11] = 68;
    encrypted_text[12] = 46; encrypted_text[13] = 38; encrypted_text[14] = 75; encrypted_text[15] = 52;
    encrypted_text[16] = 45; encrypted_text[17] = 76; encrypted_text[18] = 54; encrypted_text[19] = 46;

    // Overwrite the key
    uut.secret[0] = "K"; uut.secret[1] = "E"; uut.secret[2] = "Y";

    #10;

    // Display the decrypted text
    $display("Decrypted message:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]); // Print decrypted characters
    end
    $display("");

    $stop;
  end

endmodule
