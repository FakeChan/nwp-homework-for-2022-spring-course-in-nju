clc;
%Solve question #1
[a(1,1),a(1,2),a(1,3),a(1,4),a(1,5)]=mpj_grid('Polar',500,-4,8);
[a(2,1),a(2,2),a(2,3),a(2,4),a(2,5)]=mpj_grid('Polar',500,0,5);
%Solve question #2
[a(3,1),a(3,2),a(3,3),a(3,4),a(3,5)]=mpj_grid('Lambert',300,5,15);
[a(4,1),a(4,2),a(4,3),a(4,4),a(4,5)]=mpj_grid('Lambert',300,0,11);
%Solve question #3
[a(5,1),a(5,2),a(5,3),a(5,4),a(5,5)]=mpj_grid('Mercator',200,0,3);
[a(6,1),a(6,2),a(6,3),a(6,4),a(6,5)]=mpj_grid('Mercator',200,0,0);
%Refine the output method
answer(1:6,2:6)=a;
answer(1:6,1)=[1 11 2 22 3 33];
%plot the figure
[l_polar,m_polar,f_polar,le_polar]=mprojc('Polar',0:90);
[l_lambt,m_lambt,f_lambt,le_lambt]=mprojc('Lambert',0:90);
[l_merct,m_merct,f_merct,le_merct]=mprojc('Mercator',0:90);
%   Plot m-latitude curves of different map projection types
%-----------------------------------------------------------
figure(1)
p1=plot(0:90,m_polar,'b',0:90,m_lambt,'r',0:90,m_merct,'g');
ylim([0.8 2])
grid on
set(p1,'LineWidth',2)
legend('Polar','Lambert','Mercator','Location','Best')
title('m-Latitude Relations of Different Map Projection Types')
xlabel('Latitude')
ylabel('m')
hold on 
saveas(gca,'m_lat.png') 
%----------------------------
%   Plot l-latitude curves of different map projection types
%-----------------------------------------------------------
figure(2)
p1=plot(0:90,l_polar,'--b',0:90,l_lambt,'--r');
grid on
set(p1,'LineWidth',2)
legend('Polar','Lambert')
title('l-Latitude Relations of Different Map Projection Types')
xlabel('Latitude')
ylabel('l/km')
hold on 
line([0 90],[6371*3.1415926/2 0],'Color','m','LineStyle','--','LineWidth',2,'HandleVisibility','off')
hold off
saveas(gca,'l_lat.png')