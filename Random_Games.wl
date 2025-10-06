(* ::Package:: *)

% Clear workspace and command window
clear; clc;
rng('shuffle'); % Random seed for different results each run

% Number of games
numGames = 100000;

% Define symbolic variables
syms alpha beta a b c d w v

% Define the replicator dynamics equations
F_beta = beta*(1 - beta)*(b - d - b*alpha + v*b*alpha + v*w*alpha);
F_alpha = alpha*(1 - alpha)*(-c + a - a*v*beta);

% Compute the Jacobian matrix
J = jacobian([F_beta, F_alpha], [beta, alpha]);

% Initialize data storage
gameData = cell(numGames, 11);
headers = {'game', 'a', 'b', 'c', 'd', 'w', 'v', '(0,0)', '(0,1)', '(1,0)', '(1,1)'};

% Loop to generate 100 games
for gameNum = 1:numGames
    % Generate random parameters within the given constraints
    w_val = rand();  % 0 < w <= 1
    v_val = rand();  % 0 < v <= 1
    c_val = rand() * w_val;  % 0 < c < w
    d_val = rand() * w_val;  % 0 < d < w
    a_val = c_val + rand();  % c < a
    b_val = d_val + (w_val - d_val) * rand(); % d < b <= w
    
    % Store parameters
    gameData{gameNum, 1} = gameNum;
    gameData{gameNum, 2} = a_val;
    gameData{gameNum, 3} = b_val;
    gameData{gameNum, 4} = c_val;
    gameData{gameNum, 5} = d_val;
    gameData{gameNum, 6} = w_val;
    gameData{gameNum, 7} = v_val;

    % Substitute parameters into Jacobian
    J_eval = subs(J, [a, b, c, d, w, v], [a_val, b_val, c_val, d_val, w_val, v_val]);

    % Define the four equilibrium points
    eqs = [0 0; 0 1; 1 0; 1 1];
    stability = zeros(1, 4); % Initialize stability check
    
    % Check stability for each equilibrium
    for eqIdx = 1:4
        beta_eq = eqs(eqIdx, 1);
        alpha_eq = eqs(eqIdx, 2);
        J_eq = subs(J_eval, [beta, alpha], [beta_eq, alpha_eq]);
        eig_vals = double(eig(J_eq)); % Compute eigenvalues numerically
        
        % Check if both eigenvalues are negative (stable)
        if all(eig_vals < 0)
            stability(eqIdx) = 1;
        end
    end

    % Store stability results
    gameData{gameNum, 8}  = stability(1);
    gameData{gameNum, 9}  = stability(2);
    gameData{gameNum, 10} = stability(3);
    gameData{gameNum, 11} = stability(4);
end

% Convert cell array to table
resultsTable = cell2table(gameData, 'VariableNames', headers);

% Write table to Excel file
outputFile = 'eq_status . xlsx';
writetable(resultsTable, outputFile, 'Sheet', 1);

% Display completion message
fprintf('Generated % d games and saved results in "%s"\n', numGames, outputFile);
