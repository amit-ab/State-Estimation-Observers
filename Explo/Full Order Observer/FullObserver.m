% n=system order; m=number inputs; l=number of outputs; c=rank of the output matrix
n=4; 
m=1; 
l=2; 
c=2;

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

%Finding the Observer Gain Matrix using the Desired Observer Poles
lambdaObsDesired=[-10 -11 -12 -13];
KT=place(A',C',lambdaObsDesired);
K=KT'; 