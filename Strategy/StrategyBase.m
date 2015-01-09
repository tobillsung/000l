classdef StrategyBase < handle
    % StreategyBase
    %
    % Abstract class for any strategies
    
    properties (Constant)
        MovingAvg = 1;
    end
    
    properties (Access = public)
        Data;
        Sim; % Result of run
        Name;
    end
    
    methods
        function theST = StrategyBase()
            
        end
    end
    
    methods (Abstract)
        run(aObj)
        % run strategy
        
        getName(aObj)
        % Set strategy name
    end
    
    methods 
        function addData(aST, aTicker, aData)
            assert(isstruct(aData), 'aData should be output from GetYahooData');
            
             % Convert cell input to char
            if iscell(aTicker)
                if numel(aTicker) > 1
                    warning('Only one ticker can run at a time');
                end
                aTicker = aTicker{1};
            end
            aST.Data = aData.(aTicker);
            fprintf('Strategy implemented to %s\n', aTicker);
        end
    end
    
end

