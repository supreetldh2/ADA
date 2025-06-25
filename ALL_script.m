function[bDA,wDA,mDA,sDA,rDA,cDA,bDE,wDE,mDE,sDE,rDE,cDE,bFA,wFA,mFA,sFA,rFA,cFA,bBA,wBA,mBA,sBA,cBA,rBA,bFPA,wFPA,mFPA,sFPA,cFPA,rFPA,bGWO,wGWO,mGWO,sGWO,cGWO,rGWO,bSSA,wSSA,mSSA,sSSA,rSSA,cSSA,bASSA,wASSA,mASSA,sASSA,rASSA,cASSA]=ALL_script
% [bFPA,wFPA,mFPA,sFPA,cFPA,rFPA]=ALL_script
n=1;%Number of runs
PopSize=50;
Iterations=10;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%FITNESS FUNCTION DETAILS%%
    Function_name='F1'
%      hold on
%       title('Hybrid Rotated Function 4');
%      [Ub,Lb,Dim,Fun]=function_details(F);
% [Ub,Lb,Dim,Fun]=new_details(F)
% [Ub, Lb, Dim, Fun]=hybrid_functions(F)
[Lb,Ub,Dim,Fun] = Get_CEC2005_Functions_details(Function_name)
%  [Lb,Ub,Dim,Fun] = CEC2011_functions(F)
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%FPA%%%%%%%%%%%%%%%%
% Dim=10;
for i=1:n
    [fpabest,fpafmin,bb]=fpa_demo(Ub,Lb,Dim,Fun,Iterations,PopSize);
    fpabest(i,:)=fpabest;
    rFPA(i,:)=fpafmin;
    efpa(i,:)=bb;
end
disp('FPA runs completed');
cFPA=min(efpa);
bFPA=min(rFPA);
wFPA=max(rFPA);
mFPA=mean(rFPA);
sFPA=std(rFPA);
fpabest=min(fpabest);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%ABC%%%%%%%%%%%
for i=1:n
    [GlobalMin,cABC]=runABC(Ub,Lb,Dim,Fun,Iterations,PopSize);
    rABC(i,:)=GlobalMin;
end
disp('ABC runs completed');
bABC=min(rABC);
wABC=max(rABC);
mABC=mean(rABC);
sABC=std(rABC);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%FA%%%%%%%%%%%
for i=1:n
    [fabestsolution, fabestobj, faNumEval,cc]= FA(Ub,Lb,Dim,Fun,Iterations,PopSize);
    fabest(i,:)=fabestsolution;
    rFA(i,:)=fabestobj;
    fac(i,:)=cc;
end
cFA=min(fac);
disp('FA runs completed');
bFA=min(rFA);
wFA=max(rFA);
mFA=mean(rFA);
sFA=std(rFA);
fabest=min(fabest);
% %     pause
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%BA%%%%%%%%%%%%%%
for i=1:n
    [babest,bafmin,zz]=bat_algorithm(Ub,Lb,Dim,Fun,Iterations,PopSize);
    dba(i,:)=babest;
    rBA(i,:)=bafmin;
    curve(i,:)=zz;
end
disp('BA runs completed');
cBA=min(curve);
bBA=min(rBA);
wBA=max(rBA);
mBA=mean(rBA);
sBA=std(rBA);
babest=min(dba);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%DE%%%%%%%%%%%%%%%%%%%
for i=1:n
    [bestmem,bestval,nfeval,bestiiii] = de(Ub,Lb,Dim,Fun,Iterations,PopSize);
    bestmen(i,:)=bestmem;
    rDE(i)=bestval;
    nfevali(i)=nfeval;
    besti=bestiiii;
    debest(i,:)=bestval;
end
disp('DE runs completed');
sDE=std(rDE);
mDE=mean(rDE);
wDE=max(rDE);
bDE=min(rDE);
cDE=min(besti);
debest=min(debest);
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%SSA%%%%%%%%%%%%%%%%
 for i=1:n
[SSAbest,SSAfmin,bbdd]=SSA(PopSize,Iterations,Lb,Ub,Dim,Fun);
%     [LSSAbest,LSSAfmin,bb]=cv1_Population_adaptation(Ub,Lb,Dim,Fun,Iterations,PopSize);
    SSAbest(i,:)=SSAbest;
    rSSA(i,:)=SSAfmin;
    eSSA(i,:)=bbdd;
end
disp('SSA runs completed');%     
cSSA=min(eSSA);
bSSA=min(rSSA);
wSSA=max(rSSA);
mSSA=mean(rSSA);
sSSA=std(rSSA);
SSAbest=min(SSAbest);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%LSSA%%%%%%%%%%%%%%%%
 for i=1:n
[DAbest,DAfmin,bb]=DA(PopSize,Iterations,Lb,Ub,Dim,Fun);
%     [LSSAbest,LSSAfmin,bb]=cv1_Population_adaptation(Ub,Lb,Dim,Fun,Iterations,PopSize);
    DAbest(i,:)=DAbest;
    rDA(i,:)=DAfmin;
    eDA(i,:)=bb;
end
disp('DA runs completed');%     
cDA=min(eDA);
bDA=min(rDA);
wDA=max(rDA);
mDA=mean(rDA);
sDA=std(rDA);
DAbest=min(DAbest);
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%GWO%%%%%%%%%%%%
for i= 1:n
    [Alpha_score,Beta_score,Delta_score,cGWO]= gwo_original(Ub,Lb,Dim,Fun,Iterations,PopSize);
    rGWO(i,:)=Alpha_score;
end
disp('GWO runs completed');
bGWO= min(rGWO);
wGWO= max(rGWO);
mGWO= mean(rGWO);
sGWO= std(rGWO);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%LSSA%%%%%%%%%%%%%%%%
 for i=1:n
[ASSAbest,ASSAfmin,bbcc]=LSSA(PopSize,Iterations,Lb,Ub,Dim,Fun)
%     [LSSAbest,LSSAfmin,bb]=cv1_Population_adaptation(Ub,Lb,Dim,Fun,Iterations,PopSize);
    ASSAbest(i,:)=ASSAbest;
    rASSA(i,:)=ASSAfmin;
    eASSA(i,:)=bbcc;
end
disp('ASSA runs completed');%     
cASSA=min(eASSA);
bASSA=min(rASSA);
wASSA=max(rASSA);
mASSA=mean(rASSA);
sASSA=std(rASSA);
ASSAbest=min(ASSAbest);
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%RANKSUM%%%%%%%%%%
figure('Position',[500 500 560 190])
%Draw search space
subplot(1,2,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%Draw objective space
subplot(1,2,2);
hold on
xlabel('Iterations');
ylabel('Fitness Value');
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%COnvergence%%%%%%%%%
%   title('sphere');
title('Objective space')
plot(cFPA,'--r','linewidth',3);
plot(cABC,'-g','linewidth',3);
plot(cFA,'b','linewidth',3);
plot(cDA,'c','linewidth',3);
% plot(cDA,'-.c','linewidth',3);
plot(cSSA,'-.m','linewidth',3);
plot(cGWO,'-y','linewidth',3);
plot(cASSA,'-k','linewidth',3);
axis tight
grid on
box on
% legend('FPA','ABC','FA','DA','SSA','GWO','ALSSA');
hold off
end

