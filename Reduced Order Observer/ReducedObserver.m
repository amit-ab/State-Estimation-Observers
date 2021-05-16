% n=system order; m=number inputs; % l=number of outputs; c=rank of the output matrix
n=4; m=1; l=2; c=2;

%Defining A Matrix
A=[-0.01357 -32.2 -46.3 0; 0.00012 0 1.214 0; -0.0001212 0 -1.214 1; 0.00057 0 -9.1 -0.6696];

%Defining B Matrix
B=[-0.433;0.1394;-0.1394;-0.1577];

%Defining c Matrix
C=[0 0 0 1; 1 0 0 0];

%Defining D Matrix
D=[0;0];

%Given Initial Conditions
x0=[2;2;2;2];

%Finding the Feedback Gain Matrix using the Desired System Poles
lambdaSystemDesired=[-0.5, -1+1i*1, -1-1i*1, -2];
F=place(A,B,lambdaSystemDesired);

% Proceeding towards the Reduced-order Observer Design
C1=[0 1 0 0;0 0 1 0]; %Assumning the C1 Matrix such that rank([C: C1])=n

Caug=[C;C1];

Laug=inv(Caug); %Lets suppose [C: C1]^- = [L1 L2]

%Finding L1
L1=Laug(1:n,1:c);

%Finding L2
L2=Laug(1:n,c+1:n);

%Finding Observer Gain 'K1'
lambda_red_obs=[-10 -11];
K1T=place((C1*A*L2)',(C*A*L2)',lambda_red_obs);
K1=K1T';

%Finding Values of Aq, Bq and Kq as explained in the modeling of Reduced Observer
Aq=C1*A*L2-K1*C*A*L2; 
Bq=C1*B-K1*C*B;
Kq=C1*A*L2*K1+C1*A*L1-K1*C*A*L1-K1*C*A*L2*K1;

% Least-Squares Choices for Initial Conditions
y0=C*x0; 
x0hat=pinv(C'*C)*C'*y0;
x0hat_reduced=inv(L2'*L2)*L2'*(pinv(C'*C)*C'-(L1+L2*K1))*y0;