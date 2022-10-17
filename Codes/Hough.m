function [database2, labels, testbase2, testlabels] = ...
    Hough (database, labels, testbase, testlabels)

tic; 
database2=zeros(size(labels,2),100);
testbase2=zeros(size(testlabels,2),100);
output=zeros(size(labels,2),3); k=1;


% rmax=norm(size(database{1}));
% for t = 1:10:300
%     for r = 1:100:rmax
        for i= 1:size(labels,2);
            canny=edge(database{i},'canny');
            [H,T,R]=hough(canny);
            if i == 254
                imshow(im2double(H),[],'XData',T,'YData',R,...
                      'InitialMagnification','fit');
                title(num2str(i));
                xlabel('\theta'), ylabel('\rho');
                axis on, axis normal, hold on;
                colormap(gca,hot);
                pause
            end 
            P = houghpeaks(H,100,'Threshold', 0.005*max(H(:)));
            lines=houghlines(canny,T,R,P,'FillGap',5,'MinLength',7);
            for j = 1:100
                database2(i,j)= norm(lines(j).point1 - lines(j).point2);
            end
            database2(i,:)=sort(database2(i,:),2,'descend');
        % 	s=surf(H);
        %     s.EdgeColor = 'none';
        %     title('Wesh.png');
        %     colormap(hot);
%             disp(['train : ',num2str(i)]);
        end
%       output(k,1)=t;
%       output(k,2)=r;
%         output(k,3)=overlap_v2(database2,labels);
%         k=k+1;
%     end
% end

save('Hough','database2','labels');

load('Hough'); 

output=overlap_v2(database2,labels);
disp(['Overlap avant ACP : ', num2str(output)]);
disp(['Hough data : ', num2str(toc),' secondes']);




%--------------------------- Test -------------------------------
tic;
for i= 1:size(testlabels,2);
    canny=edge(testbase{i},'canny');
    [H,T,R]=hough(canny);
    P = houghpeaks(H,100,'Threshold', 0.005*max(H(:)));
    lines=houghlines(canny,T,R,P,'FillGap',5,'MinLength',7);
    for j = 1:100
        testbase2(i,j)= norm(lines(j).point1 - lines(j).point2);
    end
    testbase2(i,:)=sort(testbase2(i,:),2,'descend');
% 	s=surf(H);
%     s.EdgeColor = 'none';
%     title('Wesh.png');
%     colormap(hot);
%     disp(['test : ',num2str(i)]);
end
save('Hough2','testbase2','testlabels');

load('Hough2');
disp(['Hough test : ', num2str(toc),' secondes']);

