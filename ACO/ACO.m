classdef ACO < handle
    properties
        nAnts = 0;
        nInterations = 0;
        initialPheremone = 0;
        evaporation = 0;
        alpha = 0;
        beta = 0;
        pheremones = [];
    end
    
    methods
        function aco = ACO(nAnts, nInterations, initialPheremone, evaporation, alpha, beta)
            if nargin > 0
                aco.nAnts = nAnts;
                aco.nInterations = nInterations;
                aco.initialPheremone = initialPheremone;
                aco.evaporation = evaporation;
                aco.alpha = alpha;
                aco.beta = beta;
            end
        end
        
        function [numIts, BestSoln BestSolnCost] = run(aco, sc)
            rs = sc.getRS();
            rs.genIdealSolution();
            rs.reset();
            [sol, conflicts, lateness] = rs.getSolution();
            [m,n] = size(conflicts);

            aco.pheremones = ones(m,n);
            aco.pheremones = aco.pheremones .* aco.initialPheremone;            
            
            for i = 1:aco.nInterations
                newPheremones = aco.pheremones * (1 - aco.evaporation);
                for j = 1:aco.nAnts
                    % Construct Ant solutions
                    [delay, lateness] = aco.advanceAnt(rs, conflicts, zeros(m,n));
                    phr = 1 / lateness;
                    
                    % Update pheremones where a delay was inserted
                    ind = find(delay);
                    [numInd, z] = size(ind);
                    for k = 1:numInd
                        id = ind(k);
                        newPheremones(id) = newPheremones(id) + phr;
                    end
                end
                
                % Update pheremones
                aco.pheremones = newPheremones;
            end
            
            % Get best path
            ind = find(conflicts);
            [numInd, zs] = size(ind);
            delay = zeros(m,n);
            
            maxs = aco.pheremones;
            for i = 1:(numInd-1)
                [mer, index] = max(maxs(:));
                delay(index) = 1;
                maxs(index) = 0;
            end
            
            numIts = aco.nInterations * aco.nAnts;
            rs.reset();
            [BestSoln, confs, BestSolnCost] = rs.genSolutionWithDelay(delay);
        end
        
        function [delay, lateness] = advanceAnt(aco, rs, confs, delay)
            ind = find(confs);
            [numConf, n] = size(ind);
            choice = -1;
            lateness = 0;
            
            if numConf > 0
                a = aco.alpha;
                b = aco.beta;

                probs = confs .* 0;
                totalProbs = 0;

                for i = 1:numConf
                    id = ind(i);
                    t = aco.pheremones(id);
                    n = 1 / numConf;

                    probs(id) = (t^a) * (n^b);
                    totalProbs = totalProbs + probs(id);
                end

                r = rand(1);
                for i = 1:numConf
                    id = ind(i);
                    p = probs(id) / totalProbs;

                    if r <= p && delay(id) ~= 1
                        % take this path
                        choice = id;
                        break;
                    else
                        r = r - p;
                    end
                end

                % Good path
                if choice ~= -1
                    delay(choice) = 1;
                    rs.reset();
                    [sol, confs, lateness] = rs.genSolutionWithDelay(delay);
                    [delay, l2] = aco.advanceAnt(rs, confs, delay);
                    
                    if l2 ~= 0
                        lateness = l2;
                    end
                end
            end
        end
    end
end