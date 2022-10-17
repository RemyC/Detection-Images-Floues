%% HOG ( boucle pour trouver les meilleurs paramètres )
function [database2, labels, testbase2, testlabels]=...
    HOG (database, labels, testbase, testlabels)

tic;k=1; output=[];A=400;B=200;

% for A = 150:25:250
%     for B= 350:25:450
        database2=zeros(size(labels,2) ,A+B); 
        for i = 1:size(labels,2) 
            [Gx,Gy] = imgradientxy(database{i});
            Gmag=sqrt(Gx.^2+Gy.^2);
            Gdir=atan(Gy./Gx);
            database2(i,:)=[histcounts(Gmag,A) histcounts(Gdir,B)];
%             disp(i);
        end
        save(['HOG ' num2str(A) ' par ' num2str(B)],'database2','labels');
%         output(k,1)= A;
%         output(k,2)= B;
%         output(k,3)= overlap_v2(database2,labels);
%         disp(k); % Compteur
%         k=k+1;
%     end
% end
disp(output);


load(['HOG ' num2str(A) ' par ' num2str(B)]);
output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);
disp(['HOG data : ', num2str(toc),' secondes']);

% ------------------------- Test -----------------------------------
tic;k=1;

testbase2=zeros(size(testlabels,2) ,A+B); 
for i = 1:size(testlabels,2) 
    [Gx,Gy] = imgradientxy(testbase{i});
    Gmag=sqrt(Gx.^2+Gy.^2);
    Gdir=atan(Gy./Gx);
    testbase2(i,:)=[histcounts(Gmag,A) histcounts(Gdir,B)];
%     disp(i);
end
save(['HOGt ' num2str(A) ' par ' num2str(B)],'testbase2','testlabels');

load(['HOGt ' num2str(A) ' par ' num2str(B)]);
disp(['HOG test : ', num2str(toc),' secondes']);