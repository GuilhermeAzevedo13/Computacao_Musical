function y = envelope(A,D,n1,n2,t)
    y = zeros(1,length(t));
    idxA = t < A;
    y(idxA) = (t(idxA)/A).^(1/n1);
    idxD = (t >= A) & (t < A+D);
    y(idxD) = 1 - ((t(idxD) - A)/D).^(1/n2);
end
