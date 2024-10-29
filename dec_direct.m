function y = dec_direct(x, h, D)
% do a standard direct form decimator with no polyphase
% input=x, filter coeff h, dec rate D

ind = [1:length(h)];
y = zeros(1,floor(length(x)/D));

blks = length(x)/length(h);
for i=1:blks
  xx = x(ind);
  y(i) = sum(h.*xx);
  ind = ind+D;
end

