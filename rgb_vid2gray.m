% Turn RGB video to grayscale video
function rgb_vid = rgb_vid2gray(vid,xsize,ysize,numframes)
rgb_vid = zeros(xsize,ysize,numframes);
idx = 1;
while hasFrame(vid)
    frame = readFrame(vid);
    frame = rgb2gray(frame);
    rgb_vid(:,:,idx) = frame;
    idx = idx + 1;
end


end