function [maxvalue,minvalue,y,x,height,width] = ...
    import_video_config_1channel(FILE_PATH)

% This function loads the configuration for every video that we have

if strcmp(FILE_PATH,'car_cam.mp4')
    %%%%%%%%%%%%%%%%%%%%%% VIDEO CONFIG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Max value of bins
    maxvalue = 46;
    minvalue = 36;

    % We choose the center and the dimesnions of the windows of the
    % firstframe to track
    y = 321;
    x = 180;
    height = 100;
    width = 100;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

% Add more if conditions to import the paramters depending the type of
% video used

end