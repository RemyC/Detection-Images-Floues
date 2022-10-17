function Resultats(result,NbExp,classifier,method)
%% ------------------- Affiche les resultats obtenus ---------------------
% Affiche le taux d'erreur
a=mean(result(:,1)~=result(:,2)); disp(['Erreur : ', num2str(a*100), ' %'])
a=sum(result(:,1)~=result(:,2)); disp(['Erreur : ', num2str(a*100), ' %'])

% Affiche la matrice de confusion
[C,~]=confusionmat(result(:,1),result(:,2));
disp('Confusion matrix :    (colonne:predict, ligne:reel)'), disp(C)

% % Affiche des exemples d'images mal classifiées
% repertoire = [pwd, '\CERTH\EvaluationSet'];
% Erreur=result(:,1)~=result(:,2); %colonne binaire, 1 si erreur, 0 sinon
% NbErr=sum(Erreur, 1);           % Compte le nombre total d'erreur
% IndErr=find(1==Erreur);         % Renvoie l'indice des images mal classees
% NbExp=min(NbErr,NbExp);         % Evite les erreurs si NbExp>NbErr ...
% ErreurChoisi=randperm(NbErr,NbExp); % Selection des indices (sans doubles)    
% 
% % Va afficher NbExp images
% for j=1:NbExp
%     
%     % Va recuperer le chemin des images selectionnees pour etre affichees
%     i=IndErr(ErreurChoisi(j));
%     disp(i)
%     if i>249
%         dossier = '\1\';
%         a=i-249;
%         disp(a);
%         if a>999
%             fichier = ['0', num2str(a), '.jpg'];
%         elseif a >99
%             fichier = ['00', num2str(a), '.jpg'];
%         elseif a >9
%             fichier = ['000', num2str(a), '.jpg'];
%         else
%             fichier = ['0000', num2str(a), '.jpg'];
%         end
%     else
%         dossier ='\0\';
%         if i>999
%             fichier = ['0', num2str(i), '.jpg'];
%         elseif i >99
%             fichier = ['00', num2str(i), '.jpg'];
%         elseif i >9
%             fichier = ['000', num2str(i), '.jpg'];
%         else
%             fichier = ['0000', num2str(a), '.jpg'];
%         end
%     end
%     chemin =[repertoire dossier fichier];
%     cimg=imread(chemin);
%     
%     % Affiche l'image avec la prevision et la vrai label
%     imshow(cimg,'border','loose','InitialMagnification','fit')
%     Reel=['Reel (image) : ' num2str(result(i,1))];
%     Prev=['Prevision : ' num2str(result(i,2))];
%     title({Prev Reel})
%     pause(0.25)
% 
%     % enregistre l'image en .png
%     name=([classifier,method,num2str(j),'-R',num2str(result(i,1))...
%         ,'-P',num2str(result(i,2)),'.png']);
%     imwrite(cimg,name)
% end

close