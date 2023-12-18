classdef Testing_Crucial_1 < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_1(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_1\';
            filename_1 = '6_E1_z_1_C1.tif';
            filename_2 = '6_E1_z_1_C2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_2(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_2\';
            filename_1 = '22_E1_z_28_.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_3(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_3\';
            filename_1 = 'omeFiles_r0_z025-1.tif';
            filename_2 = 'omeFiles_r0_z025-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_4(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_4\';
            filename_1 = 'SD32_E3_R8_2018_10_08_repeat0001-1.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_5(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_5\';
            filename_1 = 'SD39_E8_realigned_2018_08_23_repeat0001-1.tif';
            filename_2 = 'SD39_E8_realigned_2018_08_23_repeat0001-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_6(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_6\';
            filename_1 = 'SD43_E6_2018_11_08_repeat0001-1.tif';
            filename_2 = 'SD43_E6_2018_11_08_repeat0001-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_7(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_7\';
            filename_1 = 'SD44_E2_2018_11_20_repeat0001-1.tif';
            filename_2 = 'SD44_E2_2018_11_20_repeat0001-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_8(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Vault\Crucial_SSD1\Data_8\';
            filename_1 = 'SD44_E5_2018_11_22_FixedShift-1.tif';
            filename_2 = 'SD44_E5_2018_11_22_FixedShift-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
    end

end