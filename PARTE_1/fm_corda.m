function y = fm_corda(frequencia, duracao, f_amostragem)
    f_port = frequencia;
    f_mod = frequencia;
    indice_brilho_inicial = 15;
    attack_time_amp = 0.01;
    decay_time_amp = duracao - attack_time_amp;
    env_portadora = @(t) envelope(attack_time_amp, decay_time_amp, 1, 3.0, t);
    attack_time_mod = 0.01;
    decay_time_mod = 0.4 * duracao;
    env_modulante = @(t) indice_brilho_inicial * envelope(attack_time_mod, decay_time_mod, 1, 2.0, t);
    y = fm_synth(f_port, f_mod, env_portadora, env_modulante, duracao, f_amostragem);
end
