function  [BestSoln BestSolnCost] = PSO(...
    NumParticles, MaxIterations)

% This function implements the PSO algorithm.
%
% Inputs:
%
% Outputs:
%   BestSoln: The best solution obtained
%   BestSolnCost: The best solution cost
disp(' ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp('             ----------------------------------             ')
disp(' ')
disp('------------------------ Running PSO ------------------------')


sc = Scenario();
rs = sc.getRS();


w = 0.5;
c1 = 1;
c2 = 1;
N=0;
v = zeros([1,NumParticles]);
[m, nTrains] = size(rs.trains);
[n, nNodes] = size(rs.nodes);
delay = zeros(nTrains, nNodes);


% Generate ideal solution for each train which is to be used for the optimization function
IdealSolution = rs.genIdealSolution();
%IdealSolution
rs.reset();

[InitialSolution, conflicts, lateness] = rs.getSolution();
disp('-------------------------- Initial Solution --------------------------')
InitialSolution
lateness
particles(1,NumParticles) = Particle(InitialSolution, conflicts, lateness,delay,0,0);
gbest = Particle(InitialSolution, conflicts, lateness,delay,0,0);

disp('------------------------ Set Up Completed ------------------------')
disp('-------------------------- Initialize Particles --------------------------')
for i=1:NumParticles
    
    cons = find(conflicts);
    rCon = cons(randi([1,length(cons)]));
    delay(rCon) = delay(rCon) + 1 ;
    %delay = randi([0,1],[nTrains,nNodes]);
     rs.reset();
    [solution, conflicts, lateness] = rs.genSolutionWithDelay(delay);
    particles(1,i) = Particle(solution, conflicts, lateness,delay,0,0);
end
disp('-------------------------- Start Iteration --------------------------')
while N < MaxIterations
    %disp('-------------------------- Start Iteration --------------------------')
    for i=1:NumParticles;
        if(isempty(particles(1,i).getPbest) || particles(1,i).getPbest ==0)
            particles(1,i).setPbest(particles(1,i).getLateness);
        elseif(particles(1,i).Lateness < particles(1,i).getPbest)
            particles(1,i).setPbest(particles(1,i).getLateness);
        end
        

        if(particles(1,i).getPbest < gbest.getLateness)
            gbest = particles(1,i);
        end
    end
    for i=1:NumParticles
         %particles(1,i).setVelocity((c1*randi(2)*(particles(1,i).getPbest-particles(1,i).getLateness)) + (c2*randi(2)*(gbest-particles(1,i).getLateness)))
         
         particles(1,i).setVelocity((gbest.getDelay - particles(1,i).getDelay));
         gbest.getDelay;
         delay = particles(1,i).getDelay;
         cons = find(particles(1,i).getVelocity);
         if(~isempty(cons))
             if(length(cons) > 1)
            rCon = cons(randi([1,length(cons)]));
            delay(rCon) = delay(rCon) - 1;
             else 
                 delay = particles(1,i).getVelocity;
             end
%             if(delay == 0)
%                  conflicts = particles(1,i).getConflicts;
%                  cons = find(conflicts);
%                  rCon = cons(randi([1,length(cons)]));
%                  delay(rCon) = delay(rCon)+1;
%              end
         end
         
%          if(~isempty(particles(1,i).getVelocity))
%             delay = delay + particles(1,i).getVelocity;
%             if(delay == 0)
%                 conflicts = particles(1,i).getConflicts;
%                 cons = find(conflicts);
%                 rCon = cons(randi([1,length(cons)]));
%                 delay(rCon) = delay(rCon)+1;
%             end
%          end
         rs.reset;
         [solution, conflicts, lateness] = rs.genSolutionWithDelay(abs(delay));
         particles(1,i) = Particle(solution, conflicts, lateness,delay,particles(1,i).getPbest,particles(1,i).getVelocity);
         %         x[t+1] = x[t] + v[t+1]
    end
    N= N+1;
end
disp('-------------------------- Finish Iteration -------------------------')

disp(' ')
disp('------------------------ Results ------------------------')
gbest.getSolution
gbest.getDelay
gbest.getLateness
disp('-------------------------- End --------------------------')

clear JUNCTION LEFT RIGHT STATION junction1 junction2 junction3 junction4 station1 station2 station3 train1 train2 train3