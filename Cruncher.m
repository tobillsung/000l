classdef Cruncher
    % CRUNCHER 
    %   Chop chop
    
    properties (Constant)
        
    end
    
    properties (GetAccess = public, SetAccess = private)
        Tickers;
        SDate;
        EDate;
        Data;
    end
    
    methods
        
        function theModel = Cruncher(aTickers, aSDate, aEDate)
            % Constructor
            
            theModel.Tickers = aTickers;
            
            if ~ exist('aSDate', 'var')
                aSDate = datestr(busdate(today, -1), 'yyyy/mm/dd');
            end
            theModel.SDate = aSDate;
            
            if ~ exist('aEDate', 'var')
                aEDate = datestr(busdate(today), 'yyyy/mm/dd');
            end
            theModel.EDate = aEDate;
            
            theModel.Data = GetYahooData(aTickers, theModel.SDate, theModel.EDate);
        end
        
        function plotData(aModel)
            PlotYahooData(aModel.Data, aModel.SDate, aModel.EDate);
        end
        
        
        
    end
    
end

