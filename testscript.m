%% Load from res folder (using img files)
files = [dir('res\*jpg');dir('res\*.png')];

Results = {'File Name', 'Result'};

i = 1;
for file = files'
    Results{i+1, 1} = file.name;    
    try
        picture = imread("res\" + file.name);
        crop
        alpr
        Results{i+1, 2} = width;
    catch
        Results{i+1, 2} = 'ERROR';
    end        
    i = i + 1;
end

T = cell2table(Results(2:end,:),'VariableNames',Results(1,:));
writetable(T,'Results.csv');

%% Load from source CSV (using links)
CSV = readtable("KF_HF_database.csv", "ReadVariableNames", false);

Results = {'File Name', 'Result1', 'Result2'};

nmOfRows = size(CSV, 1);
for row = 1:50
    Results{row+1, 1} = string(CSV(row, 1).Var1);   
    try
        picture = imread(string(CSV(row, 2).Var2));
        crop
        alpr
        Results{i+1, 2} = '';
    catch
        Results{i+1, 2} = 'ERROR';
    end     
    try
        picture = imread(string(CSV(row, 3).Var3));
        crop
        alpr
        Results{i+1, 3} = '';
    catch
        Results{i+1, 3} = 'ERROR';
    end   
end

T = cell2table(Results(2:end,:),'VariableNames',Results(1,:));
writetable(T,'ResultsSource.csv');

