`timescale 1ns/1ps

module tb_single_letter;

  parameter MSG_LEN = 1;
  parameter SEC_LEN = 7;

  logic [7:0] plain_text [0:MSG_LEN-1];
  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];

  encryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) encryptor_inst (
    .text_in(plain_text),
    .text_out(encrypted_text)
  );

  decryptor #(
    .MSG_LEN(MSG_LEN),
    .SEC_LEN(SEC_LEN)
  ) decryptor_inst (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );

  initial begin
    plain_text[0] = "H";

    #10;

    $display("Encrypted single letter:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]);
    end
    $display("");

    #10;

    $display("Decrypted single letter:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]);
    end
    $display("");

    $stop;
  end

endmodule
