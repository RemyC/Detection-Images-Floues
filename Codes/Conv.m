%% Conv ( boucle pour trouver les meilleurs paramètres )
function [database2, labels, testbase2, testlabels]=...
    Conv (database, labels, testbase, testlabels)

tic; k=1;i=0;
database2=zeros(size(labels,2),796); output=zeros(10,2);

% for i=0:0.1:1
for l=1:size(labels,2)
    cimg=double(database{l});
    filtre=fspecial('laplacian',i);
    cimg2=conv2(cimg,filtre,'same');
    cimg3=cimg2(3:598,3:798);
    if l == 111
        imwrite (cimg3,[num2str(l) '.jpg']);
    end
    database2(l,:)=var(cimg3);    
%     disp(l);
end
% output(k,1)= i;
% output(k,2)= overlap_v2(database2,labels);
% disp(k); % Compteur
% k=k+1;
% end
output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);

save('Conv','database2','labels');

load('Conv');
disp(['Conv data : ', num2str(toc),' secondes']);



 % ----------------------- TEST -------------------------------------
 
tic; 
testbase2=zeros(size(testlabels,2),796);

for l=1:size(testlabels,2)
    cimg=double(testbase{l});
    filtre=fspecial('laplacian',1);
    cimg2=conv2(cimg,filtre,'same');
    cimg3=cimg2(3:598,3:798);
    testbase2(l,:)=var(cimg3);
%     disp(l);
end
save('Conv2','testbase2','testlabels');

load('Conv2');
disp(['Conv test : ', num2str(toc),' secondes']);