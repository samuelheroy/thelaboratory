x_1=sizes(1);
x_2=sizes(2);
x_3=sizes(3);
x_4=sizes(4);
x_5=sizes(5);
x=[x_1; x_2; x_3; x_4; x_5]';
x1=[x'; zeros(20,1)];
x2=[zeros(5,1); x'; zeros(15,1)];
x3=[zeros(10,1); x'; zeros(10,1)];
x4=[zeros(15,1); x'; zeros(5,1)];
x5=[zeros(20,1); x'];


C=[ones(length(x)*5,1) x1 x2 x3 x4 x5];



d=[q_2'; q_4'; q_6'; q_7'; q_85'];

a=lsqlin(C,d,[],[],[],[],[],[],[],options);
plot([0 x],a(2)*[0 x]+a(1),'r')
hold on;
plot([0 x],a(3)*[0 x]+a(1),'b')
plot([0 x],a(4)*[0 x]+a(1),'g')
plot([0 x],a(5)*[0 x]+a(1),'m')
plot([0 x],a(6)*[0 x]+a(1),'c')
plot(x,q_2,'*')
plot(x,q_4,'*')
plot(x,q_6,'*')
plot(x,q_7,'*')
plot(x,q_85,'*')



