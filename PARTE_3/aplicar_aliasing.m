function y_alias = aplicar_aliasing(s, fs)
% Função principal que gera o efeito de aliasing em um sinal de entrada.
    y = s(:);
    y = y - mean(y); % Remove componente DC

    % Estima a frequência fundamental (f0) para um aliasing mais "inteligente"
    fmin = 20;
    fmax = min(2000, 0.9*(fs/2));
    f0   = estimar_autocorr(y, fs, fmin, fmax);
    
    % Calcula uma frequência de amostragem alvo que irá causar aliasing
    Fs_alias_target = max(2*fmin, 1.5*f0);
    M = max(2, round(fs / Fs_alias_target)); % Fator de downsampling (pelo menos 2)

    % Downsample SEM filtro anti-aliasing (é aqui que o efeito é criado)
    y_ds = y(1:M:end);

    % Volta para a frequência de amostragem original repetindo as amostras
    y_alias = kron(y_ds, ones(M,1));
    
    % Garante que o sinal de saída tenha o mesmo tamanho do original
    if length(y_alias) > length(y)
        y_alias = y_alias(1:length(y));
    elseif length(y_alias) < length(y)
        y_alias(end+1:length(y)) = 0;
    end
end