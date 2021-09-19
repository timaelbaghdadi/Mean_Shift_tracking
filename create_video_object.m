function [vid,channels,xsize,ysize,numframes] = create_video_object(FILE_PATH)


vid = VideoReader(FILE_PATH);
framegeneral = read(vid,1);
channels = size(framegeneral,3);
xsize = size(framegeneral,1);
ysize = size(framegeneral,2);
numframes = round(vid.Duration*vid.FrameRate - 2);

vid = VideoReader(FILE_PATH);


end