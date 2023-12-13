classdef Testing_DL_191218 < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_1(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_1\';
            filename_1 = '32hpf_20ms_2_t1_nd_c01.tif';
            filename_2 = '32hpf_20ms_2_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_2(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_2\';
            filename_1 = '32hpf_20ms_2_2_t1_nd_c01.tif';
            filename_2 = '32hpf_20ms_2_2_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_3(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_3\';
            filename_1 = '54hpf_2_t1_nd_c01.tif';
            filename_2 = '54hpf_2_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_4(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_4\';
            filename_1 = '54hpf_2_2_nd_c01.tif';
            filename_2 = '54hpf_2_2_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_5(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_5\';
            filename_1 = '74hpf_20ms_1_t1_nd_c01.tif';
            filename_2 = '74hpf_20ms_1_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_6(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_6\';
            filename_1 = '74hpf_20ms_1_2_t1_nd_c01.tif';
            filename_2 = '74hpf_20ms_1_2_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_7(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_7\';
            filename_1 = '74hpf_20ms_3_t1_nd_c01.tif';
            filename_2 = '74hpf_20ms_3_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_8(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_8\';
            filename_1 = '74hpf_20ms_3_2_t1_nd_c01.tif';
            filename_2 = '74hpf_20ms_3_2_t1_nd_c02.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
    end

end