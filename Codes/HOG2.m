%% HOG2 (faire boucle pour trouver le meilleur '360')
function [database2, labels, testbase2, testlabels]=...
    HOG2 (database, labels, testbase, testlabels)

tic;
% database2=zeros();
output=zeros(12,2);k=1;
c=200;
%  for c= 200:25:500
     HOGi = extractHOGFeatures(database{1},'CellSize',[c c]);
     database2=zeros(size(labels,2),size(HOGi,2));
     for i = 1:size(labels,2) 
         im=database{i};
         HOGi = extractHOGFeatures(im,'CellSize',[c c]);
         database2(i,:)=reshape(HOGi,[1,size(HOGi,2)]);
         % disp(i);
 
     end
%      output(k,1)= c;
%      output(k,2)= overlap_v2(database2,labels);
%      disp(k); % Compteur
%      k=k+1;
%  end
%  disp(output)
save(['HOG2 ' num2str(c)],'database2','labels');

load(['HOG2 ' num2str(c)]);

output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);
disp(['HOG2 data : ', num2str(toc),' secondes']);

% ------------------------------ TEST ----------------------------------
% testbase2=zeros();
tic;
for i = 1:size(testlabels,2) 
    im=testbase{i};
    HOG1i = extractHOGFeatures(im,'CellSize',[c c]);
    testbase2(i,:)=reshape(HOG1i,1,size(HOG1i,1)*size(HOG1i,2));
%     disp(i);
end
save(['HOG22 ' num2str(c)],'testbase2','testlabels');

load(['HOG22 ' num2str(c)]);

disp(['HOG2 train : ', num2str(toc),' secondes']);