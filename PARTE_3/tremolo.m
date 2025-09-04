function y = tremolo(s, fs)
% Aplica um efeito de modulação de amplitude (tremolo).
    depth = 0.5; % Profundidade da oscilação
    f_mod = 5;   % 5 oscilações de volume por segundo
    t = (0:length(s)-1)/fs;
    mod_wave = (1 - depth) + depth * sin(2*pi*f_mod*t);
    y = s(:) .* mod_wave(:);
end