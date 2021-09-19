function y1 = Kernel_average(win, y0, maxvalue, minvalue, height,...
    width, halfWindowWidth, halfWindowHeight)
g = zeros(size(win,1),size(win,2));
centerx = y0(1);
centery = y0(2);
centerx_win=size(win,1)/2;
centery_win=size(win,2)/2;
H = height;
W = width;
kx=[];
ky=[];

for u =minvalue:maxvalue
    [row, col] = find(win==u);
    for i = 1:size(col,1)
        kx(i) =  1- (norm((col(i)-centery_win)/W))^2;
        ky(i) = 1 - (norm((row(i)-centerx_win)/H))^2;
        k = sqrt(kx(i)*ky(i)');
        g(row(i), col(i))= k;
    end
    
end
wx_num=0;
wx_deno=0;
wy_num=0;
wy_deno=0;
for u = minvalue:maxvalue
    [row, col] = find(win==u);
    for i = 1:size(col,1)
        wx_num = wx_num + g(row(i), col(i))* (centery - halfWindowWidth + col(i));
        wx_deno = wx_deno + g(row(i), col(i));
        wy_num = wy_num + g(row(i), col(i))* (centerx - halfWindowHeight + row(i));
        wy_deno = wy_deno + g(row(i), col(i));
    end
end
y1 = [round(wy_num/wy_deno), round(wx_num/wx_deno) ];
end