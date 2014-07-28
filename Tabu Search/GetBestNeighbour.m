function [BestSoln, BestSolnConflicts, BestSolnCost, TabuList] = GetBestNeighbour(rs, BestSoln, BestSolnCost, BestSolnConflicts, TabuLength, TabuList)

% Get the index of the conflicts
[nTrains,nNodes] = size(BestSoln);
indexes = find(BestSolnConflicts);
[numIndexes, z] = size(indexes);
numLoops = numIndexes * nTrains;
delay = zeros(nTrains, nNodes);

for i = 1:numLoops
    delay(indexes(1)) = delay(indexes(1))+1;
    
    for j = 2:nTrains
        if delay(indexes(j-1)) == nTrains
            delay(indexes(j)) = delay(indexes(j))+1;
            delay(indexes(j-1)) = 0;
        end
    end
    
    rs.reset();
    [soln, conflicts, lateness] = rs.genSolutionWithDelay(delay);
    
    if lateness < BestSolnCost % Change this to find current best not overall best
        TabuList.insert(delay, TabuLength);
        BestSoln = soln;
        BestSolnConflicts = conflicts;
        BestSolnCost = lateness;
    end
end