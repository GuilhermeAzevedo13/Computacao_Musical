function y = distorcao(s, ganho)
% Aplica um efeito de saturação pesada (hard clipping).
    y = s * ganho;
    y(y > 1) = 1;
    y(y < -1) = -1;
end