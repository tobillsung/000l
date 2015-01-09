classdef StrategyExpMovingAvg < StrategyBase
    
    properties (Constant)
        ExpFun = @(x, tau) exp(-x/tau); % exp(-x/t), tau is mean life, so this is exponential decay
        HalfFun = @(x, tau) 2 ^ (-x/tau); % 2 ^ (-x/t), tau is half life, so this is half life decay
    end
    
    properties (GetAccess = public, SetAccess = private)
        DecayFun = StrategyExpMovingAvg.ExpFun;
        MeanLife = 3;
        TargetField = 'AdjClose';
        TargetData = [];
    end
    
    methods 
        function theST = StrategyExpMovingAvg(aDecayFun, aMeanLife)
            
            theST.DecayFun = aDecayFun;
            theST.MeanLife = aMeanLife;
        end
        
        function setTargetField(aST, aTargetField)
            if exist('aTargetField', 'var')
                assert(ischar(aTargetField), 'aTargetField should be string (def: AdjClose)');
                aST.TargetField = aTargetField;
            end 
        end
        
        function theName = getName(aST)
            
            theName = sprintf('Exponential Moving Avg Strategy (Decayfun: %s, MeanLife: %s)', ...
                func2str(aST.DecayFun), aST.MeanLife);
        end
        
        function run (aTicker, aST)
            
            % Convert cell input to char
            if iscell(aTicker)
                if numel(aTicker) > 1
                    warning('Only one ticker can run at a time');
                end
                aTicker = aTicker{1};
            end
            
            % Assign target data
            myData = aST.Data.(aTicker);
            assert(~ isempty(myData), 'addData first');
            try
                myTargetData = double(myData.(aTargetField));
            catch
                error('setMovAvgTarget:Input:Err', ...
                    '%s is not available fields on the dataset', aTargetField);
            end
            
            myExpMovAvg = zeros(size(myTargetData));
            myExpMovAvg(1) = myTargetData(1);
            
            for i = 2 : numel(myTargetData)
                
                % Decaying the i - 1 myExpMovAvg
                myDecayFactor = aST.DecayFun(i - 1, aST.MeanLife);
                
                % Recurrsively updating
                myExpMovAvg(i) = myTargetData(i) * (1 - myDecayFactor) + ...
                    myExpMovAvg(i - 1) * myDecayFactor;                
            end
            
        end
    end
    
end

