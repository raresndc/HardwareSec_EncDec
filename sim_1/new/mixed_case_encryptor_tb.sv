`timescale 1ns/1ps

module encryptor_decryptor_mixed_case_tb;

  parameter MSG_LEN = 10;
  parameter SEC_LEN = 3;

  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];

  // Instantiate Encryptor
  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) encryptor_inst (
    .text_out(encrypted_text)
  );

  // Instantiate Decryptor
  decryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) decryptor_inst (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );

  initial begin
    // Overwrite the plaintext with mixed-case letters
    encryptor_inst.text_in[0] = "H"; encryptor_inst.text_in[1] = "e";
    encryptor_inst.text_in[2] = "L"; encryptor_inst.text_in[3] = "l";
    encryptor_inst.text_in[4] = "O"; encryptor_inst.text_in[5] = "w";
    encryptor_inst.text_in[6] = "O"; encryptor_inst.text_in[7] = "r";
    encryptor_inst.text_in[8] = "L"; encryptor_inst.text_in[9] = "d";

    // Overwrite the key
    encryptor_inst.secret[0] = "K"; encryptor_inst.secret[1] = "E";
    encryptor_inst.secret[2] = "Y";

    decryptor_inst.secret[0] = "K"; decryptor_inst.secret[1] = "E";
    decryptor_inst.secret[2] = "Y";

    #10;

    // Display encrypted text
    $display("Encrypted mixed-case word:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]);
    end
    $display("");

    // Display decrypted text
    $display("Decrypted mixed-case word:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]);
    end
    $display("");

    $stop;
  end

endmodule
