classdef Testing_UnsortedSharedDrive < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_renee_select(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Renee_Selection\';
            filename_1 = '2023-09-22_NewTest.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_1(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_1\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceLeft_seq-01-1.tif';
            filename_2 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceLeft_seq-01-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_2(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_2\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceLeft-03-1.tif';
            filename_2 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceLeft-03-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_3(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_3\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceRight_seq-02-1.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_4(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_4\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceRight-01-1.tif';
            filename_2 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP_fishFaceRight-01-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_5(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_5\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-06-1.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_6(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_6\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-07-1.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_7(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_7\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-09-1.tif';
            filename_2 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-09-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_8(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_8\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-1.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_9(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_9\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-1.tif';
            filename_2 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-2.tif';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
        function test_tf_10(testCase)
            folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_10\';
            filename_1 = '2023_10_06_LLS7_76hpf_kdrlMcherryCaax_cmlc2EGFP-1.tif';
            filename_2 = '';
            actSol = test_file(folder_path, filename_1, filename_2);
            expSol = "Test ran to completion";
            testCase.verifyEqual(actSol, expSol);
        end
    end

end