function [aveR,stdR,Rmin,Rmax]=AveRadAB(rawdata_ref0,n_frame)

% output in pixel

clc
addpath D:\Xiaoyu\MatlabAnalysis\resource

R=[];

for i=1:1:n_frame
    i 
   
	xc =rawdata_ref0(rawdata_ref0(:,13)==i,4);
	yc =rawdata_ref0(rawdata_ref0(:,13)==i,5);
     
%     % Get optimized radius
%      [x0,y0,Re]=circfit(xc,yc);

% Get optimized radius: fit to ellips, radius = perim/2/pi;
    XY = [xc yc];
    A = EllipseFitByTaubin(XY); 
    [G] = AtoG(A); % phi=G(5);a=G(3);b=G(4);x0=G(1);y0=G(2);
    perim = ellipsePerimeter(G');
    Re=perim/2/pi;

    d1=[num2str(Re),'   nm.'];
    i1=num2str(i)
    fprintf('The radius of fame %s\n is :  %s\n\n',i1,d1)
    
    R = [R Re];

end


[Rmin,Imin] = min(R);
[Rmax,Imax] = max(R);


aveR = mean(R);
stdR = std(R);

% %-------------write---------------
% 
% filename = ['D:\Xiaoyu\MatlabAnalysis\3dalignment\Diameter\DiameterAB_', file,'.txt'];  
% fileID = fopen(filename,'wt');
% fprintf(fileID,'The average diameter of %d frames is :  %d +- %d nm.\n',n_frame,round(aveD),round(stdD));
% fprintf(fileID,'The minimum diameter is frame NO. %d :  %d nm.\n',Imin,round(Dmin));
% fprintf(fileID,'The maxamum diameter is frame NO. %d :  %d nm.\n\n',Imax,round(Dmax));
% fprintf(fileID,'The pixel size is:  %d nm.\n\n',p);
% fprintf(fileID,'diameter\n');
% fprintf(fileID,'%f\n',D);
% 
% 
% fclose(fileID);
% 
% fprintf('The average diameter of %d frames is :  %d +- %d nm.\n',n_frame,round(aveD),round(stdD));
% fprintf('The minimum diameter is frame NO. %d :  %d nm.\n',Imin,round(Dmin));
% fprintf('The minimum diameter is frame NO. %d :  %d nm.\n',Imax,round(Dmax));