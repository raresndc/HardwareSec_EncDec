`timescale 1ns/1ps

module decryptor_tb;

  parameter MSG_LEN = 6;
  parameter SEC_LEN = 3;

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
    // Initialize the encrypted text (from the encryption process)
    encrypted_text[0] = 44;  // Corresponding to "H" + "K"
    encrypted_text[1] = 46;  // Corresponding to "E" + "E"
    encrypted_text[2] = 86;  // Corresponding to "L" + "Y"
    encrypted_text[3] = 63;  // Corresponding to "L" + "K"
    encrypted_text[4] = 57;  // Corresponding to "O" + "E"
    encrypted_text[5] = 106; // Corresponding to "W" + "Y"

    #10;

    // Display decrypted text
    $display("Decrypted text:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]); // Print each character
    end
    $display(""); // Move to the next line

    $stop;
  end

endmodule
