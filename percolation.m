function percolation
%строит график вероятности непротекания
l=10;%длина
h=10;%высота
n=1e6;%число испытаний
n1=0;
tic;
qq=false;%замкнута или нет
r=1;
for p=0:0.05:1
  %испытания для данного p
  for q= 1:n
    x = zeros(l,h);%решетка
    y=zeros(l,h);%кластерная решетка
    b1=false;%кластер содержит элемент на первом уровне
    b2=false;%кластер содержит элемент на последнем уровне
    b=false;%протекание
    %заполнение решетки
    for i = 1:l
      for j = 1:h
        z=rand(1);
        if z<=p  
          c=1;
        else
          c=0;
        end;
        x(i,j)=c;
      end;
    end;
    w=1;
    %заполние кластерной решетки
    for i=1:l
      for j=1:h
          if x(i,j)==1
              if i~=1
                  if x(i-1,j)==1% проверка с предыдущем уровнем
                     y(i,j)=y(i-1,j);
                  else
                    y(i,j)=w;
                    w=w+1;
                  end;
              else
              y(i,j)=w;
              w=w+1;
              end;
              if j~=1 
                  if (x(i,j-1)==1)&&(y(i,j-1)~=y(i,j))% проверка с соседним элементом
                      w=w-1;
                      v1=min(y(i,j-1),y(i,j));
                      v2=max(y(i,j-1),y(i,j));
                      for j1=1:h
                        for i1=1:i
                          if y(i1,j1)==v2
                              y(i1,j1)=v1;
                          end;
                          if y(i1,j1)>v2
                             y(i1,j1)=y(i1,j1)-1;
                          end;
                        end;
                      end;
                  end;   
              end;
          end;
      end;
    end;
% % % %      %%замыкание
if qq
     for j=1:h
        if x(1,j)==1; 
            if (x(l,j)==1)&&(y(1,j)~=y(l,j))% проверка с      предыдущем уровнем
          w=w-1;
         v1=min(y(1,j),y(l,j));
         v2=max(y(1,j),y(l,j));
         for j1=1:h
           for i1=1:i
               if y(i1,j1)==v2
                 y(i1,j1)=v1;
               end;
                          if y(i1,j1)>v2
                             y(i1,j1)=y(i1,j1)-1;
                          end;
             end;
           end;
      end;
        end
    end;
end;
    %%%%%%%%%%%%%%%%%%%%
    % проверка протекания
    for j = 1 : w 
      for i = 1: l
        if y(i,1)==j
          b1=true;
          break;
        end;
      end;
      for i=1:l
        if y(i,h)==j
          b2 =true;
          break;
        end;
      end;
      if b1&&b2
        b=true;
        break;
      end;
      b1=false;
      b2=false;
    end;
    if  b == false
      n1=n1+1;
    end;
  end;
  disp(r/100);
  p1(r)=n1/n;
  r=r+1;
  n1=0;
end;
disp(toc);
p=0:0.05:1;
%r=1;
plot(p,p1);
r=1;
for p=0:0.05:1
 p2(r)=exp(-l*(power(p/(1-p),h)));
 r=r+1;
end;
p=0:0.05:1;
plot(p,p2);
hold on
fprintf(1,'{');
for i=1:r-1 
fprintf(1,'{%5.4f,%5.4f},',0.001*(i-1),p1(i));
end
fprintf(1,'},');
fprintf(1,'{');
for i=1:r-1 
fprintf(1,'{%5.4f,%5.4f},',0.001*(i-1),p2(i));
end
fprintf(1,'},');

%plot(p,p3,'LineWidth',3,'color','g');
end

