function [MList1,data0,MList2,data1,data2] = LoadMTxtList2C(filename)
% by Xiaoyu Shi @ Bo Huang Lab, UCSF
MListData = importdata(filename);
data0 = MListData.data;
data1 = data0(data0(:,1)==1,:);
data2 = data0(data0(:,1)==2,:);
colheaders = genvarname(MListData.colheaders);
colheaders{1} = 'C';
for i = 1:length(colheaders)
    MList1.(colheaders{i}) = data1(:, i);
    MList2.(colheaders{i}) = data2(:, i);
end