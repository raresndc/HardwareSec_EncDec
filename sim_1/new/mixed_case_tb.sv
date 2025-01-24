module mixed_case_tb();

    // Parameters
    parameter MSG_LEN = 6;
    parameter SEC_LEN = 3;

    // Wires and registers
    reg [7:0] plaintext[0:MSG_LEN-1];  // Input plaintext
    wire [7:0] encrypted[0:MSG_LEN-1]; // Encrypted output
    wire [7:0] decrypted[0:MSG_LEN-1]; // Decrypted output
    wire case_info[0:MSG_LEN-1];       // Case information

    // Encryption and decryption modules
    encryptor #(MSG_LEN, SEC_LEN) encrypt_inst(
        .text_in(plaintext),
        .text_out(encrypted),
        .case_info(case_info)
    );

    decryptor #(MSG_LEN, SEC_LEN) decrypt_inst(
        .text_in(encrypted),
        .case_info(case_info),
        .text_out(decrypted)
    );

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
            $write("%c", encrypted[i]);
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
