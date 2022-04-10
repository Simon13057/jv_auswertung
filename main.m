clear variables
close all

%% Add revant paths
addpath("./functions")

%% TODO section
% specify groups to import, folder of *.IV files, folder to save data
% 'groups' must match batch description 

fromFolder = "C:\Users\Simon\Desktop\experiments\simon-matlab\2022-04-06";
toFolder = "C:\Users\Simon\Desktop\experiments\simon-matlab\auswertung\testing\2";
groups = ["NiO300_UV" "NiO300_Plasma" "NiO300" "NiO300_1" "NiO300_2"];

%% Execute

data = read_data(fromFolder, toFolder, 0.5);
plot_parameter(data, groups, toFolder);
jv_plot(data, [4 11], toFolder);