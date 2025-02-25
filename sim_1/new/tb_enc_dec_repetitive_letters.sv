`timescale 1ns/1ps

module tb_enc_dec_repetitive;

  parameter MSG_LEN = 20;
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
    plain_text[0] = "A"; plain_text[1] = "A"; plain_text[2] = "B"; plain_text[3] = "B";
    plain_text[4] = "C"; plain_text[5] = "C"; plain_text[6] = "D"; plain_text[7] = "D";
    plain_text[8] = "E"; plain_text[9] = "E"; plain_text[10] = "A"; plain_text[11] = "A";
    plain_text[12] = "B"; plain_text[13] = "B"; plain_text[14] = "C"; plain_text[15] = "C";
    plain_text[16] = "D"; plain_text[17] = "D"; plain_text[18] = "E"; plain_text[19] = "E";

    #10;

    $display("Encrypted message:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]);
    end
    $display("");

    #10;

    $display("Decrypted message:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]);
    end
    $display("");

    $stop;
  end

endmodule