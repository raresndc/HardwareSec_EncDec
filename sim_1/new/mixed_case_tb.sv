`timescale 1ns/1ps

module mixed_case_tb;

    parameter MSG_LEN = 5;
    parameter SEC_LEN = 7;

    reg [7:0] plaintext[0:MSG_LEN-1];
    reg case_map[0:MSG_LEN-1];
    wire [7:0] encrypted[0:MSG_LEN-1];
    wire [7:0] decrypted[0:MSG_LEN-1];
    reg [7:0] final_decrypted[0:MSG_LEN-1];

    encryptor #(MSG_LEN, SEC_LEN) encrypt_inst(
        .text_in(plaintext),
        .text_out(encrypted)
    );

    decryptor #(MSG_LEN, SEC_LEN) decrypt_inst(
        .text_in(encrypted),
        .text_out(decrypted)
    );

    function [7:0] to_uppercase(input [7:0] char_in);
        begin
            if (char_in >= "a" && char_in <= "z") begin
                to_uppercase = char_in - 8'd32;
            end else begin
                to_uppercase = char_in;
            end
        end
    endfunction

    initial begin
        integer i;

        plaintext[0] = "H";
        plaintext[1] = "e";
        plaintext[2] = "L";
        plaintext[3] = "l";
        plaintext[4] = "o";
        
        $display("Original plaintext:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%c", plaintext[i]);
        end
        $display("");

        for (i = 0; i < MSG_LEN; i = i + 1) begin
            case_map[i] = (plaintext[i] >= "A" && plaintext[i] <= "Z") ? 1 : 0; // 1 if uppercase
            plaintext[i] = to_uppercase(plaintext[i]);
        end

        #10;

        for (i = 0; i < MSG_LEN; i = i + 1) begin
            final_decrypted[i] = decrypted[i];
            if (!case_map[i]) begin
                final_decrypted[i] = final_decrypted[i] + 8'd32;
            end
        end

        $display("Encrypted text:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%0d ", encrypted[i]);
        end
        $display("");

        $display("Decrypted text:");
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            $write("%c", final_decrypted[i]);
        end
        $display("");

        $stop;
    end

endmodule
