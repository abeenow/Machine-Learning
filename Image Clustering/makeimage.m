function makeimage(im,idx)
imseg = zeros(size(im,1),size(im,2));
for i=1:max(idx)
    imseg(idx==i)=i;
end
imagesc(imseg)