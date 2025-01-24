`timescale 1ns/1ps

module decryptor_single_tb;

  parameter MSG_LEN = 1; // Single letter to decrypt
  parameter SEC_LEN = 3; // Length of the key

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
    // Provide the encrypted value (output from encryptor)
    encrypted_text[0] = 44; // Replace with the actual encrypted result of "H" + "K"

    // Overwrite the key in the decryptor
    uut.secret[0] = "K"; // First key character
    uut.secret[1] = "E"; // Second key character
    uut.secret[2] = "Y"; // Third key character

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
