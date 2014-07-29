%% Graph Generator
%  Generates the graph for the ants to go through
classdef GraphGenerator < handle
    properties
        rs = RailwaySystem.empty;
        
    end
    
    methods
        function gg = GraphGenerator(rs)
            if nargin > 0
                gg.rs = rs;
            end
        end
        
        function 
    end
end