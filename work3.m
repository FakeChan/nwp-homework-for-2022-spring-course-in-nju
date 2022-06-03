%----------------------------------------一维线性平流方程的求解------------------------------------------------------
%-------------------------------------------191830035傅克成----------------------------------------------------------
clc;
%输入默认参数
delta_x=400;
delta_t=2;
c=20;
u_0=20;
%空间步长
m=360;
%时间步长
n=301;
%设置初始参数
sigma=c*delta_t/delta_x;
u=zeros(m+1,n);
for i=1:m+1
    u(i,1)=u_0*cosd(3*(i-1));%---------------下边界
end
for j=1:n
    u(1,j)=u_0*cosd(3*j*sigma);%------------------左边界
end
u(361,:)=u(1,:);
%------------------先对时间前差------------------------
for i=2:m
    u(i,2)=u(i,1)-0.5*sigma*(u(i+1,1)-u(i-1,1));
end
%-----------------再做中央差分-------------------------
for j=2:n
    for i=2:m
        u(i,j+1)=u(i,j-1)+sigma*(u(i-1,j)-u(i+1,j));
    end
end
%----------------将u矩阵转置绘图-----------------------
u=u(1:m,1:n-1)';
figure(1)
contourf(u)
title('the numerical solution of u,type 1')
xlabel('space grid')
xticks([1 60 120 180 240 300 360])
xticklabels({'0','60','120','180','240','300','360'})
ylabel('time grid')
yticks([1 50 100 150 200 250 300])
yticklabels({'0','50','100','150','200','250','300'})
colorbar
saveas(1,'numerical solution of u.png')
figure(2)
plot(u(:,60),'r','LineWidth',2)
hold on
plot(u(:,120),'g','LineWidth',2)
hold on
plot(u(:,140),'b','LineWidth',2)
hold on
plot(u(:,160),'m','LineWidth',2)
hold on
xlabel('time grid')
ylabel('amplitude')
title('changes of u at different space grid,type1')
legend('60°','120°','140°','160°')
saveas(2,'changes of u at different space grid.png')
pic_num = 1;
%------------------------------------------------绘制动图-------------------------------------------------------
for t=1:300
    figure(3)
    plot(u(t,:))
    axis([0 400 -25 25])
    title('type1')
    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);
    if pic_num == 1
        imwrite(I,map,'type1.gif','gif', 'Loopcount',inf,'DelayTime',0.001);
    else
        imwrite(I,map,'type1.gif','gif','WriteMode','append','DelayTime',0.001);
    end
    pic_num = pic_num + 1;
end