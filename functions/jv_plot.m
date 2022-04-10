function out = jv_plot(data, samples, toSave)
% JV_PLOT plots the J-V curves of given samples [X Y Z] and saves the
% figures as .png in 'toSave' folder
%
% 'data' has to match the table with the devices given by READ_DATA

    for n = 1:length(samples)
        dat = data(eq(data.Group, samples(n)),:);
        pixels = categories(categorical(dat.Pixel));
        for m = 1:length(pixels)
            X = dat.Voltage(strcmp(dat.Pixel, pixels(m)) & strcmp(dat.Scan_Direction,'forward'),:);
            Y = dat.Current_Density(strcmp(dat.Pixel, pixels(m)) & strcmp(dat.Scan_Direction,'forward'),:);
            plot(X,Y)
            
            hold on
            Y = dat.Current_Density(strcmp(dat.Pixel, pixels(m)) & strcmp(dat.Scan_Direction,'backward'),:);
            plot(X,Y)
            hold off
            
            legend('forward', 'backward')
            xlabel('Voltage V')
            ylabel('Current Density J')
            title(strcat("Sample: ",num2str(samples(n)), " ,Pixel: ", pixels(m)))
            grid
            saveas(gcf,strcat(toSave,"\Sample_",num2str(samples(n)), "_Pixel_", pixels(m),".png"))
        end
    end
    close all
end