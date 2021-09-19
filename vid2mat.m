function f = vid2mat(vid,xsize,ysize,numframes)
f = zeros(xsize,ysize,numframes);
idx = 1;
while hasFrame(vid)
    frame = readFrame(vid);
    frame = rgb2gray(frame);
    f(:,:,idx) = frame;
    idx = idx + 1;
end