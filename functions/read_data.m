function tab = read_data(dat_folder, toSave, max_jump)
%READ_DATA returns table of the relevant data given by a folder with .IV2 and .IV0 files
%
%max_jump gives the maximum difference between two data points in the
%data of current. If data jumps to much (which means that the device is faulty)
%then this pixel is ignored and labeled as not intact.

    l_files = dir(strcat(dat_folder,'/*.IV2'));
    d_files = dir(strcat(dat_folder,'/*.IV0'));
    
    %rename .IV2 files 
    if ~isempty(l_files)
        temp_folder = strcat(toSave,'/temp/light/');
        mkdir(temp_folder);
        for id = 1:length(l_files)
            [~, f,~] = fileparts(l_files(id).name);
            rename = strcat(temp_folder,f,'.txt');
            copyfile(strcat(dat_folder,'/',l_files(id).name), strcat(temp_folder,l_files(id).name));
            movefile(strcat(temp_folder,l_files(id).name), rename); 
        end
    end
    
    %rename .IV0 files 
    if ~isempty(d_files)
        temp_folder = strcat(toSave,'/temp/dark/');
        mkdir(temp_folder);
        for id = 1:length(d_files)
            [~, f,~] = fileparts(d_files(id).name);
            rename = strcat(temp_folder,f,'.txt');
            copyfile(strcat(dat_folder,'/',d_files(id).name), strcat(temp_folder,d_files(id).name));
            movefile(strcat(temp_folder,d_files(id).name), rename); 
        end
    end
    
    devices = table;
    l_files = dir(strcat(toSave,'/temp/light/*.txt'));
    for id = 1:length(l_files)
        [~, f,~] = fileparts(l_files(id).name);
        name = strcat(toSave,'/temp/light/', f);

        opts = delimitedTextImportOptions("NumVariables", 4);
        opts.Delimiter = "\t";
        opts.VariableNames = {'Voltage_V', 'Current_I', 'CurDens_J', 'Time_t'};
        opts.VariableTypes = ["double", "double", "double", "double"];
        opts.ExtraColumnsRule = "ignore";
        opts.EmptyLineRule = "skip";

        data = readtable(name,opts);
        Voltage = data.Voltage_V(~isnan(data.Voltage_V));
        CurDens = data.CurDens_J(~isnan(data.CurDens_J));
        Current = data.Current_I(~isnan(data.CurDens_J));
        x = data.Current_I(~isnan(data.Current_I));
        group = x(3);
        jsc = x(11);
        voc = x(12);
        ff = x(16);
        pce = x(17);
        
        opts = delimitedTextImportOptions("NumVariables", 2);
        opts.Delimiter = "\t";
        opts.VariableNames = {'Voltage_V', 'Info'};
        opts.VariableTypes = ["double", "char"];
        opts.ExtraColumnsRule = "ignore";
        opts.EmptyLineRule = "skip";

        data2 = readtable(name,opts);
        pixel = data2.Info(4);
        desc = data2.Info(6);
        scan_dir  = data2.Info(12);
        
        temp = table;
        temp.Pixel = pixel;
        temp.Scan_Direction = scan_dir;
        temp.Description = desc;
        temp.Group = group;
        temp.Jsc = jsc;
        temp.Voc  =voc;
        temp.FF = ff;
        temp.PCE = pce;
        temp.ID = id;
        
        %check for faulty cells (when current jumps more than "max_jump")
        intact = true; 
        for n = 1:(length(Current)-1)
            if abs(Current(n)-Current(n+1))>max_jump
                intact = false;
            end
        end
        temp.Intact = intact;
        
        temp.Voltage = Voltage';
        temp.Current_Density = CurDens';
        temp.Current = Current';
        
        devices = [devices; temp];
    end    
    tab = devices;
end