module encryptor #(
    parameter MSG_LEN = 6,  // Number of characters in the plaintext
    parameter SEC_LEN = 3   // Length of the key
)(
    input  [7:0] text_in[0:MSG_LEN-1], // Plaintext input
    output reg [7:0] text_out[0:MSG_LEN-1] // Encrypted text output
);

    reg [7:0] sub_table[1:5][1:5];
    reg [7:0] secret  [0:SEC_LEN-1];   // Secret key

    // Initialize the table and key
    initial begin
        sub_table[1][1] = "M";  sub_table[1][2] = "I";  sub_table[1][3] = "H";  sub_table[1][4] = "A";  sub_table[1][5] = "B";
        sub_table[2][1] = "C";  sub_table[2][2] = "D";  sub_table[2][3] = "E";  sub_table[2][4] = "F";  sub_table[2][5] = "G";
        sub_table[3][1] = "K";  sub_table[3][2] = "L";  sub_table[3][3] = "N";  sub_table[3][4] = "O";  sub_table[3][5] = "P";
        sub_table[4][1] = "Q";  sub_table[4][2] = "R";  sub_table[4][3] = "S";  sub_table[4][4] = "T";  sub_table[4][5] = "U";
        sub_table[5][1] = "V";  sub_table[5][2] = "W";  sub_table[5][3] = "X";  sub_table[5][4] = "Y";  sub_table[5][5] = "Z";

        // Initialize key
        secret[0] = "K"; secret[1] = "E"; secret[2] = "Y";
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
    reg [7:0] pos_text, pos_sec;
    reg [3:0] r_text, c_text, r_sec, c_sec;

    always @* begin
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            // Get plaintext and key positions
            pos_text = get_position(text_in[i]);
            r_text = pos_text[7:4];
            c_text = pos_text[3:0];
            
            pos_sec = get_position(secret[i % SEC_LEN]);
            r_sec = pos_sec[7:4];
            c_sec = pos_sec[3:0];

            // Convert row-column into a single number and add
            text_out[i] = (r_text * 10 + c_text) + (r_sec * 10 + c_sec);
        end
    end

endmodule
