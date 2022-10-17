function [result]=...
    ChooseClassifier(database, labels, testbase, testlabels, classifier)

if strcmp(classifier,'All')
    [result1] = Kmean(database,labels, testbase, testlabels);
    [result2] = Knn(database,labels, testbase, testlabels);
    [result3] = SVM(database,labels, testbase, testlabels);
    
    result(:,2)=mode([result1 result2 result3],2);
    result(:,1)=result1(:,1);
    
elseif strcmp(classifier,'Kmean')
    [result] = Kmean(database,labels, testbase, testlabels);
elseif strcmp(classifier,'Knn')
    [result] = Knn(database,labels, testbase, testlabels);
elseif strcmp(classifier,'SVM')
    [result] = SVM(database,labels, testbase, testlabels);
else
    % si le nom du classifieur n'est correct alors arret.
    disp('Veuillez bien écrire la méthode !'),return
end