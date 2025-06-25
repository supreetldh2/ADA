%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers
% To run DA: [Best_score,Best_pos,cg_curve]=DA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

function [Best_score,Best_pos,cg_curve]=ADA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
max_pop_size=SearchAgents_no;
min_pop_size=10;
display('DA is optimizing your problem');
cg_curve=zeros(1,Max_iteration);

if size(ub,2)==1
    ub=ones(1,dim)*ub;
    lb=ones(1,dim)*lb;
end

%The initial radius of gragonflies' neighbourhoods
r=(ub-lb)/10;
Delta_max=(ub-lb)/10;

Food_fitness=inf;
Food_pos=zeros(dim,1);

Enemy_fitness=-inf;
Enemy_pos=zeros(dim,1);

X=initializationDA(SearchAgents_no,dim,ub,lb);
Fitness=zeros(1,SearchAgents_no);

DeltaX=initializationDA(SearchAgents_no,dim,ub,lb);


for iter=1:Max_iteration
    
    r=(ub-lb)/4+((ub-lb)*(iter/Max_iteration)*2);
    
    w=0.9-iter*((0.9-0.4)/Max_iteration);
    %     %exponential decreasing value of a
    a_max=0.05;
    a_min=0;
    my_c= a_min+ (a_max-a_min)* exp(-iter/(Max_iteration/10));
    %       my_c
    %       pause
    %my_c=0.1-iter*((0.1-0)/(Max_iteration/2));
    if my_c<0
        my_c=0;
    end
    
    s=2*rand*my_c; % Seperation weight
    a=2*rand*my_c; % Alignment weight
    c=2*rand*my_c; % Cohesion weight
    f=2*rand;      % Food attraction weight
    e=my_c;        % Enemy distraction weight
    
    for i=1:SearchAgents_no %Calculate all the objective values first
        Fitness(1,i)=fobj(X(:,i)');
        if Fitness(1,i)<Food_fitness
            Food_fitness=Fitness(1,i);
            Food_pos=X(:,i);
        end
        
        if Fitness(1,i)>Enemy_fitness
            if all(X(:,i)<ub') && all( X(:,i)>lb')
                Enemy_fitness=Fitness(1,i);
                Enemy_pos=X(:,i);
            end
        end
    end
%     aaa=size(Food_pos)
%     pause
    if iter<Max_iteration/2
        for i=1:SearchAgents_no
            
            index=0;
            neighbours_no=0;
            
            clear Neighbours_DeltaX
            clear Neighbours_X
            %find the neighbouring solutions
            for j=1:SearchAgents_no
                Dist2Enemy=distance(X(:,i),X(:,j));
                if (all(Dist2Enemy<=r) && all(Dist2Enemy~=0))
                    index=index+1;
                    neighbours_no=neighbours_no+1;
                    Neighbours_DeltaX(:,index)=DeltaX(:,j);
                    Neighbours_X(:,index)=X(:,j);
                end
            end
            
            % Seperation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Eq. (3.1)
            S=zeros(dim,1);
            if neighbours_no>1
                for k=1:neighbours_no
                    S=S+(Neighbours_X(:,k)-X(:,i));
                end
                S=-S;
            else
                S=zeros(dim,1);
            end
            
            % Alignment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Eq. (3.2)
            if neighbours_no>1
                A=(sum(Neighbours_DeltaX')')/neighbours_no;
            else
                A=DeltaX(:,i);
            end
            
            % Cohesion%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Eq. (3.3)
            if neighbours_no>1
                C_temp=(sum(Neighbours_X')')/neighbours_no;
            else
                C_temp=X(:,i);
            end
            
            C=C_temp-X(:,i);
            
            % Attraction to food%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Eq. (3.4)
            Dist2Food=distance(X(:,i),Food_pos(:,1));
            if all(Dist2Food<=r)
                F=Food_pos-X(:,i);
            else
                F=0;
            end
            
            % Distraction from enemy%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Eq. (3.5)
            Dist2Enemy=distance(X(:,i),Enemy_pos(:,1));
            if all(Dist2Enemy<=r)
                Enemy=Enemy_pos+X(:,i);
            else
                Enemy=zeros(dim,1);
            end
            
            for tt=1:dim
                if X(tt,i)>ub(tt)
                    X(tt,i)=lb(tt);
                    DeltaX(tt,i)=rand;
                end
                if X(tt,i)<lb(tt)
                    X(tt,i)=ub(tt);
                    DeltaX(tt,i)=rand;
                end
            end
            
            if any(Dist2Food>r)
                if neighbours_no>1
                    %                 w
                    %                 pause
                    for j=1:dim
                        DeltaX(j,i)=w*DeltaX(j,i)+rand*A(j,1)+rand*C(j,1)+rand*S(j,1);
                        if DeltaX(j,i)>Delta_max(j)
                            DeltaX(j,i)=Delta_max(j);
                        end
                        if DeltaX(j,i)<-Delta_max(j)
                            DeltaX(j,i)=-Delta_max(j);
                        end
                        X(j,i)=X(j,i)+DeltaX(j,i);
                    end
                else
                    % Eq. (3.8)
                    X(:,i)=X(:,i)+Levy(dim)'.*X(:,i);
                    DeltaX(:,i)=0;
                end
            else
                for j=1:dim
                    %                 DeltaX
                    %                 pause
                    % Eq. (3.6)
                    DeltaX(j,i)=(a*A(j,1)+c*C(j,1)+s*S(j,1))+((f*F(j,1)+e*Enemy(j,1))/2) + w*DeltaX(j,i);
                    
                    if DeltaX(j,i)>Delta_max(j)
                        DeltaX(j,i)=Delta_max(j);
                    end
                    if DeltaX(j,i)<-Delta_max(j)
                        DeltaX(j,i)=-Delta_max(j);
                    end
                    X(j,i)=X(j,i)+DeltaX(j,i);
                end
            end
        end
        %         aa=size(DeltaX)
        %         bb=size(X)
        %         cc=size(Food_pos)
        % pause
    else
%                 aa=size(DeltaX)
%                 bb=size(X)
%                 cc=size(Food_pos)
%          pause
        beta=1.5;
        sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
        for j=1:SearchAgents_no
            a=2-j*((2)/Max_iteration); % a decreases linearly fron 2 to 0
            s=X(:,j);
%         aa=size(s)
%          bb=size(X)
%         cc=size(Food_pos)
%         pause
            u=randn(size(s))*sigma;
            v=randn(size(s));
            step=u./abs(v).^(1/beta);
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            A1=2*a*r1-a; % Equation (3.3)
            C1=2*r2;% Equation (3.4)
            D_alpha=abs(C1*Food_pos-X(:,j)); % Equation (3.5)-part 1
            X1=Food_pos-A1*D_alpha;% Equation (3.6)-part 1
            r1=rand();
            r2=rand();
            A2=2*a*r1-a; % Equation (3.3)
            C2=2*r2; % Equation (3.4)
            D_beta=abs(C2*Food_pos-X(:,j)); % Equation (3.5)-part 2
            X2=Food_pos-A2*D_beta; % Equation (3.6)-part 2
            r1=rand();
            r2=rand();
            A3=2*a*r1-a; % Equation (3.3)
            C3=2*r2; % Equation (3.4)
            D_delta=abs(C3*Food_pos-X(:,j)); % Equation (3.5)-part 3
            X3=Food_pos-A3*D_delta; % Equation (3.5)-part 3
            X(:,j)=(X1+X2+X3)/3;% Equation (3.7)
            s=X(:,j);
            stepsize=0.01*step.*(s-Food_pos);
            s=s+stepsize.*randn(size(s));
            X(:,j)=s;
        end
    end
    
    for i=1:SearchAgents_no
        Flag4ub=X(:,i)>ub';
        Flag4lb=X(:,i)<lb';
        X(:,i)=(X(:,i).*(~(Flag4ub+Flag4lb)))+ub'.*Flag4ub+lb'.*Flag4lb;
        
    end
    Best_score=Food_fitness;
    Best_pos=Food_pos;
    %     aa=size(Best_score)
    %     bb=size(Best_pos)
    %     pause
    
    %% for resizing the population size
    plan_pop_size = round((((min_pop_size - max_pop_size) / Max_iteration) * iter) + max_pop_size);
    
    if SearchAgents_no > plan_pop_size
        reduction_ind_num = SearchAgents_no - plan_pop_size;
        if SearchAgents_no - reduction_ind_num <  min_pop_size; reduction_ind_num = SearchAgents_no - min_pop_size;end
        
        SearchAgents_no = SearchAgents_no - reduction_ind_num;
    end
    %     a
    %     c
    %     s
    %     f
    %     e
    %     w
    %     pause
    cg_curve(iter)=Best_score;
end


