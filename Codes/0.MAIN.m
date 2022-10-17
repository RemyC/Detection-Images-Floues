% PROJET
clear all; close all; clc;

method='Conv';
classifier = 'SVM';

% dbstop in Hough
% dbstop in Resultats

%% 1. Charger la base de donnée
[database, labels, testbase, testlabels]=ReadData;

%% 2. Choisir la facon d'extraire les features
% FFT, Hough, HOG, HOG2, Hist, Conv, 
% Fait aussi un ACP et mélange les données

[database,labels, testbase, testlabels,Mix] = ...
    ChooseFeature(database, labels, testbase, testlabels,method);

%% 3. Envoi le classifieur
% Kmean, Knn, SVM, All

[result] = ...
    ChooseClassifier(database, labels, testbase, testlabels, classifier);

%% 4. Resultats
% choisir le nombre d'exemple a afficher
NbExp=1;
Resultats(result,NbExp,classifier,method)
