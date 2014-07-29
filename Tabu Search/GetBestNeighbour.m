function [BestSoln, BestSolnConflicts, BestSolnCost, TabuList, itrs] = GetBestNeighbour(rs, soln, conflicts, TabuLength, TabuList)

% Get the index of the conflicts
[nTrains,nNodes] = size(soln);
indexes = find(conflicts);
[numIndexes, z] = size(indexes);
delay = zeros(nTrains, nNodes);

BestSoln = delay;
BestSolnConflicts = delay;
BestSolnCost = Inf;
BestDelay = delay;
itrs = 0;

% Find best solution in neighborhood
for j = 1:(nTrains-1)
    for i = 1:numIndexes
        itrs = itrs + 1;
         delay = zeros(nTrains, nNodes);
         delay(indexes(i)) = j;
        
         rs.reset();
         [soln, conflicts, lateness] = rs.genSolutionWithDelay(delay);
         existsInTabuList = TabuList.checkIfExist(delay);

         if ((lateness < BestSolnCost && existsInTabuList == 0))
             BestSoln = soln;
             BestSolnConflicts = conflicts;
             BestSolnCost = lateness;
             BestDelay = delay;
         end
    end
end

TabuList.insert(BestDelay, TabuLength);
% disp('------------------------ Round ------------------------')
BestDelay;
BestSolnCost;