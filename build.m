% build.m

% Clear workspace and command window
clear;
close all;
clc;
set(0, 'DefaultAxesFontName', 'Times New Roman')
set(0, 'DefaultAxesFontSize', 22)
rng("default")

disp('Starting build process...');

% Optional: Load configuration file (like cmake configurations)
run('config.m');

% Run files in order of execution
try
    disp('Running leader_states.m...');
    run('leader_states.m');
    
    disp('Running formation_shape.m...');
    run('formation_shape.m');
    
    disp('Running main.m...');
    run('main.m');
    
    disp('Build process completed successfully!');
    disp('The formation shape and leader states are showing!');
    disp('If you want to see the time-varying formation, please run the files in Plot!');
catch ME
    disp('Error encountered:');
    disp(ME.message);
    % Optional: Handle specific error types
end