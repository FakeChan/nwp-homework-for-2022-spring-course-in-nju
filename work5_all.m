%---------------------数值天气预报上机作业5-------------------
%----------------------191830035傅克成-----------------------
clc;
%--------------设置初始参数---------------
m=10;%空间格点数
n=1000;%时间格点数
dt=0.004;
dx=0.1;
epsilon=1e-5;
lamda=dt/dx;
u0_1=zeros(1,m+1);u0_2=zeros(1,m+1);
for i=0:m
    u0_1(1,i+1)=sin(2*pi*i*dx);
    u0_2=u0_1+1.5;
end
%----------使用第一种差分格式（通量形式）计算u------------
u_f1_u01_c=format1(u0_1,lamda,m,n,'cyclical');
u_f1_u01_r=format1(u0_1,lamda,m,n,'rigid');
%f1指第一类差分格式format1，u01指第一种初始条件u0_1，c指周期性边界条件,r指刚性边界条件。下同。
u_f1_u02_c=format1(u0_2,lamda,m,n,'cyclical');
u_f1_u02_r=format1(u0_2,lamda,m,n,'rigid');
E_f1_u01_c=zeros(1,n);E_f1_u01_r=zeros(1,n);E_f1_u02_r=zeros(1,n);E_f1_u02_c=zeros(1,n);
for i=1:n
    E_f1_u01_c(1,i)=0.5*sum(u_f1_u01_c(i,:).^2);
    E_f1_u01_r(1,i)=0.5*sum(u_f1_u01_r(i,:).^2);
    E_f1_u02_c(1,i)=0.5*sum(u_f1_u02_c(i,:).^2);
    E_f1_u02_r(1,i)=0.5*sum(u_f1_u02_r(i,:).^2);
end
%---------------使用第二种差分格式计算u------------------
u_f2_u01_c=format2(u0_1,lamda,m,n,'cyclical',epsilon);
u_f2_u01_r=format2(u0_1,lamda,m,n,'rigid',epsilon);
u_f2_u02_c=format2(u0_2,lamda,m,n,'cyclical',epsilon);
u_f2_u02_r=format2(u0_2,lamda,m,n,'rigid',epsilon);
E_f2_u01_c=zeros(1,n);E_f2_u01_r=zeros(1,n);E_f2_u02_r=zeros(1,n);E_f2_u02_c=zeros(1,n);
for i=1:n
    E_f2_u01_c(1,i)=0.5*sum(u_f2_u01_c(i,:).^2);
    E_f2_u01_r(1,i)=0.5*sum(u_f2_u01_r(i,:).^2);
    E_f2_u02_c(1,i)=0.5*sum(u_f2_u02_c(i,:).^2);
    E_f2_u02_r(1,i)=0.5*sum(u_f2_u02_r(i,:).^2);
end
%----------------使用第三种差分格式计算u-----------------
u_f3_u01_c=format3(u0_1,lamda,m,n,'cyclical');
u_f3_u01_r=format3(u0_1,lamda,m,n,'rigid');
u_f3_u02_c=format3(u0_2,lamda,m,n,'cyclical');
u_f3_u02_r=format3(u0_2,lamda,m,n,'rigid');
E_f3_u01_c=zeros(1,n);E_f3_u01_r=zeros(1,n);E_f3_u02_r=zeros(1,n);E_f3_u02_c=zeros(1,n);
for i=1:n
    E_f3_u01_c(1,i)=0.5*sum(u_f3_u01_c(i,:).^2);
    E_f3_u01_r(1,i)=0.5*sum(u_f3_u01_r(i,:).^2);
    E_f3_u02_c(1,i)=0.5*sum(u_f3_u02_c(i,:).^2);
    E_f3_u02_r(1,i)=0.5*sum(u_f3_u02_r(i,:).^2);
end
%------------------------画图--------------------------
%question1
figure(1)
plot(1:n,E_f1_u01_c,'LineWidth',2)
hold on
plot(1:n,E_f2_u01_c,'LineWidth',2)
legend('format1','format2','Location','northwest')
title('quetion1,cyclical boundary')
xlabel('n')
ylabel('$E=\frac{1}{2}\Sigma_m u_m^2$','Interpreter','latex')
axis([0 800 1 5])
saveas(1,'question1.png')
%question2
figure(2)
plot(1:n,E_f1_u02_c,'LineWidth',2)
hold on
plot(1:n,E_f2_u02_c,'LineWidth',2)
legend('format1','format2')
title('quetion2,cyclical boundary')
xlabel('n')
ylabel('$E=\frac{1}{2}\Sigma_m u_m^2$','Interpreter','latex')
axis([0 1000 14.5 15.7])
saveas(2,'question2.png')
%question3
figure(3)
plot(1:n,E_f3_u01_c,'LineWidth',0.5)
hold on
plot(1:n,E_f3_u02_c,'LineWidth',0.5)
legend('$u_0=\sin 2\pi x$','$u_0=\sin 2\pi x+1.5$','Interpreter','latex','Location','northwest')
xlabel('n')
ylabel('$E=\frac{1}{2}\Sigma_m u_m^2$','Interpreter','latex')
title('question3,cyclical boundary')
axis([0 400 0 25])
saveas(3,'question3.png')
%question1,rigid boundary
figure(4)
plot(1:n,E_f1_u01_r,'LineWidth',2)
hold on
plot(1:n,E_f2_u01_r,'LineWidth',2)
legend('format1','format2')
title('quetion1,rigid boundary')
xlabel('n')
ylabel('$E=\frac{1}{2}\Sigma_m u_m^2$','Interpreter','latex')
axis([0 1000 0 3.5])
saveas(4,'question1_rigid.png')
%quetion2,rigid boundary
figure(5)
plot(1:n,E_f1_u02_r,'LineWidth',1)
hold on
plot(1:n,E_f2_u02_r,'LineWidth',1)
legend('format1','format2')
title('quetion2,rigid boundary')
xlabel('n')
ylabel('$E=\frac{1}{2}\Sigma_m u_m^2$','Interpreter','latex')
axis([0 900 5 15])
saveas(5,'question2_rigid.png')
%quetion3,rigid boundary
figure(6)
plot(1:n,E_f3_u01_r,'LineWidth',0.5)
hold on
plot(1:n,E_f3_u02_r,'LineWidth',0.5)
legend('$u_0=\sin 2\pi x$','$u_0=\sin 2\pi x+1.5$','Interpreter','latex','Location','northwest')
xlabel('n')
ylabel('$E=\frac{1}{2}\Sigma_m u_m^2$','Interpreter','latex')
title('question3,rigid boundary')
axis([0 270 0 300])
saveas(6,'question3_rigid.png')
%-------------------------自定义函数-----------------------------
function u1=format1(u0,lamda,m,n,text)
    %--------判断m,n输入是否符合标准---------
    if n<=2|m<=2
        fprintf('invalid number')%不符合
    else
        %---------判断边界类型------------
        if strcmp(text,'cyclical')
            u=zeros(n+1,m+3);
            u(1,2:m+2)=u0;
            %-------对第二层时间做前差-------
            u(1,1)=u(1,m+2);
            u(1,m+3)=u(1,2);
            for j=2:m+2
                u(2,j)=u(1,j)-(lamda/8)*((u(1,j+1)+u(1,j))^2-(u(1,j)+u(1,j-1))^2);
            end
            u(2,1)=u(2,m+2);
            u(2,m+3)=u(2,2);
            %---------中央差分------------
            for i=2:n
                for j=2:m+2
                    u(i+1,j)=u(i-1,j)-(lamda/4)*((u(i,j+1)+u(i,j))^2-(u(i,j)+u(i,j-1))^2);
                    u(i+1,1)=u(i+1,m+2);
                    u(i+1,m+3)=u(i+1,2);
                end
            end
            u1=u(1:n,2:m+2);
        elseif strcmp(text,'rigid')
            u=zeros(n+1,m+1);
            u(1,:)=u0;
            u(:,1)=0;
            u(:,m+1)=0;
            %---------先做前差-----------
            for j=2:m
                u(2,j)=u(1,j)-(lamda/8)*((u(1,j+1)+u(1,j))^2-(u(1,j)+u(1,j-1))^2);
            end
            %--------中央差分-----------
            for i=2:n
                for j=2:m
                    u(i+1,j)=u(i-1,j)-(lamda/4)*((u(i,j+1)+u(i,j))^2-(u(i,j)+u(i,j-1))^2);
                end
            end
            u1=u(1:n,:);
        end
    end
end

function u2=format2(u0,lamda,m,n,text,epsilon)
    %--------判断m,n输入是否符合标准---------
    if n<=2|m<=2
        fprintf('invalid number')%不符合
    else
        %---------判断边界类型------------
        if strcmp(text,'cyclical')
            u=zeros(n,m+3);
            u(1,2:m+2)=u0;
            u(1,1)=u(1,m+2);
            u(1,m+3)=u(1,2);
            for i=2:n
                u(i,:)=iterate(u(i-1,:),lamda,epsilon,text);
            end
            u2=u(1:n,2:m+2);
        elseif strcmp(text,'rigid')
            u=zeros(n,m+1);
            u(1,:)=u0;
            u(:,1)=0;
            u(:,m+1)=0;
            for i=2:n
                u(i,:)=iterate(u(i-1,:),lamda,epsilon,text);
            end
            u2=u;
        end
    end
end

function u3=format3(u0,lamda,m,n,text)
    %--------判断m,n输入是否符合标准---------
    if n<=2|m<=2
        fprintf('invalid number')%不符合
    else
        %判断边界类型
        if strcmp(text,'cyclical')
            %-----------前差起步-------------
            u=zeros(n,m+3);
            u(1,2:m+2)=u0;
            u(1,1)=u(1,m+2);
            u(1,m+3)=u(1,2);
            for j=2:m+2
                u(2,j)=u(1,j)-(lamda/2)*u(1,j)*(u(1,j+1)-u(1,j-1));
            end
            u(2,1)=u(2,m+2);
            u(2,m+3)=u(2,2);
            %----------时间中央差分-----------
            for i=2:n-1
                for j=2:m+2
                    u(i+1,j)=u(i-1,j)-lamda*u(i,j)*(u(i,j+1)-u(i,j-1));
                end
                u(i+1,1)=u(i+1,m+2);
                u(i+1,m+3)=u(i+1,2);
            end
            u3=u(1:n,2:m+2);
        elseif strcmp(text,'rigid')
            u=zeros(n,m+1);
            u(1,2:m+2)=u0;
            u(:,1)=0;
            u(:,m+1)=0;
            %-----------前差起步------------
            for j=2:m
                u(2,j)=u(1,j)-(lamda/2)*u(1,j)*(u(1,j+1)-u(1,j-1));
            end
            %-----------时间中央差分-----------
            for i=2:n
                for j=2:m
                    u(i+1,j)=u(i-1,j)-lamda*u(i,j)*(u(i,j+1)-u(i,j-1));
                end
            end
            u3=u(1:n,:);
        end
    end
end

%此函数用于计算数值天气预报作业5差分格式2中的迭代计算
function u=iterate(a,lamda,epsilon,text)
    u2=0;
    n=length(a);
    u=zeros(1,n);
    if strcmp(text,'cyclical') 
        for i=2:n-1
            u(i)=a(i)-(lamda/6)*(a(i+1)+a(i)+a(i-1))*(a(i+1)-a(i-1));
        end
        u(1)=u(n-1);
        u(n)=u(2);
        while max(abs(u-u2))>epsilon
            u_bar=(u+a)/2;
            u2=u;
            for i=2:n-1
                u(i)=a(i)-(lamda/6)*(u_bar(i+1)+u_bar(i)+u_bar(i-1))*(u_bar(i+1)-u_bar(i-1));
            end
            u(1)=u(n-1);
            u(n)=u(2);
        end
    elseif strcmp(text,'rigid')
        for i=2:n-1
            u(i)=a(i)-(lamda/6)*(a(i+1)+a(i)+a(i-1))*(a(i+1)-a(i-1));
        end
        u(1)=0;
        u(n)=0;
        while max(abs(u-u2))>epsilon
            u_bar=(u+a)/2;
            u2=u;
            for i=2:n-1
                u(i)=a(i)-(lamda/6)*(u_bar(i+1)+u_bar(i)+u_bar(i-1))*(u_bar(i+1)-u_bar(i-1));
            end
            u(1)=0;
            u(n)=0;
        end
    end
end