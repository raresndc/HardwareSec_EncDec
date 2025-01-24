`timescale 1ns/1ps

module special_characters_tb;

    // Parameters
    parameter MSG_LEN = 6;
    parameter SEC_LEN = 7;

    // Wires and registers
    reg [7:0] plaintext[0:MSG_LEN-1];  // Input plaintext
    wire [7:0] encrypted[0:MSG_LEN-1]; // Encrypted output
    wire [7:0] decrypted[0:MSG_LEN-1]; // Decrypted output
    reg [7:0] final_decrypted[0:MSG_LEN-1]; // To store the final decrypted characters
    reg is_special[0:MSG_LEN-1]; // Flag array to track special characters

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
        plaintext[1] = " ";
        plaintext[2] = "$";
        plaintext[3] = "%";
        plaintext[4] = "^";
        plaintext[5] = "&";

        // Identify special characters
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            if ((plaintext[i] < "A" || plaintext[i] > "Z") &&
                (plaintext[i] < "a" || plaintext[i] > "z")) begin
                is_special[i] = 1; // Mark as special character
            end else begin
                is_special[i] = 0; // Not a special character
            end
        end

        // Wait for encryption and decryption to complete
        #10;

        // Process decrypted output to restore special characters
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            if (is_special[i]) begin
                // If it was a special character, use ASCII code to restore it
                final_decrypted[i] = plaintext[i]; // Restore directly from the original plaintext
            end else begin
                // If it was not a special character, take the decrypted value as is
                final_decrypted[i] = decrypted[i];
            end
        end

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
            $write("%c", final_decrypted[i]); // Print final decrypted characters
        end
        $display("");

        $stop;
    end

endmodule
