function pval = TestCat(X)
M = size(X,2); %Attribute Number
dfs = 0;
chis = 0;
for m1=1:M-1
    x1 = X(:,m1);
    for m2=m1+1:M
        x2 = X(:,m2);
        df = (length(unique(x1))-1)*(length(unique(x2))-1);
        [~,chi,~] = crosstab(x1,x2);
        dfs = dfs + df;
        chis = chis + chi;
    end
end
pval = chi2cdf(chis,dfs,'upper');
end