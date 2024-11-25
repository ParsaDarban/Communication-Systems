
function [y] = CorrCovv(x, h)

    Lx = length(x);
    Lh = length(h);

    L = Lx + Lh - 1;
    %xl = [x];
    hl = [h, zeros(1, L - Lx-1)];

    % Flip the second signal
    h_flipped = fliplr(hl);

    
    % Perform the convolution
    y = Convolution(x, conj(h_flipped));
end

function [Yf]=Convolution(x,h)

LX = length(x);
LH = length(h);

% Create result vector y
Yf = zeros(1, LX + LH - 1);

% Perform convolution manually
for k = 1:LX+LH-1
    for m = 1:LH
        n = k - m + 1;
        if n >= 1 && n <= LX
            Yf(k) = Yf(k) + x(n) * h(m);
        end
    end
end
end
