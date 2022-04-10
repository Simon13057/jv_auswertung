function out = plot_parameter(data, descs, toSave)
%Saves the plots of the parameters (PCE, FF, Voc, Jsc) of the groups (given
%by 'descs' array) into the 'toSave' folder as .png

    %PCE
    for id = 1:length(descs)
        subplot(1,length(descs),id);
        dat = data(strcmp(data.Description, descs(id)) & data.Intact, :);
        groups = categories(categorical(dat.Group));
        
        X = [];
        Y = [];
        G = [];
        for n = 1:length(groups)
            pce = dat.PCE(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'L'));
            Y = [Y;pce];
            for i = 1:length(pce)
                X(end+1)=n-0.2;
                G(end+1)=str2double(groups(n));
            end
            pce = dat.PCE(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'M'));
            Y = [Y;pce];
            for i = 1:length(pce)
                X(end+1)=n;
                G(end+1)=str2double(groups(n));
            end
            pce = dat.PCE(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'R'));
            Y = [Y;pce];
            for i = 1:length(pce)
                X(end+1)=n+0.2;
                G(end+1)=str2double(groups(n));
            end
        end
                     
        gscatter(X',Y',G');
        title(descs(id))
        grid
        ylabel("PCE %")
        ylim([0 15])
        saveas(gcf,strcat(toSave,"\PCE.png"))
        hold off
    end 
    %FF
    for id = 1:length(descs)
        subplot(1,length(descs),id);
        dat = data(strcmp(data.Description, descs(id)) & data.Intact, :);
        groups = categories(categorical(dat.Group));
        
        X = [];
        Y = [];
        G = [];
        for n = 1:length(groups)
            FF = dat.FF(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'L'));
            Y = [Y;FF];
            for i = 1:length(FF)
                X(end+1)=n-0.2;
                G(end+1)=str2double(groups(n));
            end
            FF = dat.FF(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'M'));
            Y = [Y;FF];
            for i = 1:length(FF)
                X(end+1)=n;
                G(end+1)=str2double(groups(n));
            end
            FF = dat.FF(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'R'));
            Y = [Y;FF];
            for i = 1:length(FF)
                X(end+1)=n+0.2;
                G(end+1)=str2double(groups(n));
            end
        end
                     
        gscatter(X',Y',G');
        title(descs(id))
        grid
        ylabel("FF %")
        ylim([0 100])
        saveas(gcf,strcat(toSave,"\FF.png"))
        hold off
    end 
    %Jsc
    for id = 1:length(descs)
        subplot(1,length(descs),id);
        dat = data(strcmp(data.Description, descs(id)) & data.Intact, :);
        groups = categories(categorical(dat.Group));
        
        X = [];
        Y = [];
        G = [];
        for n = 1:length(groups)
            Jsc = dat.Jsc(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'L'));
            Y = [Y;Jsc];
            for i = 1:length(Jsc)
                X(end+1)=n-0.2;
                G(end+1)=str2double(groups(n));
            end
            Jsc = dat.Jsc(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'M'));
            Y = [Y;Jsc];
            for i = 1:length(Jsc)
                X(end+1)=n;
                G(end+1)=str2double(groups(n));
            end
            Jsc = dat.Jsc(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'R'));
            Y = [Y;Jsc];
            for i = 1:length(Jsc)
                X(end+1)=n+0.2;
                G(end+1)=str2double(groups(n));
            end
        end
                     
        gscatter(X',Y',G');
        title(descs(id))
        grid
        ylabel("Jsc")
        ylim([0 25])
        saveas(gcf,strcat(toSave,"\Jsc.png"))
        hold off
    end
    
    %Voc
    for id = 1:length(descs)
        subplot(1,length(descs),id);
        dat = data(strcmp(data.Description, descs(id)) & data.Intact, :);
        groups = categories(categorical(dat.Group));
        
        X = [];
        Y = [];
        G = [];
        for n = 1:length(groups)
            Voc = dat.Voc(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'L'));
            Y = [Y;Voc];
            for i = 1:length(Voc)
                X(end+1)=n-0.2;
                G(end+1)=str2double(groups(n));
            end
            Voc = dat.Voc(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'M'));
            Y = [Y;Voc];
            for i = 1:length(Voc)
                X(end+1)=n;
                G(end+1)=str2double(groups(n));
            end
            Voc = dat.Voc(eq(dat.Group, str2double(groups(n))) & strcmp(dat.Pixel,'R'));
            Y = [Y;Voc];
            for i = 1:length(Voc)
                X(end+1)=n+0.2;
                G(end+1)=str2double(groups(n));
            end
        end
                     
        gscatter(X',Y',G');
        title(descs(id))
        grid
        ylabel("Voc")
        ylim([0 1.5])
        saveas(gcf,strcat(toSave,"\Voc.png"))
        hold off
    end 
    close all
end