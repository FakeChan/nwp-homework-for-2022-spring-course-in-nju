%----------------------------------------一维线性平流方程的求解------------------------------------------------------
%-------------------------------------------191830035傅克成----------------------------------------------------------
clc;
%输入默认参数
delta_x=400;
delta_t=2;
c=20;
u_0=20;
tbar=c*delta_t/delta_x;
%空间步长数
m=360;
%时间步长数
n=ceil(360/tbar);
%设置初始参数
mu=c*delta_t/delta_x;
u=zeros(m,n);
%---------------下边界
for i=1:m
    if i<=m/2
        u(i,1)=0;
    else
        u(i,1)=1;
    end
end
%------------------先对时间前差------------------------
for i=1:m
    if i==1
        u(i,2)=u(i,1)-0.5*mu*(u(i+1,1)-u(m,1));
    elseif i==m
        u(i,2)=u(i,1)-0.5*mu*(u(1,1)-u(i-1,1));
    else
        u(i,2)=u(i,1)-0.5*mu*(u(i+1,1)-u(i-1,1));
    end
end
%-----------------再做中央差分-------------------------
for j=2:n
    for i=1:m
        if i==1
            u(i,j+1)=u(i,j-1)+mu*(u(m,j)-u(i+1,j));
        elseif i==m
            u(i,j+1)=u(i,j-1)+mu*(u(i-1,j)-u(1,j));
        else
            u(i,j+1)=u(i,j-1)+mu*(u(i-1,j)-u(i+1,j));
        end
    end
end
u=u';
figure(1)
subplot(3,3,1)
plot(u(1,:))
title('tbar=0')
subplot(3,3,2)
plot(u(ceil(60/tbar),:))
title('tbar=60')
subplot(3,3,3)
plot(u(ceil(120/tbar),:))
title('tbar=120')
subplot(3,3,4)
plot(u(ceil(180/tbar),:))
title('tbar=180')
subplot(3,3,5)
plot(u(ceil(240/tbar),:))
title('tbar=240')
subplot(3,3,6)
plot(u(ceil(300/tbar),:))
title('tbar=300')
subplot(3,3,7)
plot(u(ceil(360/tbar),:))
title('tbar=360')
sgtitle('Numerical solution of u')
%保存图片
saveas(1,'numerical solution of u.png')
%----------------试着绘制动图---------------------------
pic_num=1;
 for t=1:360
    figure(3)
    plot(u(ceil(t/tbar),:))
    axis([0 360 -0.6 1.5])
    title('wave u')
    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);
    if pic_num == 1
        imwrite(I,map,'wave.gif','gif', 'Loopcount',inf,'DelayTime',0.001);
    else
        imwrite(I,map,'wave.gif','gif','WriteMode','append','DelayTime',0.001);
    end
    pic_num = pic_num + 1;
end