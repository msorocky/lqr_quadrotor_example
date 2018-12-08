close all

% Constants
T = 0.1;
N = 20;


% Initial condition
x0 = [1; 1];

% State space matrices
A = [1 1;
     0 1];

B = [0; T];

% States costs

% This drives the position to 0
%Q = diag([1 0]);

% This also drives position to 0, but discourages large velocities in
% getting there
Q = diag([1 20]);

% Input cost (for comparison purposes)
R = [0.1 0.5 2];


% States
x = zeros(2, N/T, 3);
x(:, 1, 1) = x0;
x(:, 1, 2) = x0;
x(:, 1, 3) = x0;

for m = 1 : size(R, 2)
    [X,L,G] = dare(A,B,Q,R(m));
    
    for k = 2 : N/T

       x(:, k, m) = A*x(:, k-1, m) - B*G*x(:, k-1, m);

    end
    
end

t = 1 : N/T;

figure(1)
subplot(2, 1, 1)
plot(t, x(1, :, 1), 'r')
hold on
plot(t, x(1, :, 2), 'b')
plot(t, x(1, :, 3), 'g')
axis([0 N -1 3])
xlabel('t [s]')
ylabel('x [m]')
legend(['r = ',num2str(R(1))],['r = ',num2str(R(2))],['r = ',num2str(R(3))])


subplot(2, 1, 2)
plot(t, x(2, :, 1), 'r')
hold on
plot(t, x(2, :, 2), 'b')
plot(t, x(2, :, 3), 'g')
axis([0 N -1 3])
xlabel('t [s]')
ylabel('v [m/s]')
legend(['r = ',num2str(R(1))],['r = ',num2str(R(2))],['r = ',num2str(R(3))])
