image = im2double(imread('cameraman.tif'));
kernel = ones(5) / 25;
%kernel = [-1, 0, 1];
result = basic_convolution(image, kernel);
figure;
subplot(121); imshow(image); title('Input image');
subplot(122); imshow(result); title('Filtered image');


function accumulator = basic_convolution(image, kernel)
    [h, w]= size(kernel);
    c1 = floor(h/2)+1;
    c2 = floor(w/2)+1;
    [p, q]= size(image);
    accumulator = zeros(p,q);
    for i = h:(p-h)
        for j = w:(q-w)
           sum=0;
            for m = 1:h
                for n = 1:w
                     sum = sum + kernel(m,n)*image(i+(c1-m), j+(c2-n));
                end
            end
           accumulator(i,j) = sum;
        end
    end
end



