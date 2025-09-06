function f0 = estimar_autocorr(x, Fs, fmin, fmax)
    x = x(:);
    N = length(x);
    w = hann_local(N);
    xw = x .* w;
    nfft = 2^nextpow2(2*N-1);
    X = fft(xw, nfft);
    r = real(ifft(abs(X).^2));
    r = r(1:N);
    lag_min = max(1, floor(Fs/fmax));
    lag_max = min(N-1, ceil(Fs/fmin));
    if lag_min >= lag_max
        f0 = catch_fft(x, Fs, fmin, fmax);
        return;
    end
    r_search = r(lag_min:lag_max);
    [~, idx] = max(r_search);
    lag0 = lag_min + idx - 1;
    f0 = Fs / lag0;
    if ~isfinite(f0) || f0 < fmin || f0 > fmax
        f0 = catch_fft(x, Fs, fmin, fmax);
    end
end