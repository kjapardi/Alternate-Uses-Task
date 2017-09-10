%% AUOC_Task_V3.m - ALTERNATE USES AND OBJECT CHARACTERISTICS PARADIGM
%
% Script Written by: Kevin Japardi
% Last Modified: 6/30/2014
%
% TRIAL STRUCTURE
% Jitter (2-5s) | Cue Start (0.500s) | Pause (0.250s) | Task (20s) | Pause (0.250s) | % Cue End (0.500s)
%
% SCANNING DETAILS
% Each Run == 8 AU, 8 OC, and 7 Rest trials (23 trials/run)
% Individual Run Time: 590-600 seconds (9.833-10 minutes)
% Overall Time: 1180-1200 seconds (19.667-20 minutes)
% [ 2 OC | Rest | 2 OC | Rest | 2 AU | Rest | 2 AU | Rest | 2 OC | Rest | 2 OC | Rest | 2 AU | Rest | 2 AU ]
%
% BEHAVIORAL DETAILS
% Each Run == 12 AU, 12 OC, 11 Rest trials (35 trials/run)
% Individual Run Time: 822.5-927.5 seconds (13.71-15.46 minutes)
% Overall Time: 1645-1855 seconds (27.4-30.9 minutes)
% [ 2 OC | Rest | 2 OC | Rest | 2 AU | Rest | 2 AU | Rest | 2 OC | Rest...
% | 2 OC | Rest | 2 AU | Rest | 2 AU | Rest | 2 OC | Rest | 2 OC | Rest | 2 AU | Rest | 2 AU]

close all;
clear all;

%% SCRIPT DETAILS

script = [];
script.name = 'BigC_Task.m';
script.path = which(script.name);
script.revisionDate = '9/29-14';
script.PsychtoolboxVersion = PsychtoolboxVersion;
script.matlabVersion = version;

%% TASK PARAMETERS

design = [];
design.currentDate = datestr(now, 'mmmm dd, yyyy HH:MM:SS.FFF AM');
design.subjectID = [];
design.type = [];
design.assignment = [];
design.run = [];
design.list = {};
design.hid_probe_info = [];

wordlists.uses = {};
wordlists.objects = {};

var = [];
var.fonttype = 'Helvetica';
var.fontsize = [50 20]; % Words and Conditions, respectively
var.abs_start = [];
var.durations = [20 20]; % Condition and Rest, respectively
var.pressNum = 5;
var.pressTiming = [];
var.pressDur = [];
var.timing = [];

response = [];

%% SCREEN FLIP TIMING

flip = [];

% Text timing
flip.text.begin = [];
flip.text.end = [];

% Matrix of flip timing for Jitter, Start Condition, Pre Gap, Task Start, Post Gap, and
% End Condition (Respectively for each column)
flip.screens = [];

% Screen flips during the Rest Condition
flip.rest.press = [];
flip.rest.return = [];

% Screen flips during the Task Condition
flip.task = [];

%% RUN ORDERS AND WORD/CONDITION LISTS

% Runs used for scanning (8AU, 8OC, 7Rest)
% Individual Run Time: 540.5-609.5 seconds (9.01-10.16 minutes)

scanRun1 = {0;0;2;0;0;2;1;1;2;1;1;2;0;0;2;0;0;2;1;1;2;1;1};
scanRun2 = {1;1;2;1;1;2;0;0;2;0;0;2;1;1;2;1;1;2;0;0;2;0;0};

% Runs used for behavioral testing/words piloting (12AU, 12OC, 11Rest)
% Individual Run Time: 822.5-927.5 seconds (13.71-15.46 minutes)

behavRun1 = {0;0;2;0;0;2;1;1;2;1;1;2;0;0;2;0;0;2;1;1;2;1;1;2;0;0;2;0;0;2;1;1;2;1;1};
behavRun2 = {1;1;2;1;1;2;0;0;2;0;0;2;1;1;2;1;1;2;0;0;2;0;0;2;1;1;2;1;1;2;0;0;2;0;0};

testRun1 = {0;2;1};
testRun2 = {1;2;0};

scan1 = {'CD' 'RULER' 'SHOPPING CART' 'WATCH' 'BOTTLE' 'BUTTON' 'CUP' 'HAMMER'...
    'KEY' 'THREAD' 'CHAIR' 'COOKING POT' 'NAPKIN' 'SOCK' 'SPOON' 'NEWSPAPER'};

scan2 = {'FORK' 'BRICK' 'TAPE' 'BALL' 'VASE' 'ROCKET' 'PAPER' 'LIGHTER'...
    'TELESCOPE' 'CANOE' 'LANTERN' 'SCREW' 'CHEWING GUM' 'PUTTY' 'STRAW' 'MATCHES'};

behav1 = {'CAR TIRE' 'BUTTON' 'UMBRELLA' 'FORK' 'SHOE' 'NEEDLE' 'PENCIL'...
    'BRICK' 'RULER' 'PILLOW' 'PAN' 'BOOK' 'THREAD' 'GOLF CLUB' 'NEWSPAPER'...
    'PLATE' 'BALL' 'DOOR' 'VODKA' 'COCONUT' 'COMB' 'VASE' 'TELESCOPE'...
    'BALLOON'};

behav2 = {'BOTTLE' 'CUP' 'WATCH' 'CHAIR' 'COOKING POT' 'NAPKIN' 'SOCK' 'SCREW'...
    'KEY' 'CD' 'CHEWING GUM' 'PADDLE' 'MATCHES' 'SPOON' 'CANOE' 'STRAW'...
    'HAMMER' 'LIGHTER' 'LANTERN' 'SHOPPING CART' 'PAPER' 'PUTTY' 'ROCKET'...
    'TAPE'};

test1 = {'CAR TIRE' 'BUTTON'};
test2 = {'BOTTLE' 'CUP'};

%% CREATING THE RUN LISTS

design.subjectID = input('Enter Subject ID: ', 's');
fprintf('REMINDER: Assignment A for Odd IDs, Assignment B for Even IDs\n');

design.type = input('Behavioral, Scan, or Test?: ', 's');

% ODD Subject ID = Assignment A && EVEN Subject ID = Assignment B;
design.assignment = input('Enter Assignment [A or B]: ', 's');
design.run = input('Enter Run # [1-2]: ');

if strcmp(design.type, 'Scan');
    rand('seed',sum(100*clock));
else
    rng('shuffle')
end

if strcmp(design.type, 'Scan');
    restCount = 7;
    
    if design.run == 1;
        design.list = scanRun1;
        count = [1 1]; % Run 1: first half of the word list
        
        wordlists.uses = scan1(randperm(length(scan1)));
        wordlists.objects = scan2(randperm(length(scan2)));
        
    elseif design.run == 2;
        s2 = length(scan1)/2 + 1;
        design.list = scanRun2;
        count = [s2 s2]; % Run 2: second half of the word list
        
        subjLoc = ['Data/', num2str(design.subjectID), '_Scan_1.mat'];
        load(subjLoc, 'wordlists');
    end

elseif strcmp(design.type, 'Behavioral');
    restCount = 11;

    if design.run == 1;
        design.list = behavRun1;
        count = [1 1]; % Run 1: first half of the word list
        
        wordlists.uses = behav1(randperm(length(behav1)));
        wordlists.objects = behav2(randperm(length(behav2)));
    
    elseif design.run == 2;
        s2 = length(behav1)/2 + 1;
        design.list = behavRun2;
        count = [s2 s2]; % Run 2: second half of the word list
        
        subjLoc = ['Data/', num2str(design.subjectID), '_Behav_1.mat'];
        load(subjLoc, 'wordlists');
    end

elseif strcmp(design.type, 'Test');
    restCount = 1;

    if design.run == 1;
        design.list = testRun1;
        count = [1 1]; % Run 1: first half of the word list
        
        wordlists.uses = test1(randperm(length(test1)));
        wordlists.objects = test2(randperm(length(test2)));
        
    elseif design.run == 2;
        s2 = length(test1)/2 + 1;
        design.list = testRun2;
        count = [s2 s2]; % Run 2: second half of the word list
        
        subjLoc = ['Data/', num2str(design.subjectID), '_Test_1.mat'];
        load(subjLoc, 'wordlists');
    end
    
end

% Assigns words and appropriate condition based on count and assignment
% Column 1: Condition identifier
% Column 2: Prompt (word or 'PRESS')
% Column 3: Condition
% Column 4: Number of button presses during that trial (added progressively
% throuhgout the run)

for n = 1:length(design.list);
    if design.list{n,1} == 1;
        design.list{n,2} = wordlists.uses{count(1)};
        count = [count(1) + 1, count(2)];
    elseif design.list{n,1} == 0;
        design.list{n,2} = wordlists.objects{count(2)};
        count = [count(1), count(2) + 1];
    elseif design.list{n,1} == 2;
        design.list{n,2} = 'PRESS';
        design.list{n,3} = 'REST';
    end
    
    if strcmp(design.assignment, 'A');
        if design.list{n,1} == 1;
            design.list{n,3} = 'UNUSUAL USES';
        elseif design.list{n,1} == 0;
            design.list{n,3} = 'TYPICAL QUALITIES';
        end
    elseif strcmp(design.assignment, 'B');
        if design.list{n,1} == 1;
            design.list{n,3} = 'TYPICAL QUALITIES';
        elseif design.list{n,1} == 0;
            design.list{n,3} = 'UNUSUAL USES';
        end
    end
end

%% RANDOMIZE 'PRESS' OCCURRENCES DURING REST CONDITIONS
% 'PRESS' hightlight randomized throughout the task
% Prompts randomized between 2s after/before rest period start/end, respectively,
% as well as at least 3s apart from each other

% Able to modify var.pressNum to how many prompts you want to appear during
% the rest period.

for x = 1:restCount;

    double = 1;

    while double;
        press = randi([3,18], 1, var.pressNum);
        press = sort(press);
        double = 0;

        for n = 2:length(press);
            if press(n-1) == press(n);
                double = 1;
            end
        end

        for n = 1:length(press) - 1;
            if press(n) == press(n+1) - 1 || press(n) == press(n+1) - 2
                double = 1;
            end
        end
    end

    presstiming(1) = [press(1)];

    for n = 2:length(press);
        presstiming(n) = press(n) - press(n-1);
        pressdur(n-1) = press(n) - press(n-1);
    end

    pressdur(n) = var.durations(2) - press(n);
    
    var.pressTiming = [var.pressTiming; presstiming];
    var.pressDur = [var.pressDur; pressdur];

end

%% RUN TIMING

triple = 1;
while triple;
    triple = 0;
    for p = 1:length(design.list);
        jitter(p) = 2 + (5-2)*rand(1);
    end
    
    if sum(jitter) > 103.5 && sum(jitter) < 105.5;
        triple = 1;
    end
end


var.timing = 0;

for r = 2:length(design.list);
    var.timing(r) = var.timing(r-1) + jitter(r) + 21.5;
end

%% TRIGGER & BUTTON INFO

KbName('UnifyKeyNames');
FlushEvents('keyDown');

TRKey1 = KbName('T'); % TR signal key 932
TRKey2 = KbName('5'); % TR signal key 932
TRKey3 = KbName('6'); % TR signal key 904
TRKB = KbName('5%');  % Keyboard TR (Mac)

allowedKeys = {'1' '1!'};

%% CHECKMARK TEXTURE PARAMETERS

[check map alpha] = imread('checkmark.png');

% CHECKMARK STARTING POINTS
checkloc = [50;60;70;80];

for n = 2:40;
    checkloc(:,n) = checkloc(:,n-1) + [20;0;20;0];
end

%% HID_PROBE

% If running a scan, choose the FORP Button Box.
% If a behavioral test, choose the MAC keyboard.
subj = ['subject ' num2str(design.subjectID)];
[device, device_name] = hid_probe(subj);
design.hid_probe_info = [device, device_name];

%% INITIALIZE SCREEN

screens = 0;
Screen('Preference', 'VisualDebugLevel', 1);

[w, rect] = Screen('OpenWindow', screens, 0, []);
HideCursor;

black = BlackIndex(w);
white = WhiteIndex(w);

% STARTING PARAMETERS FOR CHECKMARK APPEARANCE AND LOCATION
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
tIndex = Screen('MakeTexture',w,check);

Screen('TextFont', w, var.fonttype);
Screen('TextSize', w, var.fontsize(2));
DrawFormattedText(w, 'Waiting for scanner to start...', 'center', 'center', white);
[bflip] = Screen('Flip',w);
flip.text.begin = bflip;

% var.abs_start = KbTriggerWait(KbName(allowedKeys(1)));
% DisableKeysForKbCheck(KbName(allowedKeys(1)));

while KbCheck(-1); end % Clear keyboard queue
Scanning = 0;
while Scanning ~= 1;
    [keyIsDown, TimePt, keyCode] = KbCheck(-1);
    if ( keyCode(TRKey1) || keyCode(TRKey2) || keyCode(TRKey3) || keyCode(TRKB) );
        Scanning = 1; disp('Scan Has Begun');
        var.abs_start = TimePt;
    end
end
DisableKeysForKbCheck([KbName('T'), KbName('5'), KbName('6')]);

startTime = var.timing + var.abs_start;

%% RUNNING THE TRIALS

% try
    for n = 1:length(design.list);
        
        % CONDITION START
        Screen('TextSize',w, var.fontsize(1));
        DrawFormattedText(w, 'Start', 'center', 'center', white);
        Screen('TextSize',w, var.fontsize(2));
        DrawFormattedText(w, design.list{n,3}, 'center', rect(4)*(0.55), white);
        [sflip] = Screen('Flip', w, startTime(n));
        
        % GAP BREAK
        Screen('TextSize', w, var.fontsize(2));
        DrawFormattedText(w, design.list{n,3}, 'center', rect(4)*(0.55), white);
        [gflip] = Screen('Flip', w, sflip + 0.5);

        % CONDITION
        presscount = 0;

        if design.list{n,1} == 2; % RUN REST CONDITION
            rcounter = 1;
            response(n,1) = 0;
            
            Screen('TextSize',w, var.fontsize(1));
            DrawFormattedText(w, design.list{n,2}, 'center', 'center', [28 28 28]);
            [cflip] = Screen('Flip', w, gflip + 0.25);
            etime = cflip;
            
            for x = 1:size(var.pressTiming,2);
                etime = etime + var.pressTiming(rcounter, x);
                
                if presscount > 0;
                    Screen('DrawTextures', w, tIndex, [], checkloc(:,1:presscount));
                end
                
                Screen('TextSize',w, var.fontsize(1));
                DrawFormattedText(w, design.list{n,2}, 'center', 'center', white);
                [respond] = Screen('Flip', w, etime);
                flip.rest.press(n,x) = respond - var.abs_start;
                
                while GetSecs() - respond < var.pressDur(rcounter, x);
                    
                    [secs, key, RT] = GetKeyWithTimeout2(device, allowedKeys, (var.pressDur(rcounter, x) - (GetSecs() - respond)));
                                        
                    if ~strcmp(key, 'T');
                        response(n,x) = secs - var.abs_start;
                        
                        presscount = presscount + 1;

                        Screen('DrawTextures', w, tIndex, [], checkloc(:,1:presscount));
                        Screen('TextSize',w, var.fontsize(1));
                        DrawFormattedText(w, design.list{n,2}, 'center', 'center', [28 28 28]);
                        [rflip] = Screen('Flip', w);
                        flip.rest.return(n,x) = rflip - var.abs_start;
                        
                    end
                end
            end
                        
            rcounter = rcounter + 1;
            design.list{n,4} = length(nonzeros(response(n,:)));
        
        else % RUN TASK CONDITION
            
            response(n,1) = 0;
            
            Screen('TextSize', w, var.fontsize(1));
            DrawFormattedText(w, design.list{n,2}, 'center', 'center', white);
            Screen('TextSize', w, var.fontsize(2));
            DrawFormattedText(w, design.list{n,3}, 'center', rect(4)*(0.55), white);
            [cflip] = Screen('Flip', w, gflip + 0.25);
                        
            while GetSecs() - cflip < var.durations(1);
                
                [secs, key, RT] = GetKeyWithTimeout2(device, allowedKeys, (var.durations(1) - (GetSecs() - cflip)));
                
                if ~strcmp(key, 'T');
                    presscount = presscount + 1;
                    response(n, presscount) = secs - var.abs_start;
                    
                    Screen('DrawTextures', w, tIndex, [], checkloc(:,1:presscount));
                    Screen('TextSize', w, var.fontsize(1));
                    DrawFormattedText(w, design.list{n,2}, 'center', 'center', white);
                    Screen('TextSize', w, var.fontsize(2));
                    DrawFormattedText(w, design.list{n,3}, 'center', rect(4)*(0.55), white);
                    [fbackflip] = Screen('Flip', w);
                    
                    flip.task(n, presscount) = fbackflip - var.abs_start;

                end
            end
            
            design.list{n,4} = length(nonzeros(response(n,:)));
        end
        
        % GAP BREAK
        Screen('TextSize',w, var.fontsize(2));
        DrawFormattedText(w, design.list{n,3}, 'center', rect(4)*(0.55), white);
        [bflip] = Screen('Flip', w, cflip + 20);

        % CONDITION END
        Screen('TextSize',w, var.fontsize(1));
        DrawFormattedText(w, 'End', 'center', 'center', white);
        Screen('TextSize',w, var.fontsize(2));
        DrawFormattedText(w, design.list{n,3}, 'center', rect(4)*(0.55), white);
        [eflip] = Screen('Flip', w, bflip + 0.25);
        
        % JITTER (ITI)
        [jflip] = Screen('Flip', w, eflip + 0.5);
        
        flip.screens(n,:) = [sflip gflip cflip bflip eflip jflip] - var.abs_start;
        
    end

%% RUN COMPLETE

	Screen('TextSize',w, var.fontsize(2));
	DrawFormattedText(w, 'Run Complete: Waiting for scan to finish...', 'center', 'center', white);
    [finish] = Screen('Flip', w, jflip + jitter(n));
    
    flip.text.end = finish - var.abs_start;

    KbWait;
    [keyIsDown, secs, KeyCode] = KbCheck(device);

    Screen('CloseAll');
    fprintf('Congratulations! Big C Task: Run %.f complete\n', design.run);
    
    %% SAVING RAW DATA FILES
    % script: name, path, revisionDate, PsychtoolboxVersion, matlabVersion
    % design: currentDate, subjectID, type, assignment, run, list, hid_probe_info
    % var: durations, pressNum, rest.timing, rest.dur, jitter, fonttype, fontsize
    % response
    % flip: text.begin, text.end, screens, rest.press, rest.return, task

    AUOCDir = fileparts(script.path);
    subjectdatafile = [num2str(design.subjectID), '_', design.type, '_', num2str(design.run), '.mat'];
    save(fullfile(AUOCDir, 'Data', subjectDataFile), 'script', 'design', 'var', 'wordlists', 'response', 'flip');

% catch

%     Screen('CloseAll');
%     disp('Script Did Not Work');
    
%     AUOCDir = fileparts(script.path);
%     subjectdatafile = [design.type, '_', num2str(design.run), '_incomplete_', num2str(design.subjectID), '.mat'];
%     save(fullfile(AUOCDir, 'Data', subjectDataFile), 'script', 'design', 'var', 'response', 'flip');
    
% end



