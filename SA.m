function  [numIts, BestSoln BestSolnCost] = SA(sc, temp)


%% SA
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf
% 
% disp(' ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp('             ----------------------------------             ')
% disp(' ')
% disp('------------------------ Running SA ------------------------')

%clearvars
% sc = Scenario();
% sc = RandomTrains(35,20,4);
rs = sc.getRS();

% Calculate ideal
IdealSolution = rs.genIdealSolution();
rs.reset();

% Create initial solution
[m, nTrains] = size(rs.trains);
[n, nNodes] = size(rs.nodes);
[curSolution, curConflicts, curLateness] = rs.getSolution();
curDelay = zeros(nTrains, nNodes);
curSolution;
curConflicts;
initialLateness = curLateness;
bestSolution = curSolution;
bestConflicts = curConflicts;
bestLateness = curLateness;
bestDelay = curDelay;
rs.reset();
numIts = 0;
% disp('------------------- Set Up Completed --------------------')

T = nTrains*temp;
coolingRate = 0.1;
while(T > 0)
    numIts = numIts + 1;
    newDelay = curDelay;
    
    cons = find(curConflicts);
    if(length(cons > 0))
        rCon = cons(randi([1,length(cons)]));
        newDelay(rCon) = newDelay(rCon) + 1;

        [newSolution, newConflicts, newLateness] = rs.genSolutionWithDelay(newDelay);

        if (newLateness < bestLateness)
            accProb = 1;
        else
            accProb = exp((curLateness - newLateness)/T);
        end
        accRand = randi([0,10000])/10000;

        if (accProb > accRand)
           curLateness = newLateness;
           curConflicts = newConflicts;
           curSolution = newSolution;
           curDelay = newDelay;
        end
        if (curLateness < bestLateness)
           bestLateness = curLateness;
           bestConflicts = curConflicts;
           bestSolution = curSolution;
           bestDelay = curDelay;
        end
    else    
%         disp('Converged')
%         T
        T = 0;
    end
    
    rs.reset();
    T = T * (1 - coolingRate);
end

BestSoln = bestDelay;
BestSolnCost = bestLateness;

% disp(' ')
% disp('------------------------ Results ------------------------')
bestSolution;
bestDelay;
bestLateness;
initialLateness;
optimizationPercent = ((initialLateness / bestLateness) - 1) * 100;
% disp('-------------------------- End --------------------------')

clear JUNCTION LEFT RIGHT STATION junction1 junction2 junction3 junction4 station1 station2 station3 train1 train2 train3