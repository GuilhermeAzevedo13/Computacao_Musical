function v = resolve_env(env, t, duracao)
    if isa(env, 'function_handle')
        v = env(t);
        v = v(:);
    elseif isscalar(env)
        v = env * ones(size(t));
    elseif isvector(env)
        env = env(:);
        if length(env) == length(t)
            v = env;
        else
            x_env = linspace(0, duracao, length(env)).';
            v = interp1(x_env, env, t, 'linear', 'extrap');
        end
    else
        error('Envelope deve ser escalar, vetor ou função @(t).');
    end
end
