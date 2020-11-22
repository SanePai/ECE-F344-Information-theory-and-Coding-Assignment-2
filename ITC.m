clc;
clear all;
close all;
%=====================================================================================================================================================
%Input dialog
prompt = {'Enter p(in GF(p)):', 'Enter the coefficients of the polynomial inside square brackets separated by spaces (increasing order of degree):'};
dlgtitle = "Input";
definput = {'2', '[1,1,1,1]'};
dims = [1 35];
inp = inputdlg(prompt,dlgtitle,dims,definput);
%=====================================================================================================================================================
%Input processing
p = str2double(inp{1}); %GF(p)
v = 0:p-1; %Possible elements in GF(p)
% Example: b = [1 0 1 0 0 0 0 1] Input polynomial 1 + x^2 + x^7 + x^3
b = str2num(inp{2});
disp('Input polynomial:')
gfpretty(b)
m_ = size(b);
m = m_(2); %Size of the input polynomial array
a_ = npermutek(v,m-1); %All possible polynomials in GF(p) with a degree less than the input polynomial 
n_ = size(a_);
n = n_(1);
%=====================================================================================================================================================
%Check for irreducibility
is_irreducible = true;
r = -1;
for i = 1:n
    is_zero = false;
    for j = 0:p-1
        if isequal(a_(i,:), [j,zeros(1,m-2)]) %Check if all zeros or constant. If so, skip checking with that polynomial.
            is_zero = true;
        end
    end
    
    if is_zero == true
        continue
    end
    
    [q,r] = gfdeconv(b,a_(i,:),p); %Divide all polynomials and check the remainder

    if r == 0 %If remainder is 0, the 
        is_irreducible = false;
        disp("Factor:")
        gfpretty(a_(i,:))
        break
    end
end
%=====================================================================================================================================================
%Print the result
if is_irreducible == true
    disp("The input polynomial is irreducible over GF(p)");
else
    disp("The input polynomial is reducible over GF(p)");
end
%=====================================================================================================================================================