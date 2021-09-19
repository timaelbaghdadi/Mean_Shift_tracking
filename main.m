clear;
close all;

% FILE_PATH can be relative or absolute
FILE_PATH = 'car_cam.mp4';

% If RGB, transform RGB to grayscale?
rgb_to_gray = true;

[vid,channels,xsize,ysize,numframes] = create_video_object(FILE_PATH);


if channels == 1 || rgb_to_gray == true
    % It is a one channel image, aka grayscale
    one_channel_tracker(vid,xsize,ysize,numframes,rgb_to_gray,FILE_PATH);
elseif channels == 3
    % It is a three channel image, aka RGB
    three_channel_tracker(vid,xsize,ysize,numframes,FILE_PATH);
end

