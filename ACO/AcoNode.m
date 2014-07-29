classdef AcoNode < handle
    properties
        children = [];
        cost = 0;
    end
    
    methods
        function an = AcoNode(cost) 
            if nargin > 0
                an.cost = cost;
            end
        end
        
        function addChild(an, child)
            an.children = [an.children, child];
        end
        
        function children = getChildren(an)
            children = an.children;
        end
    end
end