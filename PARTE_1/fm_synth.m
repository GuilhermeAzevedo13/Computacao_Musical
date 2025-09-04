function y = fm_synth(f_port, f_mod, env_port, env_mod, duracao, f_amostragem)
    N = round(duracao * f_amostragem);
    t = (0:N-1).' / f_amostragem;
    A  = resolve_env(env_port, t, duracao);
    Bt = resolve_env(env_mod,  t, duracao);
    phi_c = 2*pi*f_port*t;
    phi_m = 2*pi*f_mod*t;
    y = A .* sin( phi_c + Bt .* sin(phi_m) );
end
