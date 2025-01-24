`timescale 1ns/1ps

module special_characters_tb;

    // Parameters
    parameter MSG_LEN = 6;
    parameter SEC_LEN = 7;

    // Wires and registers
    reg [7:0] plaintext[0:MSG_LEN-1];  // Input plaintext
    wire [7:0] encrypted[0:MSG_LEN-1]; // Encrypted output
    wire [7:0] decrypted[0:MSG_LEN-1]; // Decrypted output

    // Encryption and decryption modules
    encryptor #(MSG_LEN, SEC_LEN) encrypt_inst(
        .text_in(plaintext),
        .text_out(encrypted)
    );

    decryptor #(MSG_LEN, SEC_LEN) decrypt_inst(
        .text_in(encrypted),
        .text_out(decrypted)
    );

    // Test the encryptor and decryptor with special characters
    initial begin
        integer i;

        // Initialize plaintext with special characters
        plaintext[0] = "@";
        plaintext[1] = "#";
        plaintext[2] = "$";
        plaintext[3] = "%";
        plaintext[4] = "^";
        plaintext[5] = "&";

        // Wait for encryption and decryption to complete
        #10;

        // Print results
        $display("Original plaintext (special characters):");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%c", plaintext[i]);
        end
        $display("");

        $display("Encrypted text:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%0d ", encrypted[i]); // Print encrypted numeric values
        end
        $display("");

        $display("Decrypted text:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%c", decrypted[i]); // Print decrypted characters
        end
        $display("");

        $stop;
    end

endmodule

//The function get_position will return an invalid value (8'hFF), causing the encryption and decryption processes to fail.