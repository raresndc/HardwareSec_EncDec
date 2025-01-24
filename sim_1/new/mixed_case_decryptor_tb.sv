`timescale 1ns/1ps

module decryptor_mixed_case_tb;

  parameter MSG_LEN = 10; // Length of the word
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
    encrypted_text[0] = 44; // Replace with the actual result of encrypting "H" + "K"
    encrypted_text[1] = 188; // Replace with the actual result of encrypting "e" + "E"
    encrypted_text[2] = 86; // Replace with the actual result of encrypting "L" + "Y"
    encrypted_text[3] = 196; // Replace with the actual result of encrypting "l" + "K"
    encrypted_text[4] = 57; // Replace with the actual result of encrypting "O" + "E"
    encrypted_text[5] = 219; // Replace with the actual result of encrypting "w" + "Y"
    encrypted_text[6] = 65; // Replace with the actual result of encrypting "O" + "K"
    encrypted_text[7] = 188; // Replace with the actual result of encrypting "r" + "E"
    encrypted_text[8] = 86; // Replace with the actual result of encrypting "L" + "Y"
    encrypted_text[9] = 196; // Replace with the actual result of encrypting "d" + "K"

    // Overwrite the key
    uut.secret[0] = "K"; uut.secret[1] = "E"; uut.secret[2] = "Y";

    #10;

    // Display the decrypted text
    $display("Decrypted mixed-case word:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]); // Print decrypted characters
    end
    $display("");

    $stop;
  end

endmodule
