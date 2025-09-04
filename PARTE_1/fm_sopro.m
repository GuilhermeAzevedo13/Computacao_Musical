function y = fm_sopro(frequencia, duracao, f_amostragem)
    f_port = frequencia;
    f_mod = frequencia;
    indice_brilho = 6;
    attack_time = 0.2 * duracao;
    decay_time = 0.8 * duracao;
    env_portadora = @(t) envelope(attack_time, decay_time, 2, 2, t);
    env_modulante = @(t) indice_brilho * env_portadora(t);
    y = fm_synth(f_port, f_mod, env_portadora, env_modulante, duracao, f_amostragem);
end
