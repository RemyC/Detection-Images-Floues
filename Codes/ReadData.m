%% CRETAION DE LA BASE DE DONNEES
function[database, labels, testbase, testlabels]=ReadData
tic;

figext='.jpg';
rootpath = [pwd, '\CERTH\TrainingSet'];

% % Récupérer la listes des repertoires des classes
% structres = dir(rootpath); 
% cellres = struct2cell(structres);
% [foldernames] = cellres(1,3:end);
% nb_folders = length(foldernames);
% ind = 0; 
% database = {1985};
% labels = [1,1985];
% 
% for fn = 1:1:length(foldernames)
%     % récupérer la listes des noms des fichiers d'images qui sont danc le
%     % repertoire courrant
%     fldname = foldernames{fn};
%     fldpath = [rootpath '\' fldname];
%     if isdir(fldpath)        
%         structres = dir(fldpath); 
%         cellres = struct2cell(structres);
%         [filenames] = cellres(1,3:end);
%         for fs = 1:1:length(filenames);
%             fname = filenames{fs};
%             ind = ind + 1;
%             figpath = [fldpath '\' fname];
%             cimg = imread(figpath); 
%             cimg = rgb2gray(cimg); % convertit en gris
%             cimg=imresize(cimg,[600 800]); % Reduit la taille de l'image
%             % imshow(cimg)
%             % Ajouter l'etiquette correspondante dans la liste des
%             % étiquette
%             labels(ind) = str2double(fldname);
%             database {ind}= cimg;
%             disp(ind);
%         end
%     end
% end
% save('Training','database', 'labels');

load ('Training');
% disp (['Données chargées en : ', num2str(round(toc, 2)), ' secondes !'])

%========================================= Testing ======================
tic;rootpath = [pwd, '\CERTH\EvaluationSet'];

% Récupérer la listes des repertoires des classes
structres = dir(rootpath); 
cellres = struct2cell(structres);
[foldernames] = cellres(1,3:end);
nb_folders = length(foldernames);
% database = zeros(nb_ex_class*10,100);
% labels = zeros(1,nb_ex_class*10);
ind = 0; 
testbase = {495};
testlabels = [1,495];
% 
% for fn = 1:1:length(foldernames)
%     % récupérer la listes des noms des fichiers d'images qui sont danc le
%     % repertoire courrant
%     fldname = foldernames{fn};
%     fldpath = [rootpath '\' fldname];
%     if isdir(fldpath)        
%         structres = dir(fldpath); 
%         cellres = struct2cell(structres);
%         [filenames] = cellres(1,3:end);
%         for fs = 1:1:length(filenames);
%             fname = filenames{fs};
%             ind = ind + 1;
%             figpath = [fldpath '\' fname];
%             cimg = imread(figpath); 
%             cimg = rgb2gray(cimg); % convertit en gris
%             cimg=imresize(cimg,[600 800]); % Reduit la taille de l'image
%             % imshow(cimg)
%             % Ajouter l'etiquette correspondante dans la liste des
%             % étiquette
%             testlabels(ind) = str2double(fldname);
%             testbase {ind}= cimg;
%             disp(ind);
%         end
%     end
% end
% save('Testing','testbase', 'testlabels');

load ('Testing');
% disp (['Données chargées en : ', num2str(round(toc, 2)), ' secondes !'])
