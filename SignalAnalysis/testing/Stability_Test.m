classdef Stability_Test < matlab.unittest.TestCase
    % Ensure that the script versions run properly in case something has
    % changed

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_quiet(testCase)
            actSol = run_script("SignalAnalysis_Quiet");
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol)
        end

        function test_verbose(testCase)
            actSol = run_script("SignalAnalysis_Verbose");
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol)
        end
    end

end