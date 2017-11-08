%This script takes in a matrix representing an image of a composite
%material, and estimates/plots radial distribution function as a function
%of distance r, in pixels

%binzarized is an image matrix, where the material phase of interest is
%black (=255)

%this could probably be made faster, but it took less than 30 seconds on a
%decently large image at sufficient sampling, so I was happy enough



[m1,n1]=size(binarized);
nsamp=10000;
pc2=zeros(50,1);
for r=1:50
    
    for i=1:nsamp
        
        q=0;
        while q==0
            x1=[randi([1,m1]) randi([1,n1])];
            if sum(binarized(x1)==[255 255])==2
                q=1;
            end
        end
        x2=[-1 -1];
        while (x2(1)<1) || (x2(1)>m1) || (x2(2)<1) || (x2(2)>n1)
            theta=rand(1,1)*2*pi;
            ex=cos(theta);
            ey=sin(theta);
            x2=round([x1(1)+r*ex x1(2)+r*ey]);
        end
        
        if sum(binarized(x2)==[255 255])==2
            pc2(r)=pc2(r)+1;
        end
    end
    
end


plot(pc2/nsamp,'o')

ylabel('Radial Distribution Function(r)');
xlabel('r(pixels)');