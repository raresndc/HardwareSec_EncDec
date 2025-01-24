`timescale 1ns/1ps

module tb_enc_dec_name;

  parameter MSG_LEN = 7;
  parameter SEC_LEN = 7;

  reg [7:0] plain_text [0:MSG_LEN-1];
  wire [7:0] encrypted_text [0:MSG_LEN-1];
  wire [7:0] decrypted_text [0:MSG_LEN-1];

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

  integer i;

  initial begin
    // Initialize the plain text (example: "NEDELCU")
    plain_text[0] = "N";
    plain_text[1] = "E";
    plain_text[2] = "D";
    plain_text[3] = "E";
    plain_text[4] = "L";
    plain_text[5] = "C";
    plain_text[6] = "U";

    #10;

    // Display plain text
    $display("Plain text:");
    foreach (plain_text[i]) begin
      $write("%c ", plain_text[i]);
    end
    $display(""); // Move to the next line

    #10;

    // Display encrypted text as row-column pairs
    $display("Encrypted text (row, column pairs):");
    foreach (encrypted_text[i]) begin
      $write("%0d%0d ", encrypted_text[i] / 10, encrypted_text[i] % 10); // Row-column pair
    end
    $display(""); // Move to the next line

    #10;

    // Display decrypted text
    $display("Decrypted text:");
    foreach (decrypted_text[i]) begin
      $write("%c ", decrypted_text[i]);
    end
    $display(""); // Move to the next line

    $stop;
  end

endmodule
