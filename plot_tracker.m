function plot_tracker( y0, height, width, frame)

% Display frame and tracking focus
imshow(uint8(frame));
hold on;
plot(y0(2),y0(1),'r*')
hold on
paintcolor = [1 0 0];   %red
rectangle('Position', [y0(2)-height/2, y0(1)-width/2,height, width],...
          'EdgeColor', paintcolor)
drawnow;
end
