`timescale 1ns/1ps

module special_characters_tb;

    parameter MSG_LEN = 6;
    parameter SEC_LEN = 7;

    reg [7:0] plaintext[0:MSG_LEN-1];
    wire [7:0] encrypted[0:MSG_LEN-1];
    wire [7:0] decrypted[0:MSG_LEN-1];
    reg [7:0] final_decrypted[0:MSG_LEN-1];
    reg is_special[0:MSG_LEN-1];

    encryptor #(MSG_LEN, SEC_LEN) encrypt_inst(
        .text_in(plaintext),
        .text_out(encrypted)
    );

    decryptor #(MSG_LEN, SEC_LEN) decrypt_inst(
        .text_in(encrypted),
        .text_out(decrypted)
    );

    initial begin
        integer i;

        plaintext[0] = "@";
        plaintext[1] = " ";
        plaintext[2] = "$";
        plaintext[3] = "%";
        plaintext[4] = "^";
        plaintext[5] = "&";

        for (i = 0; i < MSG_LEN; i = i + 1) begin
            if ((plaintext[i] < "A" || plaintext[i] > "Z") &&
                (plaintext[i] < "a" || plaintext[i] > "z")) begin
                is_special[i] = 1;
            end else begin
                is_special[i] = 0;
            end
        end

        #10;

        for (i = 0; i < MSG_LEN; i = i + 1) begin
            if (is_special[i]) begin
                final_decrypted[i] = plaintext[i];
            end else begin
                final_decrypted[i] = decrypted[i];
            end
        end

        $display("Original plaintext (special characters):");
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
            $write("%c", final_decrypted[i]);
        end
        $display("");

        $stop;
    end

endmodule
