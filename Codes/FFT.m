%% FFT ( boucle pour trouver le meilleur param�tre )
function [database2, labels, testbase2, testlabels]=...
    FFT(database, labels, testbase, testlabels)
tic;
FFT=zeros(size(labels,2) ,600);
for i = 1:size(labels,2) 
     imwrite(fftshift(fft2(database{i})),[num2str(i),'.jpg']);
    FFT(i,:) = sum(log(abs(fftshift(fft2(database{i})))),2);
%     disp(['FFT train, ', num2str(round(i/size(labels,2) *100)), ' % images trait�es']);
end
database2=FFT(:,300:600); % ne prend que la moiti� des features
save('FFT','database2','labels');

load('FFT'); 

output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);
disp(['FFT data : ', num2str(toc),' secondes']);
%------------------------ test ---------------------------
tic;
FFT2=zeros(size(testlabels,2),600);
for i = 1:size(testlabels,2) 
    FFT2(i,:) = sum(log(abs(fftshift(fft2(testbase{i})))),2);
%     disp(['FFT test, ', num2str(round(i/size(testlabels,2)*100)), ' % images trait�es']);
end
testbase2=FFT2(:,300:600); % ne prend que la moiti� des features
save('FFT2','testbase2','testlabels');

load('FFT2');
disp(['FFT test : ', num2str(toc),' secondes']);