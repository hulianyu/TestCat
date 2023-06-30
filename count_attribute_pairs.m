function [num_pairs,total,X_edge] = count_attribute_pairs(X)
M = size(X,2); %Attribute Number
for m=2:M
    X(:,m) = X(:,m)+max(X(:,m-1));
end
X_edge = [];
for m1=1:M-1
    x1 = X(:,m1);
    list_i = unique(x1);
    for m2=m1+1:M
        x2 = X(:,m2);
        [table,~,~] = crosstab(x1,x2);
        table_full = table;
        table_full(end+1,1:end) = sum(table_full,1);
        table_full(:,end+1) = sum(table_full,2);
        total_num = table_full(end,end);
        Pi_plus = table_full(end,1:end-1)/total_num;
        Pj_plus = table_full(1:end-1,end)/total_num;
        miu = (table_full(end,1:end-1).*table_full(1:end-1,end))/total_num;
        % standardized residual
        sr = (table-miu)./sqrt(miu.*repmat(1-Pi_plus,size(table,1),1).*repmat(1-Pj_plus,1,size(table,2)));
        list_j = unique(x2);
        threshold = double(abs(sr)>=2); % Regarded to be correlated when their abs(standardized residuals) exceed 2
        for i=1:size(table,1)
            for j=1:size(table,2)
                mlist = [list_i(i) list_j(j)];
                mlist = [mlist sr(i,j) threshold(i,j)];
                X_edge = [X_edge;mlist];
            end
        end
    end
end
num_pairs = sum(X_edge(:,4));
total = size(X_edge,1);
end
