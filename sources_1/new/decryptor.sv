module decryptor #(
    parameter MSG_LEN,  // Number of characters in the ciphertext
    parameter SEC_LEN   // Length of the key
)(
    input  [7:0] text_in[0:MSG_LEN-1],  // Encrypted text input
    output reg [7:0] text_out[0:MSG_LEN-1] // Decrypted text output (plaintext)
);

    reg [7:0] sub_table[1:5][1:5];
    reg [7:0] secret [0:SEC_LEN-1]; // Secret key

    // Initialize the table and key
    initial begin
        sub_table[1][1] = "R";  sub_table[1][2] = "A";  sub_table[1][3] = "E";  sub_table[1][4] = "S";  sub_table[1][5] = "B";
        sub_table[2][1] = "C";  sub_table[2][2] = "D";  sub_table[2][3] = "F";  sub_table[2][4] = "G";  sub_table[2][5] = "H";
        sub_table[3][1] = "I";  sub_table[3][2] = "K";  sub_table[3][3] = "L";  sub_table[3][4] = "M";  sub_table[3][5] = "N";
        sub_table[4][1] = "O";  sub_table[4][2] = "P";  sub_table[4][3] = "Q";  sub_table[4][4] = "T";  sub_table[4][5] = "U";
        sub_table[5][1] = "V";  sub_table[5][2] = "W";  sub_table[5][3] = "X";  sub_table[5][4] = "Y";  sub_table[5][5] = "Z";

        // Initialize key
        secret[0] = "N"; secret[1] = "E"; secret[2] = "D";
        secret[3] = "E"; secret[4] = "L"; secret[5] = "C";
        secret[6] = "U";
    end

    // Function to find the position of a character in the table
    function [7:0] get_position(input [7:0] ch);
        integer r, c;
        begin
            get_position = 8'hFF; // Default invalid value
            for (r = 1; r <= 5; r = r + 1) begin
                for (c = 1; c <= 5; c = c + 1) begin
                    if (sub_table[r][c] == ch) begin
                        get_position = {r[3:0], c[3:0]}; // Combine row and column into one byte
                    end
                end
            end
        end
    endfunction

    integer i;
    reg [7:0] pos_sec;
    reg [7:0] num_cipher, num_sec;
    reg [3:0] r_res, c_res;

    always @* begin
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            // Get key position
            pos_sec = get_position(secret[i % SEC_LEN]);
            num_sec = (pos_sec[7:4] * 10) + pos_sec[3:0];

            // Subtract the key value from the ciphertext
            num_cipher = text_in[i] - num_sec;

            // Convert back to row-column
            r_res = num_cipher / 10;
            c_res = num_cipher % 10;

            // Map row-column back to the character
            text_out[i] = sub_table[r_res][c_res];
        end
    end

endmodule