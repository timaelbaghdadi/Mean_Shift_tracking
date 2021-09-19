function one_channel_tracker(vid,xsize,ysize,numframes,rgb_to_gray,FILE_PATH)

% Transform RGB to grayscale?
if rgb_to_gray == true
    % Transform RGB to grayscale and sStore the video as gray images in a matrix
    frame = rgb_vid2gray(vid,xsize,ysize,numframes) + 1;
else
    frame = vid2mat(vid,xsize,ysize,numframes) + 1;
end

% Import video configuration
[maxvalue,minvalue,y,x,height,width] = import_video_config_1channel(FILE_PATH);

% Center of the ROI wrt to original image
y0 = [x,y];

% Window dimensions of the cadidate target
halfWindowHeight = height/2;
halfWindowWidth = width/2;


for f = 2:size(frame,3)
    % Create the windows that we will analize in every frame
    win = slice_window_from_im(y0,frame(:,:,f),halfWindowHeight,halfWindowWidth);  
    
    % Initialization of the array that will contain the kernel
    g = zeros(size(win,1),size(win,2)); 
    
    % Take the center respect the total image
    centerx = y0(1); 
    centery = y0(2);
    
    %Take the center respect the windows
    centerx_win=size(win,1)/2; 
    centery_win=size(win,2)/2;
    
    % We consider the dimensions of the window with which we will normalize
    H = height; 
    W = width;
    
    for u = minvalue:maxvalue
        % The pixels of the window of the candidate frame are chosen which 
        % have the samegrayscale value as the ones we initially chose.
        % All pixels with the grayscale value of the interval
        % are analysed. We aplly the Epanechnikov Kernel which
        % gives more importance to the closest values to the initial
        % center. In addition, it also normalizes. As we are in 2D
        % we have to consider the distance in the two directions
        % and the result the root of the multiplication of these
        [row, col] = find(win==u); 
        for i = 1:size(col,1)
            kx(i) = 1 - norm((col(i)-centerx_win)/H)^2;
            ky(i) = 1 - norm((row(i)-centery_win)/W)^2;
            k = sqrt(kx(i)*ky(i)');
            g(row(i), col(i))= k;
        end
        
    end
    wx_num=0;
    wx_deno=0;
    wy_num=0;
    wy_deno=0;
    
    
    for u = minvalue:maxvalue 
        % Once the kernel is applied according to the distance,
        % the point where the new point will be found will be the
        % average of the location of the pixels that have the same
        % gray value. The weights involved and that give importance
        % to the location are those we have calculated with the
        % Kernel. This average gives us the location of the new point
        % where the color we have chosen is concentrated
        [row, col] = find(win==u);
        for i = 1:size(col,1)
            wx_num = wx_num + g(row(i), col(i))*...
                (centery - halfWindowWidth + col(i));
            % The transformation is applied to pass the
            % position of the point that was initially with
            % respect to the window chosen with respect to
            % the frame, because it will always place the
            % new point on the left and top of the image
            wx_deno = wx_deno + g(row(i), col(i));
            wy_num = wy_num + g(row(i), col(i))*...
                (centerx - halfWindowHeight + row(i));
            wy_deno = wy_deno + g(row(i), col(i));
        end
    end
    
    % In the new point it is rounded since we are with integer
    % values in the image matrix.
    y1 = [round(wy_num/wy_deno), round(wx_num/wx_deno)];
    
    
    % When the new point is not Nan: it hasn't found any pixel
    % that have the value that we have initially given.
    % If we get a value of y1, point to reset it to the value of
    % y0, since it will be the new center, from which the same procedure
    % will be done again
    if isnan(y1)  
        N=1;
    else
        N=0;
    end
    if N==0
        y0 = y1;
    end
    
    
    % Plot the tracking position along with the video frame
    plot_tracker(y0, height, width, frame(:,:,f))
end



end
