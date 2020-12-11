% k1 = input("Enter Stiffness Value of Relating to x1: ");
% k2 = input("Enter Stiffness Value of Relating to x2: ");
% m1 = input("Enter Mass Value of Relating to x1: ");
% m2 = input("Enter Mass Value of Relating to x2: ");
k1 = 0;
k2 = 280000;
m1 = m2 = 2000;

M = [m1 0
     0 m2];

K = [k1+k2 -k2
    -k2 k2];
n = M+K;
b =-((m2*K(1,1))+(m1*K(2,2)));
c =(K(1,1)*K(2,2))-(K(1,2)*K(2,1));
s = roots([m1*m2, b,c])

s = sqrt(s)

lem = [-(s(1)^2)*m1 0
      0 -(s(1)^2)*m2];

mod_shape_mat = lem + K

mod_vec_1 = [
1
-mod_shape_mat(1,2)/mod_shape_mat(1,1)
]

norm_vector = mod_vec_1/(sqrt(mod_vec_1(1)*mod_vec_1(1) + mod_vec_1(2)*mod_vec_1(2)))
