function [database_ACP,labels, testbase_ACP, testlabels,Mix]=...
    ChooseFeature(database, labels, testbase, testlabels,method)

if strcmp(method,'Hough')
    [database,labels, testbase, testlabels] = Hough(database, labels, testbase, testlabels);
elseif strcmp(method,'FFT')
    [database,labels, testbase, testlabels] = FFT(database, labels, testbase, testlabels);
elseif strcmp(method,'HOG')
    [database,labels, testbase, testlabels] = HOG(database, labels, testbase, testlabels);
elseif strcmp(method,'HOG2')
    [database,labels, testbase, testlabels] = HOG2(database, labels, testbase, testlabels);
elseif strcmp(method,'Hist')
    [database,labels, testbase, testlabels] = Hist(database, labels, testbase, testlabels);
elseif strcmp(method,'Conv')
    [database,labels, testbase, testlabels] = Conv(database, labels, testbase, testlabels);
elseif strcmp(method,'WH')
    [database,labels, testbase, testlabels] = WH(database, labels, testbase, testlabels);

else
    % si le nom du classifieur n'est correct alors arret.
    disp('Veuillez bien écrire la méthode !'),return
end

%% -------------- ACP ---------------------------------------
tic;
disp(['Nb features avant ACP = ', num2str(size(database,2))]);
seuil=90;
[V, ~] = acp(database, seuil);
[database_ACP] = projection_acp(database, V);
[testbase_ACP] = projection_acp(testbase, V);
overlap=overlap_v2(database_ACP,labels);
disp(['Overlap apres ACP : ', num2str(overlap)]);
disp(['Nb features apres ACP = ', num2str(size(database_ACP,2))]);
disp(['ACP : ', num2str(toc),' secondes']);

% % ------------- Melange les donnees d'entrainement ---------
Mix=randperm(size(labels,2));
database_ACP=database_ACP(Mix,:);
labels=labels(Mix); 