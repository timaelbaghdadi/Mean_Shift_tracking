function [x,y,height,width,maxvalueR,minvalueR,maxvalueG,...
   minvalueG,maxvalueB,minvalueB] = import_video_config_3channel(FILE_PATH)

% This function loads the configuration for every video that we have

if strcmp(FILE_PATH,'car_cam.mp4')
    %%%%%%%%%%%%%%%%%%%%%% VIDEO CONFIG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    y = 321;
    x = 180;
    height = 60;
    width = 90;

    %Maximum and minimum values in each channel.
    maxvalueR=13;
    minvalueR=6;
    maxvalueG=17;
    minvalueG=16;
    maxvalueB=15;
    minvalueB=13;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

% Add more if conditions to import the paramters depending the type of
% video used

end