classdef Testing_Phases < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_phase_1(testCase)
            actSol = test_phases(1);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_2(testCase)
            actSol = test_phases(2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_3(testCase)
            actSol = test_phases(3);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_4(testCase)
            actSol = test_phases(4);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_5(testCase)
            actSol = test_phases(5);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_6(testCase)
            actSol = test_phases(6);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_7(testCase)
            actSol = test_phases(7);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_8(testCase)
            actSol = test_phases(8);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_9(testCase)
            actSol = test_phases(9);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_10(testCase)
            actSol = test_phases(10);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_11(testCase)
            actSol = test_phases(11);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_12(testCase)
            actSol = test_phases(12);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_13(testCase)
            actSol = test_phases(13);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_14(testCase)
            actSol = test_phases(14);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_phase_15(testCase)
            actSol = test_phases(15);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
    end

end