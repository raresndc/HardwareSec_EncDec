`timescale 1ns/1ps

module tb_single_letter;

  parameter MSG_LEN = 1; // Single letter to encrypt and decrypt
  parameter SEC_LEN = 3; // Length of the key

  logic [7:0] plain_text [0:MSG_LEN-1];
  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];

  // Instantiate the encryptor module
  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) encryptor_inst (
    .text_in(plain_text),
    .text_out(encrypted_text)
  );

  // Instantiate the decryptor module
  decryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) decryptor_inst (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );

  initial begin
    // Initialize the plaintext (single letter "H")
    plain_text[0] = "H";

    // Wait for encryption
    #10;

    // Display encrypted text
    $display("Encrypted single letter:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]); // Print encrypted numeric value
    end
    $display("");

    // Wait for decryption
    #10;

    // Display decrypted text
    $display("Decrypted single letter:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]); // Print decrypted character
    end
    $display("");

    $stop;
  end

endmodule
