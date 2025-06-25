%___________________________________________________________________%
%  Dragonfly Algorithm (DA) source codes demo version 1.0           %
%                                                                   %
%  Developed in MATLAB R2011b(7.13)                                 %
%                                                                   %
%  Author and programmer: Seyedali Mirjalili                        %
%                                                                   %
%         e-Mail: ali.mirjalili@gmail.com                           %
%                 seyedali.mirjalili@griffithuni.edu.au             %
%                                                                   %
%       Homepage: http://www.alimirjalili.com                       %
%                                                                   %
%   Main paper:                                                     %
%                                                                   %
%   S. Mirjalili, Dragonfly algorithm: a new meta-heuristic         %
%   optimization technique for solving single-objective, discrete,  %
%    and multi-objective problems, Neural Computing and Applications% 
%   DOI: http://dx.doi.org/10.1007/s00521-015-1920-1                %
%                                                                   %
%___________________________________________________________________%

% This function containts full information and implementations of the benchmark 
% functions in Table 1, Table 2, and other test functins from the literature 

% lb is the lower bound: lb=[lb_1,lb_2,...,lb_d]
% up is the uppper bound: ub=[ub_1,ub_2,...,ub_d]
% dim is the number of variables (dimension of the problem)

function [lb,ub,dim,fobj] = Get_CEC2005_Functions_details(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F2'
        fobj = @F2;
        lb=-10;
        ub=10;
        dim=10;
        
    case 'F3'
        fobj = @F3;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F4'
        fobj = @F4;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F5'
        fobj = @F5;
        lb=-30;
        ub=30;
        dim=10;
        
    case 'F6'
        fobj = @F6;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F7'
        fobj = @F7;
        lb=-1.28;
        ub=1.28;
        dim=10;
        
    case 'F8'
        fobj = @F8;
        lb=-500;
        ub=500;
        dim=10;
        
    case 'F9'
        fobj = @F9;
        lb=-5.12;
        ub=5.12;
        dim=10;
        
    case 'F10'
        fobj = @F10;
        lb=-32;
        ub=32;
        dim=10;
        
    case 'F11'
        fobj = @F11;
        lb=-600;
        ub=600;
        dim=10;
        
    case 'F12'
        fobj = @F12;
        lb=-50;
        ub=50;
        dim=10;
        
    case 'F13'
        fobj = @F13;
        lb=-50;
        ub=50;
        dim=10;
        
    case 'F14'
        fobj = @F14;
        lb=-65.536;
        ub=65.536;
        dim=2;
        
    case 'F15'
        fobj = @F15;
        lb=-5;
        ub=5;
        dim=4;
        
    case 'F16'
        fobj = @F16;
        lb=-5;
        ub=5;
        dim=2;
        
    case 'F17'
        fobj = @F17;
        lb=[-5,0];
        ub=[10,15];
        dim=2;
        
    case 'F18'
        fobj = @F18;
        lb=-2;
        ub=2;
        dim=2;
        
    case 'F19'
        fobj = @F19;
        lb=0;
        ub=10;
        dim=3;
        
    case 'F20'
        fobj = @F20;
        lb=0;
        ub=10;
        dim=6;     
        
    case 'F21'
        fobj = @F21;
        lb=0;
        ub=10;
        dim=4;    
        
    case 'F22'
        fobj = @F22;
        lb=0;
        ub=10;
        dim=4;    
        
    case 'F23'
        fobj = @F23;
        lb=0;
        ub=10;
        dim=4;            
end

end

% F1

function o = F1(x)
o=sum(x.^2);
end

% F2

function o = F2(x)
o=sum(abs(x))+prod(abs(x));
end

% F3

function o = F3(x)
dim=size(x,2);
o=0;
for i=1:dim
    o=o+sum(x(1:i))^2;
end
end

% F4

function o = F4(x)
o=max(abs(x));
end

% F5

function o = F5(x)
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end

% F6

function o = F6(x)
o=sum(abs((x+.5)).^2);
end

% F7

function o = F7(x)
sum1 = 0;
D=30;
for i = 1:1:D
    sum1 = sum1 + i*x(i)^4;
end
o = sum1 + rand();
end

% F8

function o = F8(x)
Dim=size(x,2);
[Nind,Nvar] = size(x);
o = sum((-x .* sin(sqrt(abs(x))))')';
end

% F9

function o = F9(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

% F10

function o = F10(x)
dim=size(x,2);
o=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end

% F11

function o = F11(x)
x1=x(1);
x2=x(2);
o= (x1.^2 + x2.^2)/200 - cos(x1).*cos(x2/sqrt(2)) + 1;
end

% F12

function o = F12(x)
dim=size(x,2);
o=(pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2)+sum((((x(1:dim-1)+1)./4).^2).*...
(1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2))+((x(dim)+1)/4)^2)+sum(Ufun(x,10,100,4));
end

% F13

function o = F13(x)
dim=size(x,2);
o=.1*((sin(3*pi*x(1)))^2+sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2))+sum(Ufun(x,5,100,4));
end

% F14

function o = F14(x)
aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;,...
-32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];

for j=1:25
    bS(j)=sum((x'-aS(:,j)).^6);
end
o=(1/500+sum(1./([1:25]+bS))).^(-1);
end

% F15

function o = F15(x)
aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
o=sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

% F16

function o = F16(x)
o=4*(x(1)^2)-2.1*(x(1)^4)+(x(1)^6)/3+x(1)*x(2)-4*(x(2)^2)+4*(x(2)^4);
end

% F17

function o = F17(x)
o=(x(2)-(x(1)^2)*5.1/(4*(pi^2))+5/pi*x(1)-6)^2+10*(1-1/(8*pi))*cos(x(1))+10;
end

% F18

function o = F18(x)
o=(1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*x(2)^2))*...
    (30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(1)*x(2)+27*(x(2)^2)));
end

% F19

function o = F19(x)
a(:,2)=10.0*ones(4,1);
for j=1:2;
    a(2*j-1,1)=3.0; a(2*j,1)=0.1;
    a(2*j-1,3)=30.0; a(2*j,3)=35.0;
end
c(1)=1.0;c(2)=1.2;c(3)=3.0;c(4)=3.2;
p(1,1)=0.36890;p(1,2)=0.11700;p(1,3)=0.26730;
p(2,1)=0.46990;p(2,2)=0.43870;p(2,3)=0.74700;
p(3,1)=0.10910;p(3,2)=0.87320;p(3,3)=0.55470;
p(4,1)=0.03815;p(4,2)=0.57430;p(4,3)=0.88280;
s = 0;
for i=1:4;
    sm=0;
    for j=1:3;
        sm=sm+a(i,j)*(x(j)-p(i,j))^2;
    end
    s=s+c(i)*exp(-sm);
end
o = -s;
end

% F20

function o = F20(x)
a(1,1)=10.0;	a(1,2)=3.0;		a(1,3)=17.0;	a(1,4)=3.5;		a(1,5)=1.7;		a(1,6)=8.0;
a(2,1)=0.05;	a(2,2)=10.0;	a(2,3)=17.0;	a(2,4)=0.1;		a(2,5)=8.0;		a(2,6)=14.0;
a(3,1)=3.0;		a(3,2)=3.5;		a(3,3)=1.7;		a(3,4)=10.0;	a(3,5)=17.0;	a(3,6)=8.0;
a(4,1)=17.0;	a(4,2)=8.0;		a(4,3)=0.05;	a(4,4)=10.0;	a(4,5)=0.1;		a(4,6)=14.0;
c(1)=1.0;c(2)=1.2;c(3)=3.0;c(4)=3.2;
p(1,1)=0.1312;	p(1,2)=0.1696;	p(1,3)=0.5569;	p(1,4)=0.0124;	p(1,5)=0.8283;	p(1,6)=0.5886;
p(2,1)=0.2329;	p(2,2)=0.4135;	p(2,3)=0.8307;	p(2,4)=0.3736;	p(2,5)=0.1004;	p(2,6)=0.9991;
p(3,1)=0.2348;	p(3,2)=0.1451;	p(3,3)=0.3522;	p(3,4)=0.2883;	p(3,5)=0.3047;	p(3,6)=0.6650;
p(4,1)=0.4047;	p(4,2)=0.8828;	p(4,3)=0.8732;	p(4,4)=0.5743;	p(4,5)=0.1091;	p(4,6)=0.0381;
s = 0;
for i=1:4;
    sm=0;
    for j=1:6;
        sm=sm+a(i,j)*(x(j)-p(i,j))^2;
    end
    s=s+c(i)*exp(-sm);
end
o = -s;
end

% F21

function o = F21(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:5
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F22

function o = F22(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:7
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F23

function o = F23(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:10
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end