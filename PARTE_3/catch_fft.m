function f0 = catch_fft(x, Fs, fmin, fmax)
    N = length(x);
    nfft = 2^nextpow2(N);
    X = fft(x .* hann_local(N), nfft);
    f = (0:nfft-1)*(Fs/nfft);
    mag = abs(X);
    kmin = max(2, floor(fmin/(Fs/nfft))+1);
    kmax = min(floor(fmax/(Fs/nfft))+1, floor(nfft/2));
    [~,k] = max(mag(kmin:kmax));
    k = k + kmin - 1;
    f0 = f(k);
end