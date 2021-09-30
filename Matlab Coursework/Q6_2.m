image = im2double(imread('cameraman.tif'));
 kernel = ones(5) / 25;
%kernel = [-1, 0, 1];
filtered = extended_convolution(image, kernel);

reference = imfilter(image,kernel, 'replicate', 'conv');
difference = 0.5 + 10 * (filtered - reference);
ssd = sum((filtered(:) - reference(:)) .^ 2);

figure;
subplot(131); imshow(filtered); title('Extended convolution');
subplot(132); imshow(reference); title('Reference result');
subplot(133); imshow(difference); title(sprintf('Difference (SSD=%.1f)',ssd));

function accumulator = extended_convolution(image, kernel)
    [h, w]= size(kernel);
    c1 = floor(h/2) + 1;
    c2 = floor(w/2) + 1;
    image = padarray(image, [c1-1,c2-1], 'replicate', 'both');
    [p, q]= size(image);
    
    accumulator = zeros(p,q);
    
    for i = c1:(p-c1+1) 
        for j = c2:(q-c2+1)
            sum=0;
            for m = 1:h
                for n = 1:w
                    sum = sum + kernel(m,n)*image(i+(c1-m), j+(c2-n));
                end
            end
            accumulator(i,j) = sum;
        end
    end
    accumulator = accumulator(c1:(p-c1+1),c2:(q-c2+1));
end
