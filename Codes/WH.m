%% Haar ( boucle pour trouver le meilleur paramètre )
function [database2, labels, testbase2, testlabels]=...
    WH(database, labels, testbase, testlabels)

tic;
database2=zeros(size(labels,2) ,256*3);
for i = 1:size(labels,2) 
    cimg=database{i};
    [c,s] = wavedec2(cimg,2,'haar');
    [H1,V1,D1] = detcoef2('all',c,s,1);
    
    V1img = wcodemat(V1,255,'mat',1);
    H1img = wcodemat(H1,255,'mat',1);
    D1img = wcodemat(D1,255,'mat',1);
    
    [Hist1,~]=histcounts(double(H1img),256);
    [Hist2,~]=histcounts(double(V1img),256);
    [Hist3,~]=histcounts(double(D1img),256);
    database2(i,:)=[Hist1 Hist2 Hist3];
    
%     disp(['WH train, ', num2str(round(i/size(labels,2) *100)), ' % images traitées']);
end
% database2=WH(:,300:600); % ne prend que la moitié des features
save('WH','database2','labels');

load('WH'); 

output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);
disp(['WH data : ', num2str(toc),' secondes']);
%------------------------ test ---------------------------

tic;
testbase2=zeros(size(testlabels,2) ,256*3);
for i = 1:size(testlabels,2) 
    cimg=testbase{i};
    [c,s] = wavedec2(cimg,2,'haar');
    [H1,V1,D1] = detcoef2('all',c,s,1);
    
    V1img = wcodemat(V1,255,'mat',1);
    H1img = wcodemat(H1,255,'mat',1);
    D1img = wcodemat(D1,255,'mat',1);
    
    [Hist1,~]=histcounts(double(H1img),256);
    [Hist2,~]=histcounts(double(V1img),256);
    [Hist3,~]=histcounts(double(D1img),256);
    testbase2(i,:)=[Hist1 Hist2 Hist3];
    
%     disp(['WH train, ', num2str(round(i/size(testlabels,2) *100)), ' % images traitées']);
end
% database2=WH(:,300:600); % ne prend que la moitié des features
save('WH','testbase2','testlabels');

load('WH'); 
disp(['WH data : ', num2str(toc),' secondes']);