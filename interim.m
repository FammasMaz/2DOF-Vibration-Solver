k1 = input("Enter Stiffness Value of Relating to x1: ");
k2 = input("Enter Stiffness Value of Relating to x2: ");
m1 = input("Enter Mass Value of Relating to x1: ");
m2 = input("Enter Mass Value of Relating to x2: ");

M = [m1 0
     0 m2]

K = [k1+k2 -k2
    -k2 k2]

Minvsq = sqrt(inv(M))

kdash = Minvsq*K*Minvsq


b = -(kdash(1,1)+kdash(2,2))
c =(kdash(1,1)*kdash(2,2)) - (kdash(1,2)*kdash(2,1))
s = roots([1, b, c])
s = sqrt(s)

norm_vector = zeros(2,2);
for i=1:2

 lem = [-(s(i)^2)*m1 0
      0 -(s(i)^2)*m2];

 mod_shape_mat = lem + K;

 mod_vec = [
 1
 -mod_shape_mat(1,2)/mod_shape_mat(1,1)
 ];

 norm_vector(:,i) = mod_vec/(sqrt(mod_vec(1)*mod_vec(1) + mod_vec(2)*mod_vec(2)));
end
fprintf("\nThe first natural frequency is:\n"), disp(s(1))

fprintf("\nThe first natural frequency is:\n:"), disp(s(2))

fprintf("\nThe first normalized mod shape vector is:\n"), disp(norm_vector(:, 1))

fprintf("\nThe second normalized mod shape vector is:\n"), disp(norm_vector(:, 2))
