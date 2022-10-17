function [result] = SVM (database,labels,testbase,testlabels)
%% ============================= SVM Train =============================
% lance le chrono et définit les variables
tic; nblabels=max(labels); SVMModel=cell(nblabels,1); err=zeros(7,7);

% decoupe en 1/3, 2/3
Train=database(1:round(size(labels,2)*2/3),:);
Valid=database(round(size(labels,2)*2/3+1):round(size(labels,2)),:);
TrainLabels=labels(:,1:round(size(labels,2)*2/3));
ValidLabels=labels(:,round(size(labels,2)*2/3+1):round(size(labels,2)));

Scores=zeros(size(Valid,1),nblabels); G=0;
% On test le SVM pour différentes valeurs de C et de gamma
for C=0:6
%     for G=0:6
        c=10^(C); %g=10^(G);
%         disp(['Recherche meilleurs C et gamma : ',...
%             num2str(round((G+1+(C)*7)/49*10000)/100),' %'])
        
        % Pour avoir la stratégie "one against all", nous avons fait un SVM
        % par classe. Nous utilisons la fonction fitcsvm, avec un noyau
        % gaussien (rbf).
        for i=0:nblabels %attention a la classe 0
            SVMModel{i+1}=fitcsvm(Train,TrainLabels==i,...
                'KernelFunction','rbf','BoxConstraint',c,...
                'ClassNames',[false true],'KernelScale','auto');
        end
        
        % On obtient les proba d'appartennace à chaque classe d'une image
        for i=0:nblabels
           [~,score]=predict(SVMModel{i+1},Valid) ;
           Scores(:,i+1)=score(:,2); %stock toutes les proba dans Scores
        end
        % le label predict = # colonne avec le plus grand score
        [~,maxScore]=max(Scores,[],2); 
        PredictLabel=maxScore.';
        PredictLabel=PredictLabel-1;
        
        % On stock les taux d'erreur pour tous les C et gamma dans err
%         err(C+1,G+1)=mean(PredictLabel ~= ValidLabels);
%     end
end

% Prends la plus faible erreur
% Renvoi les C et gamma (lig,col) correspondant 
[~,I]=min(err(:));  %err
[lig,col]=ind2sub(size(err),I);
disp(['Boxconstraint : ', num2str(lig)]);
%disp(['KernelScale ', num2str(col)]);%disp(err)

% Affiche le temps d'entrainement
time=toc; disp(['Train time : ', num2str(time),' secondes'])

% % Plot3D de l'evolution en fonction de C et gamma
% surf(err)
% xlabel('KernelScale (log)')
% ylabel('BoxConstraint (log)')
% pause

%% =============================== Test SVM ==============================
% lance le chrono et définit les variables (reprend le meilleur C et gamma)
tic; Scores=zeros(size(testbase,1),nblabels); c=10^(lig);g=10^(col);

% On entraine nos 10 SVM avec C et gamma fixé
for i=0:nblabels %attention a la classe 0
    SVMModel{i+1}=fitcsvm(database,labels==i,...
        'KernelFunction','rbf','BoxConstraint',c,...
        'ClassNames',[false true],'KernelScale','auto');
end

% On obtient les proba d'appartennace à chaque classe d'une image
for i=0:nblabels
   [~,score]=predict(SVMModel{i+1},testbase) ;
   Scores(:,i+1)=score(:,2); %stock toutes les proba dans Scores
end
% le label predict = # colonne avec le plus grand score
[~,maxScore]=max(Scores,[],2);
result(:,2)=maxScore.';

% Dans la première colones, on stock le VRAI label
% Dans la colonne suivante, on stock le label predict avec le SVM
result(:,1)=testlabels; 
result(:,2)=result(:,2)-1;

% Affiche le temps d'entrainement et la memoire utilisee
time=toc; disp(['Test time : ', num2str(time),' secondes']); memory