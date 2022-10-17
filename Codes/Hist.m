%% Hist
function [database2, labels, testbase2, testlabels]=...
    Hist (database, labels, testbase, testlabels)

tic;
database2=zeros(size(labels,2),256);
for i=1:size(labels,2)
    [database2(i,:),~]=histcounts(double(database{i}),256);
    a=imread('\CERTH\TrainingSet\0\00010.jpg');
    a=rgb2gray(a);
    imhist(a)
end
save('Hist','database2','labels');

load('Hist');

output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);
disp(['Hist data : ', num2str(toc),' secondes']);

% ----------------------------- Test ----------------------------------

tic;
testbase2=zeros(size(testlabels,2),256);
for i=1:size(testlabels,2)
    [testbase2(i,:),~]=histcounts(double(testbase{i}),256);
%     disp(i)
end
save('Hist2','testbase2','testlabels');

load('Hist2');
disp(['Hist2 test : ', num2str(toc),' secondes']);

