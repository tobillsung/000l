classdef StrategyMovingAvg < StrategyBase
    
    properties (GetAccess = public, SetAccess = private)
        LookBack = 3;
        TargetField = 'AdjClose';
        TargetData = [];
    end
    
    methods 
        function theST = StrategyMovingAvg(aLookBack)
            theST.LookBack = aLookBack;
        end
        
        function setTargetField(theST, aTargetField)
            if exist('aTargetField', 'var')
                assert(ischar(aTargetField), 'aTargetField should be string (def: AdjClose)');
                theST.TargetField = aTargetField;
            end
        end
        
        function theName = getName(aST)
            
            theName = sprintf('Moving Avg Strategy (LookBack: %d, TargetField: %s)', ...
                aST.LookBack, aST.TargetField);
        end
        
        function theResult = run (aST)
            
            Logger.info(aST.getName);
            
            % Assign target data
            myData = aST.Data;
            assert(~ isempty(myData), 'addData first');
            try
                myTargetData = double(myData.(aST.TargetField));
            catch
                error('setMovAvgTarget:Input:Err', ...
                    '%s is not available fields on the dataset', aST.TargetField);
            end
            
            % Calculate moving average
            myMovAvg = zeros(size(myTargetData));
            for i = numel(myTargetData) : -1 : 1
                if i >= 3
                    myMovAvg(i) = mean(myTargetData(i - aST.LookBack + 1 : i));
                else
                    myMovAvg(i) = mean(myTargetData(1 : i));
                end
            end
            
            % Assign back to properties
            aST.Data = horzcat(aST.Data, dataset(myMovAvg, 'Varnames', 'MovAvg'));
            
            theResult = aST.Data;
        end
    end
    
end

