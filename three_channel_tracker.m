function three_channel_tracker(vid,xsize,ysize,numframes,FILE_PATH)

% Read the different frames and save them in each channel according to the 
% color (preallocation for speed)
r = zeros(xsize,ysize,numframes);
g = zeros(xsize,ysize,numframes);
b = zeros(xsize,ysize,numframes);
k=1;
while hasFrame(vid)
    img = readFrame(vid);
    r(:,:,k)=img(:,:,1);
    g(:,:,k)=img(:,:,2);
    b(:,:,k)=img(:,:,3);
    k = k+1;
end

% Import video configuration
[x,y,height,width,maxvalueR,minvalueR,maxvalueG,...
   minvalueG,maxvalueB,minvalueB] = import_video_config_3channel(FILE_PATH);

% Center of the ROI wrt to original image
y0 = [x,y];

% Window dimensions
halfWindowHeight = height/2;
halfWindowWidth = width/2;


for f = 2:k
    % The windows in each channel are created and the average value is
    % calculated according to the color of each channel.
    win_R = slice_window_from_im(y0,r(:,:,f),halfWindowHeight,halfWindowWidth);
    win_G = slice_window_from_im(y0,g(:,:,f),halfWindowHeight,halfWindowWidth);
    win_B = slice_window_from_im(y0,b(:,:,f),halfWindowHeight,halfWindowWidth);
    y1_R = Kernel_average(win_R, y0, maxvalueR, minvalueR, height,...
        width, halfWindowWidth, halfWindowHeight);
    y1_G = Kernel_average(win_G, y0, maxvalueG, minvalueG, height,...
        width,halfWindowWidth, halfWindowHeight);
    y1_B = Kernel_average(win_B, y0, maxvalueB, minvalueB, height,...
        width, halfWindowWidth, halfWindowHeight);
    
    % In this step, once the value of y1 is calculated according to the
    % channel, it is considered that the point where the color varies the
    % most according to the channel is chosen as the new center. But if not
    % the average of the 3 channels is calculated.
    y1= (y1_G + y1_R + y1_B)/3;
    
    % When the new point is not Nan: it hasn't found any pixel
    % that have the value that we have initially given.
    % If we get a value of y1, point to reset it to the value of y0, since 
    % it will be the new center, from which the same procedure will be done 
    % again.
    if isnan(y1) 
        N=1;
    else
        N=0;
    end
    if N==0
        y0 = y1;
    end
    
    % We combine the 3 channels to print the frames in colours
    rgbImage = cat(3, r(:,:,f), g(:,:,f), b(:,:,f)); 
    
    % Plot the tracking position along with the video frame
    plot_tracker( y0, height, width, rgbImage)
end



end