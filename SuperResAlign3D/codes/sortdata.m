function   [n0,n] = sortdata(file)
% remove empty frames

% file = 'filename'
% p = pixel size
% n0 = number of molecules in the raw data

addpath D:\Xiaoyu\MatlabAnalysis\resource
inname = [file,'.txt'];
rawlist = importdata(inname);
rawdata0 = rawlist.data;


%------------delete negative I, bg, and reorder with frame--------
rawdata = sortrows(rawdata0,13);

rawdata(rawdata(:,11)<0,:)=[]; 
rawdata(rawdata(:,12)<0,:)=[]; 

size0 = size(rawdata);
n0 = size0(1)

%--------make frame number consecutive --------
frame = rawdata(:,13);
frame1 = frame(1);
frame(frame==frame1) = 1;
frame1 = 1;

    for i=2:n0
        
        if frame(i)>frame1
            frame1 = frame1+1;
            frame(frame==frame(i))=frame1;
        end

    end

rawdata(:,13)= frame;
nof0 = frame(n0);
frame = [];
%------------------------------------------------

%-------remove empty frames----------------------
    for q=1:nof0
        t = sum(rawdata(:,13) == q);
        if (t~=0)&&(t<200)
            rawdata(rawdata(:,13)==q,:)=[]; 
        end
    end
    
newdata = sortrows(rawdata,13);
size1 = size(newdata);
n = size1(1);

%----------------------------------------------

%--------make frame number consecutive --------
frame = newdata(:,13);
frame1 = frame(1);
frame(frame==frame1) = 1;
frame1 = 1;

    for i=2:n
        
        if frame(i)>frame1
            frame1 = frame1+1;
            frame(frame==frame(i))=frame1;
        end

    end

newdata(:,13)= frame;
frame_max = max(frame)

%-----------------------write----------------------
filename = [file,'_s','.txt'];   %s fr sorted
f = fopen(filename,'wt');
  
%Write the header:
    cas = ['Cas',num2str(n)];
    header = {cas 'X' 'Y' 'Xc' 'Yc' 'Height' 'Area' 'Width' 'Phi' 'Ax' 'BG' 'I' 'Frame' 'Length' 'Link' 'Valid' 'Z' 'Zc'};
    fprintf(f,'%s\t',header{1:end-1});
    fprintf(f,'%s\n',header{end});

%Write the data:
    for m = 1:n
        fprintf(f,'%g\t',newdata(m,1:end-1));
        fprintf(f,'%g\n',newdata(m,end));
    end

fclose(f);