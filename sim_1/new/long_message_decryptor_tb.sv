`timescale 1ns/1ps

module decryptor_message_tb;

  parameter MSG_LEN = 22; // Length of the message to decrypt
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
    // Provide the encrypted values (output from the encryptor)
    // Replace the values below with the actual encrypted results from encryptor_message_tb
    encrypted_text[0] = 44;  encrypted_text[1] = 46;  encrypted_text[2] = 86;
    encrypted_text[3] = 63;  encrypted_text[4] = 57;  encrypted_text[5] = 98;
    encrypted_text[6] = 44;  encrypted_text[7] = 35;  encrypted_text[8] = 97;
    encrypted_text[9] = 43;  encrypted_text[10] = 66; encrypted_text[11] = 68;
    encrypted_text[12] = 75; encrypted_text[13] = 46; encrypted_text[14] = 97;
    encrypted_text[15] = 75; encrypted_text[16] = 34; encrypted_text[17] = 77;
    encrypted_text[18] = 74;  encrypted_text[19] = 66; encrypted_text[20] = 68;
    encrypted_text[21] = 56;

    uut.secret[0] = "K"; // Key: K, E, Y
    uut.secret[1] = "E";
    uut.secret[2] = "Y";

    #10;

    // Display decrypted text
    $display("Decrypted message:");
    foreach (decrypted_text[i]) begin
      $write("%c", decrypted_text[i]); // Print decrypted characters
    end
    $display(""); // Move to the next line

    $stop;
  end

endmodule
