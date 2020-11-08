function [U,V] = partialACA(xIds, yIds)

m = length(xIds);

tStartWALL = tic;

normAk = 0;
normUVk = 1;
eps = 1e-10;
iter = 1;

iIds = [];
jIds = [];

U = [];
V = [];

i = 1;
while sqrt(normUVk) > eps*sqrt(normAk)
    
    iIds(end+1) = i;
    iIds = sort(iIds);
    
    vk = rowGen(xIds(i), yIds);
    if not(isempty(U) || isempty(V))
        vk = vk - U(i,:)*V;
    end
    
    absVk = abs(vk);
    if not(isempty(jIds))
        absVk(jIds) = 0;
    end
    [sigma, j] = max(absVk);
    if sigma < 1e-12
        if iter >= m
            etime = toc(tStartWALL);
            fprintf("partial ACA converged succesfully\n");
            fprintf("\t final iteration = %d\n", iter);
            fprintf("\t elapsed time = %5.3e\n", etime);
            return;
        else
            i = findFirstNotIn(iIds);
        end
    else
        jIds(end+1) = j;
        jIds = sort(jIds);
        
        vk = vk/vk(j);
        uk = colGen(yIds(j), xIds);
        if not(isempty(U) || isempty(V))
            uk = uk - U*V(:,j);
        end
        
        absUk = abs(uk);
        if not(isempty(iIds))
            absUk(iIds) = 0;
        end
        [~, i] = max(absUk);
        
        dnorm = 0;
        depth = size(U,2) - 1;
        for l = 1 : depth
            dnorm = dnorm + (U(:,l)'*uk)*(vk*V(l,:)');
        end
        dnorm = 2*abs(dnorm);
        normUVk = norm(uk)^2*norm(vk)^2;
        normAk = normAk + dnorm + normUVk;
        
        U = [U  uk];
        V = [V; vk];
    end
    
    iter = iter + 1;
end

etime = toc(tStartWALL);
fprintf("partial ACA converged succesfully\n");
fprintf("\t final iteration = %d\n", iter);
fprintf("\t elapsed time = %5.3e\n", etime);