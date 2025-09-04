function y = fm_bate(frequencia, duracao, f_amostragem)
    f_port = frequencia;
    f_mod = frequencia * 1.4142;
    indice_brilho_inicial = 20;
    attack_time = 0.005;
    decay_time = duracao - attack_time;
    env_portadora = @(t) envelope(attack_time, decay_time, 1, 2.5, t);
    env_modulante = @(t) indice_brilho_inicial * env_portadora(t);
    y = fm_synth(f_port, f_mod, env_portadora, env_modulante, duracao, f_amostragem);
end
