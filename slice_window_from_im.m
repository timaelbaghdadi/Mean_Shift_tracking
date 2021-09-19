function win = slice_window_from_im(y,frame,halfWindowHeight,halfWindowWidth)

if y(1) - halfWindowHeight <= 0
    upedge = 1;
else
    upedge = y(1) - halfWindowHeight;
end
if y(1) + halfWindowHeight >= size(frame,1)
    lowedge = size(frame,1);
else
    lowedge = y(1) + halfWindowHeight;
end
if y(2) + halfWindowWidth >= size(frame,2)
    rightedge = size(frame,2);
else
    rightedge = y(2) + halfWindowWidth;
end
if y(2) - halfWindowWidth <= 0
    leftedge = 1;
else
    leftedge = y(2) - halfWindowWidth;
end     

% Slice 
win = frame(upedge:lowedge,leftedge:rightedge); 

end