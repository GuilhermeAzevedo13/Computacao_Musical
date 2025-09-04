function y = fm_trompete(frequencia, duracao, f_amostragem)
    f_port = frequencia;
    f_mod = frequencia * 1.2;  
    indice_brilho = 8.5;
    attack_time = 0.05 * duracao;
    decay_time = 0.3 * duracao;
    sustain_level = 0.7;  % Nível de sustain
    sustain_time = 0.5 * duracao;
    release_time = 0.15 * duracao;
    env_portadora = @(t) envelope_trompete(attack_time, decay_time, sustain_level, ...
                                         sustain_time, release_time, t, duracao);
    
    env_modulante = @(t) indice_brilho * env_portadora(t) .* (1 + 0.3 * sin(2*pi*5*t));
    
    y = fm_synth(f_port, f_mod, env_portadora, env_modulante, duracao, f_amostragem);

    if duracao > 1.0
        N = round(duracao * f_amostragem);
        t = (0:N-1).' / f_amostragem;
        vibrato_freq = 6;  
        vibrato_depth = 0.02;  
        vibrato_env = max(0, (t - 0.5*duracao) / (0.5*duracao));  
        vibrato_env(vibrato_env < 0) = 0;
        
        vibrato_mod = vibrato_depth * vibrato_env .* sin(2*pi*vibrato_freq*t);
        phase_mod = 2*pi * frequencia * cumsum(vibrato_mod) / f_amostragem;
        y = y .* cos(phase_mod);
    end
    
    y = clipa_fofo(y, 1.2);  % Clipping suave
    
    % Normaliza para evitar clipping
    y = y / max(abs(y)) * 0.8;
end

function y = envelope_trompete(A, D, S_level, S_time, R, t, duracao_total)
    % Envelope ADSR para trompete
    % A = Attack, D = Decay, S_level = Sustain level, S_time = Sustain time, R = Release
    
    y = zeros(size(t));

    idx_A = t < A;
    y(idx_A) = (t(idx_A) / A).^0.5;  % Ataque rápido mas suave
    
    idx_D = (t >= A) & (t < A + D);
    y(idx_D) = 1 - (1 - S_level) * ((t(idx_D) - A) / D).^1.5;
    
    sustain_start = A + D;
    sustain_end = sustain_start + S_time;
    idx_S = (t >= sustain_start) & (t < sustain_end);
    y(idx_S) = S_level;
    
    idx_R = (t >= sustain_end) & (t < duracao_total);
    if any(idx_R)
        t_release = t(idx_R) - sustain_end;
        y(idx_R) = S_level * (1 - (t_release / R).^2);
    end

    y(y < 0) = 0;
    y(y > 1) = 1;
end
