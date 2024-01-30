function output = run_script(script)
% RUN_SCRIPTS runs the verbose and quiet MATLAB scripts to make sure that
% they run to completion
    run(script)
    output = "Test ran to completion";
end