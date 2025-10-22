%% Robustness plots for (1,1) using filtered_1_1.xlsx
clear; clc; close all; tic;

% ---------- SETTINGS ----------
xlsxFile = 'filtered_1_1.xlsx';
testN    = [];           % small test first; set [] to use all rows
% saveFig  = true;         % save as PDF
shadowAlpha = 0.25;      % transparency for the ±10% band
fs = 18;                 % font size
lw = 1.8;                % line width

% ---------- LOAD DATA ----------
T = readtable(xlsxFile);          % expects columns: a b c d w v (1,1)
needed = {'a','b','c','d','w','v'};
if ~all(ismember(needed, T.Properties.VariableNames))
    error('Excel file must contain columns: a b c d w v');
end
if ~isempty(testN) && testN < height(T), T = T(1:testN, :); end

aVals = T.a; bVals = T.b; cVals = T.c; dVals = T.d; wVals = T.w; vVals = T.v;

% ---------- REPLICATOR + JACOBIAN ----------
syms alpha beta a b c d w v
F_beta  = beta*(1-beta)*(b - d - b*alpha + v*b*alpha + v*w*alpha);
F_alpha = alpha*(1-alpha)*(-c + a - a*v*beta);
Jsym    = jacobian([F_beta, F_alpha], [beta, alpha]);
J_fun   = matlabFunction(Jsym, 'Vars', [beta, alpha, a, b, c, d, w, v]);

isStable11 = @(a,b,c,d,w,v) all(real(eig(J_fun(1,1,a,b,c,d,w,v))) < 0);

% ---------- HELPERS ----------
enforce = @(a,b,c,d,w,v) deal( ...
    max(a, min(2, max(c+1e-9, a))), ...         % a>c, clip to [c+eps, ~2]
    min(max(b, d+1e-9), min(w,1)), ...          % d<b<=w and b<=1
    min(max(c,0), max(w-1e-9,0)), ...           % 0<=c<w
    min(max(d,0), max(w-1e-9,0)), ...           % 0<=d<w
    min(max(w,0),1), ...                         % 0<=w<=1
    min(max(v,0),1) );                           % 0<=v<=1

% bins
bins01 = 0:0.1:1;   % for v, c, d, w, b (<=1)
binsA  = 0:0.1:2;   % for a (b_a)

% ---------- BUILD SIX PANELS ----------
[xV, baseV, lowV, highV]   = makeLineAndBand('v', aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA);
[xCA,baseCA,lowCA,highCA]  = makeLineAndBand('c', aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA); % c_a
[xBA,baseBA,lowBA,highBA]  = makeLineAndBand('a', aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA); % b_a
[xW, baseW, lowW, highW]   = makeLineAndBand('w', aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA);
[xCD,baseCD,lowCD,highCD]  = makeLineAndBand('d', aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA); % c_d
[xBD,baseBD,lowBD,highBD]  = makeLineAndBand('b', aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA); % b_d

% ---------- PLOT ----------
fig = figure('Color','w','Position',[80 80 1300 700]); 
set(groot,'defaultAxesFontName','Times','defaultAxesFontWeight','bold','defaultAxesFontSize',fs);

panel = @(i) subplot(2,3,i); 
shade = @(x,lo,hi,col) fill([x; flipud(x)], [lo; flipud(hi)], col,...
                            'EdgeColor','none','FaceAlpha',shadowAlpha);

% (1) v
panel(1); hold on;
shade(xV,lowV,highV,[0.7 0.85 1]);
plot(xV,baseV,'-o','LineWidth',lw,'Color',[0 0.25 0.8]);
grid on; xlabel('\bf v'); ylabel('\bf Frequency'); title('\bf (a)');
xlim([xV(1) xV(end)]);

% (2) c_a
panel(2); hold on;
shade(xCA,lowCA,highCA,[0.7 0.85 1]);
plot(xCA,baseCA,'-o','LineWidth',lw,'Color',[0 0.25 0.8]);
grid on; xlabel('\bf c_a'); ylabel('\bf Frequency'); title('\bf (b)');
xlim([xCA(1) xCA(end)]);

% (3) b_a
panel(3); hold on;
shade(xBA,lowBA,highBA,[0.7 0.85 1]);
plot(xBA,baseBA,'-o','LineWidth',lw,'Color',[0 0.25 0.8]);
grid on; xlabel('\bf b_a'); ylabel('\bf Frequency'); title('\bf (c)');
xlim([xBA(1) xBA(end)]);

% (4) w
panel(4); hold on;
shade(xW,lowW,highW,[0.7 0.85 1]);
plot(xW,baseW,'-o','LineWidth',lw,'Color',[0 0.25 0.8]);
grid on; xlabel('\bf w'); ylabel('\bf Frequency'); title('\bf (d)');
xlim([xW(1) xW(end)]);

% (5) c_d  <-- FIXED PANEL HERE
panel(5); hold on;
shade(xCD,lowCD,highCD,[0.7 0.85 1]);
plot(xCD,baseCD,'-o','LineWidth',lw,'Color',[0 0.25 0.8]);
grid on; xlabel('\bf c_d'); ylabel('\bf Frequency'); title('\bf (e)');
xlim([xCD(1) xCD(end)]);

% (6) b_d
panel(6); hold on;
shade(xBD,lowBD,highBD,[0.7 0.85 1]);
plot(xBD,baseBD,'-o','LineWidth',lw,'Color',[0 0.25 0.8]);
grid on; xlabel('\bf b_d'); ylabel('\bf Frequency'); title('\bf (f)');
xlim([xBD(1) xBD(end)]);

sgtitle('\bf Robustness of (1,1) under \pm10% OAT perturbations', 'FontSize', fs+2);

% if saveFig
%     exportgraphics(fig,'robustness_11_six_panels_fixed.pdf','ContentType','vector','Resolution',350);
% end

fprintf('Done. Runtime: %.2f seconds.\n', toc);

% ======================== LOCAL FUNCTIONS =========================
function [xgrid, baseCounts, lowBand, highBand] = makeLineAndBand(xAxisName, ...
    aVals,bVals,cVals,dVals,wVals,vVals, isStable11, enforce, bins01,binsA)

    n = numel(aVals);
    switch xAxisName
        case {'v','c','d','w','b'}
            xgrid = bins01(:);
            getBin = @(x) binIdx01(x, bins01);
        case 'a'
            xgrid = binsA(:);
            getBin = @(x) binIdxA(x, binsA);
        otherwise
            error('Unknown xAxisName');
    end
    nb = numel(xgrid);

    baseCounts = zeros(nb,1);
    countsPlus = zeros(nb,1);
    countsMinus= zeros(nb,1);

    for i = 1:n
        a=aVals(i); b=bVals(i); c=cVals(i); d=dVals(i); w=wVals(i); v=vVals(i);

        switch xAxisName
            case 'v',  k = getBin(v);
            case 'c',  k = getBin(c);
            case 'd',  k = getBin(d);
            case 'a',  k = getBin(a);
            case 'w',  k = getBin(w);
            case 'b',  k = getBin(b);
        end
        baseCounts(k) = baseCounts(k) + 1;

        % +10%
        switch xAxisName
            case 'v',  [ap,bp,cp,dp,wp,vp] = enforce(1.1*a,1.1*b,1.1*c,1.1*d,1.1*w, v);
            case 'c',  [ap,bp,cp,dp,wp,vp] = enforce(1.1*a,1.1*b, c,   1.1*d,1.1*w,1.1*v);
            case 'd',  [ap,bp,cp,dp,wp,vp] = enforce(1.1*a,1.1*b,1.1*c, d,   1.1*w,1.1*v);
            case 'a',  [ap,bp,cp,dp,wp,vp] = enforce(a, 1.1*b,1.1*c,1.1*d,1.1*w,1.1*v);
            case 'w',  [ap,bp,cp,dp,wp,vp] = enforce(1.1*a,1.1*b,1.1*c,1.1*d, w, 1.1*v);
            case 'b',  [ap,bp,cp,dp,wp,vp] = enforce(1.1*a, b,   1.1*c,1.1*d,1.1*w,1.1*v);
        end
        if isStable11(ap,bp,cp,dp,wp,vp), countsPlus(k) = countsPlus(k)+1; end

        % -10%
        switch xAxisName
            case 'v',  [am,bm,cm,dm,wm,vm] = enforce(0.9*a,0.9*b,0.9*c,0.9*d,0.9*w, v);
            case 'c',  [am,bm,cm,dm,wm,vm] = enforce(0.9*a,0.9*b, c,   0.9*d,0.9*w,0.9*v);
            case 'd',  [am,bm,cm,dm,wm,vm] = enforce(0.9*a,0.9*b,0.9*c, d,   0.9*w,0.9*v);
            case 'a',  [am,bm,cm,dm,wm,vm] = enforce(a, 0.9*b,0.9*c,0.9*d,0.9*w,0.9*v);
            case 'w',  [am,bm,cm,dm,wm,vm] = enforce(0.9*a,0.9*b,0.9*c,0.9*d, w, 0.9*v);
            case 'b',  [am,bm,cm,dm,wm,vm] = enforce(0.9*a, b,   0.9*c,0.9*d,0.9*w,0.9*v);
        end
        if isStable11(am,bm,cm,dm,wm,vm), countsMinus(k) = countsMinus(k)+1; end
    end

    lowBand  = min(countsPlus, countsMinus);
    highBand = max(countsPlus, countsMinus);
end

function k = binIdx01(x, bins)
    x = min(max(x, bins(1)), bins(end));
    k = round(x*10)+1;
    k = max(1, min(k, numel(bins)));
end

function k = binIdxA(x, bins)
    x = min(max(x, bins(1)), bins(end));
    k = round(x*10)+1;
    k = max(1, min(k, numel(bins)));
end

exportgraphics(gcf, 'figure_15.png', 'Resolution', 300);