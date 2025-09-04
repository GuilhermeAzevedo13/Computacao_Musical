function y = overdrive(s, ganho)
% Aplica um efeito de saturação suave (soft clipping).
    y = tanh(s * ganho);
end
