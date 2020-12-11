% Description:
% This script takes input variables like Stiffness
% and Mass/Torsional Interti values and processes
% them to output the natural frequencies, eigen vectors,
% mode shapes. It also checks the orthogonality of these
% vectors.


% Printing Explanation of What is the Input Variables:


% Taking the Inputs

fprintf("\n\nNOTE: For Any Element (Spring etc.) that is not Present, put 0 as its Value!\n\n")
fprintf("\n\nIf There is Only One Wall Present, Start Numbering from That Wall\n\n")
m1 = input("Enter the First Mass or Torsional Intertia Value: ");
m2 = input("Enter the Second Mass or Torsional Intertia Value: ");

k1 = input("Enter the First Stiffness Value: ");
k2 = input("Enter the Second Stiffness Value: ");
k3 = input("Enter the Third Stiffness Value: ");

% Writing Masses in Matrix Form

M = [m1 0
     0 m2];

% Total Stiffnesses in Matrix Form
K = [k1+k2 -k2
    -k2 k2+k3];

% Taking Inverse Square-Root of the Mass Matrix

Minvsq = sqrt(inv(M));

% Finding the K-Dash value
kdash = Minvsq*K*Minvsq;

% Finding the eigen values

a = 1;
b = -(kdash(1,1)+kdash(2,2)); %
c =(kdash(1,1)*kdash(2,2)) - (kdash(1,2)*kdash(2,1));

s = roots([a, b, c]); % Plugging in roots() function to find the eigen values


% Taking the Square-Root to Find the Natural Frequencies
s = sqrt(s);

% Initializing and Empty Normalized Mode Shape Matrix
norm_vector = zeros(2,2);

% Looping over Natural Frequencies to Find the Mode Vector
for i=1:2

 lem = [-(s(i)^2)*m1 0
      0 -(s(i)^2)*m2];

 mod_shape_mat = lem + K;

 mod_vec = [
 1
 -mod_shape_mat(1,1)/mod_shape_mat(1,2)
 ];


 % Normalizing the Mode Shape Vector
 norm_vector(:,i) = mod_vec/(sqrt(mod_vec(1)*mod_vec(1) + mod_vec(2)*mod_vec(2)));

end

% Printing Necessary Outputs
fprintf("\nThe first natural frequency is:\n"), disp(s(1))

fprintf("\nThe second natural frequency is:\n"), disp(s(2))

fprintf("\nThe first normalized mod shape vector is:\n"), disp(norm_vector(:, 1))

fprintf("\nThe second normalized mod shape vector is:\n"), disp(norm_vector(:, 2))


% Initializing Empty Eigen Matrix
eigen_vect = zeros(2,2);

for i = 1:2
  eigen = [s(i)^2 0
  0 s(i)^2];

  kmineig = kdash-eigen;
  mod_vec = [
  1
  -kmineig(1,1)/kmineig(1,2)
  ];

  % Normalizing the Eigen Vectors
  eigen_vect(:,i) = mod_vec/(sqrt(mod_vec(1)*mod_vec(1) + mod_vec(2)*mod_vec(2)));

end

% Printing the Eigen Vectors
fprintf("\nThe first eigen vector is:\n"), disp(eigen_vect(:, 1))
fprintf("\nThe second eigen vector is:\n"), disp(eigen_vect(:, 2))


% Checking Orthogonality of Mode Shape Vectors
u1_u2 = norm_vector(:,1)'*norm_vector(:,2);

if u1_u2 == 0
  fprintf("\nBecause \n \tu1.T*u2 = "), disp(u1_u2)...
  ,fprintf("the mod shapes are orthogonal\n\n")
else
  fprintf("\nBecause \n \tu1.T*u2 = "), disp(u1_u2)...
  ,fprintf("the mod shapes are not orthogonal\n\n")
endif


v1_v2 = eigen_vect(:,1)'*eigen_vect(:,2);

if v1_v2 ~= 0
  fprintf("\nBecause \n \tv1.T*v2 ="), disp(v1_v2)...
  ,fprintf("the eigen are orthogonal\n\n")
else
  fprintf("\nBecause \n \tv1.T*v2 ="), disp(v1_v2)...
  ,fprintf("the eigen are not orthogonal\n\n")
endif
