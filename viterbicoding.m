function viterbi_coding()
    % Take input bits from the user
    input_bits = input('Enter the input bit sequence (e.g., [1 0 1 1 0]): ');

    % Check if the input is valid
    if ~isvector(input_bits) || ~all(ismember(input_bits, [0, 1]))
        error('Invalid input. Please enter a vector of 0s and 1s.');
    end

    % Take the convolutional rate from the user
    rate = input('Enter the convolutional rate (e.g., 1/2 or 1/3): ', 's');

    % Define the trellis based on the rate
    switch rate
        case '1/2'
            % Generator polynomials for rate 1/2: [7 5] (in octal)
            trellis = poly2trellis(3, [7 5]);
        case '1/3'
            % Generator polynomials for rate 1/3: [7 5 4] (in octal)
            trellis = poly2trellis(3, [7 5 4]);
        otherwise
            error('Unsupported convolutional rate. Please enter 1/2 or 1/3.');
    end

    % Encode the input bits
    encoded_bits = convenc(input_bits, trellis);

    % Display encoded bits
    disp('Encoded Bits:');
    disp(encoded_bits);

    % Decode the received (possibly noisy) bits using Viterbi algorithm
    decoded_bits = viterbi_decoder(encoded_bits, trellis);

    % Display decoded bits
    disp('Decoded Bits:');
    disp(decoded_bits);

    % Compare the decoded bits with the original input message
    if isequal(input_bits, decoded_bits)
        disp('Decoding successful. The original message was recovered.');
    else
        disp('Decoding failed. The original message was not recovered.');
    end
end

% Local function for Viterbi decoder
function decoded_bits = viterbi_decoder(encoded_bits, trellis)
    % Viterbi decoding of the encoded bits using the defined trellis
    decoded_bits = vitdec(encoded_bits, trellis, 5, 'trunc', 'hard');
end
