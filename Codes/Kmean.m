%% Kmean
function [result]=...
    Kmean(database,labels, testbase, testlabels)

tic;
[idx,C]=kmeans(database,2,'display', 'iter',...
    'Start','cluster','Replicates',5);
idx=idx-1;
flg=0;
errTrain=mean(idx ~= labels.'); % erreur sur le lot d'entrainement /!\
if errTrain > 0.5
    errTrain=1-errTrain;
    flg=1;
end
% disp(['Train error : ', num2str(errTrain*100), ' %']);
disp(['Kmean train : ', num2str(toc),' secondes']);


% -------------------- = Test = --------------
tic;
result=zeros(size(testlabels,2),2);
D=zeros(1,2);
for i = 1:size(testlabels,2)
    for k=1:2           %nb de cluster (parametre)
        D(k)=sqrt(sum((testbase(i)-C(k)).^ 2));
    end
    if D(1)>D(2)
        result(i,2)=1-flg;
    else result(i,2)=0+flg;
    end
    result(i,1)=testlabels(i);
end
disp(['Kmean test : ', num2str(toc),' secondes']);
memory;
