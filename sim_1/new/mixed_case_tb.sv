`timescale 1ns/1ps

module mixed_case_tb;

    // Parameters
    parameter MSG_LEN = 6;
    parameter SEC_LEN = 3;

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

    // Convert to uppercase function
    function [7:0] to_uppercase(input [7:0] char_in);
        begin
            if (char_in >= "a" && char_in <= "z") begin
                to_uppercase = char_in - 8'd32; // Convert to uppercase
            end else begin
                to_uppercase = char_in; // No change for uppercase or non-alphabet
            end
        end
    endfunction

    // Test the encryptor and decryptor
    initial begin
        integer i;

        // Initialize plaintext (mixed case)
        plaintext[0] = "H";
        plaintext[1] = "e";
        plaintext[2] = "L";
        plaintext[3] = "l";
        plaintext[4] = "o";
        plaintext[5] = "W";

        // Convert mixed case plaintext to uppercase
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            plaintext[i] = to_uppercase(plaintext[i]);
        end

        // Wait for encryption and decryption to complete
        #10;

        // Print results
        $display("Original plaintext:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%c", plaintext[i]);
        end
        $display("");

        $display("Encrypted text:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%0d ", encrypted[i]);
        end
        $display("");

        $display("Decrypted text:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%c", decrypted[i]);
        end
        $display("");

        $stop;
    end

endmodule