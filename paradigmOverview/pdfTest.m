
mu = 3;
sigma = .5;
x = mu-2:sigma/10:mu+2;
y = normpdf(x, mu,sigma);
plot(x,y);