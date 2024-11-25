function [Yf]=Convolution(x,h)

N = length(x);
M = length(h);

Yf = zeros(1, N + M - 1);

for k = 1:N+M-1
    for m = 1:M
        n = k - m + 1;
        if n >= 1 && n <= N
            Yf(k) = Yf(k) + x(n) * h(m);
        end
    end
end


disp(Yf);
plot(Yf);

