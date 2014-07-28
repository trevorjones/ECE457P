%% Particle
classdef Particle < handle
   properties
       Solution;
       Conflicts;
       Lateness;
       Delay;
       pbest;
       velocity;
   end
    
   methods
       % Constructor
       function particle = Particle(solution,conflicts,lateness,delay,pbest,velocity)
          if nargin > 0
             particle.Solution = solution;
             particle.Conflicts = conflicts;
             particle.Lateness = lateness;
             particle.Delay = delay;
             particle.pbest = pbest;
             particle.velocity = velocity;
          end
       end
       
       function currsolution = getSolution(particle)
          currsolution = particle.Solution; 
       end
       
       function currconflicts = getConflicts(particle)
          currconflicts = particle.Conflicts; 
       end
       
       function currlateness = getLateness(particle)
          currlateness = particle.Lateness; 
       end
       
       function currdelay = getDelay(particle)
          currdelay = particle.Delay; 
       end
       
       function currpbest = getPbest(particle)
          currpbest = particle.pbest; 
       end

       function currvelocity = getVelocity(particle)
          currvelocity = particle.velocity; 
       end
       
       function setSolution(particle, solution)
          particle.Solution = solution;
       end
       
       function setConflicts(particle, conflicts)
          particle.Conflicts = conflicts;
       end
       function setLateness(particle, lateness)
          particle.Lateness = lateness;
       end
       
       function setDelay(particle, delay)
           particle.delay = delay;
       end
       
       function setPbest(particle, pbest)
          particle.pbest = pbest;
       end

       function setVelocity(particle, velocity)
          particle.velocity = velocity;
       end
   end
end