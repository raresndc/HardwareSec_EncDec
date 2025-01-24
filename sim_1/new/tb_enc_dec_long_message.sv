`timescale 1ns/1ps

module tb_enc_dec_long_message;

  parameter MSG_LEN = 22; // Length of the message
  parameter SEC_LEN = 7;  // Length of the key

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
    // Initialize the plaintext with the message "HELLOTHISISATESTMESSAGE"
    plain_text[0] = "H"; plain_text[1] = "E"; plain_text[2] = "L"; plain_text[3] = "L"; plain_text[4] = "O";
    plain_text[5] = "T"; plain_text[6] = "H"; plain_text[7] = "I"; plain_text[8] = "S";
    plain_text[9] = "I"; plain_text[10] = "S"; plain_text[11] = "A";
    plain_text[12] = "T"; plain_text[13] = "E"; plain_text[14] = "S"; plain_text[15] = "T";
    plain_text[16] = "M"; plain_text[17] = "E"; plain_text[18] = "S"; plain_text[19] = "S";
    plain_text[20] = "A"; plain_text[21] = "G";

    #10;

    // Display the encrypted message
    $display("Encrypted message:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]); // Print encrypted numeric values
    end
    $display("");

    #10;

    // Display the decrypted message
    $display("Decrypted message:");
    foreach (decrypted_text[i]) begin
      $write("%c", decrypted_text[i]); // Print decrypted characters
    end
    $display(""); // Move to the next line

    $stop;
  end

endmodule