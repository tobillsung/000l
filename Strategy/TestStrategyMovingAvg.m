classdef TestStrategyMovingAvg
    
    properties (Constant)
        Ticker = 'ABC';
        Data = struct(TestStrategyMovingAvg.Ticker, ...
            dataset([1;2;3;4;5;6;7], [10;20;30;40;50;60;70], [1;2;3;4;5;6;7], ...
            'Varnames', {'Date', 'AdjClose', 'Custom'}));
    end
   
    methods (Static)
        
        function theFlag = testDefaultTarget()
            mySt = StrategyMovingAvg(3);
            mySt.addData(TestStrategyMovingAvg.Ticker, TestStrategyMovingAvg.Data);
            
            myRes = mySt.run();
            
            theFlag = isequal(double(myRes.MovAvg), [10;15;20;30;40;50;60]);
            
        end
        
        function theFlag = testCustomTarget()
           
            mySt = StrategyMovingAvg(3);
            mySt.setTargetField('Custom');
            mySt.addData(TestStrategyMovingAvg.Ticker, TestStrategyMovingAvg.Data);
            
            myRes = mySt.run();
            
            theFlag = isequal(double(myRes.MovAvg), [1;1.5;2;3;4;5;6]);
            
        end
        
    end


end

