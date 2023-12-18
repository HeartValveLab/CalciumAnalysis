classdef Testing_Crucial_2 < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_1(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_1\';
            filename_1 = '6_E2_7ms_z_2_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_2(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_2\';
            filename_1 = '7_E3_7ms_z_11_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_3(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_3\';
            filename_1 = '7_E3_7ms_z_24_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_4(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_4\';
            filename_1 = '7_E3_7ms_z_42_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_5(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_5\';
            filename_1 = '12_E1_10ms_z_10_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_6(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_6\';
            filename_1 = '14_E2_10ms_z_34_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_7(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_7\';
            filename_1 = '16_E3_10ms_z_20_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_8(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD2\Data_8\';
            filename_1 = 'realigned_E1_10ms_renee_repeat0001-1.tif';
            filename_2 = 'realigned_E1_10ms_renee_repeat0001-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
    end

end