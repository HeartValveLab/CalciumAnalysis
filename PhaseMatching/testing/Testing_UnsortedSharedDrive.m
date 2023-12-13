classdef Testing_UnsortedSharedDrive < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_tf_1(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_1\';
            filename_1 = '2023 12 07 kdrl-mCherry 50hpf fast e2-06-1.tif';
            filename_2 = '2023 12 07 kdrl-mCherry 50hpf fast e2-06-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_2(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_2\';
            filename_1 = '2023 12 07 kdrl-mCherry 50hpf fast e2-07-1.tif';
            filename_2 = '2023 12 07 kdrl-mCherry 50hpf fast e2-07-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_3(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_3\';
            filename_1 = '2023 12 07 kdrl-mCherry 50hpf fast e3-01-1.tif';
            filename_2 = '2023 12 07 kdrl-mCherry 50hpf fast e3-01-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_4(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_4\';
            filename_1 = '2023 12 07 kdrl-mCherry 50hpf fast e3-02-2.tif';
            filename_2 = '2023 12 07 kdrl-mCherry 50hpf fast e3-02-1.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_5(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_5\';
            filename_1 = '2023 12 07 kdrl-mCherry 50hpf fast-02-2.tif';
            filename_2 = '2023 12 07 kdrl-mCherry 50hpf fast-02-1.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_6(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_6\';
            filename_1 = '2023 12 07 kdrl-mCherry 50hpf fast-03-2.tif';
            filename_2 = '2023 12 07 kdrl-mCherry 50hpf fast-03-1.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
    end

end