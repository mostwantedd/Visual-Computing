image = im2double(imread('cameraman.tif'));
n = 5;
% kernel = [-1,0,1];
kernel = ones(n)/(n^2);

convoluted = extended_convolution(image, kernel);
fourier = fourier_convolution(image, kernel);

difference = 0.5 + 10 * (fourier - convoluted);
ssd = sum((fourier(:) - convoluted(:)) .^ 2);

figure(1);
subplot(131); imshow(convoluted); title('Extended convolution');
subplot(132); imshow(fourier); title('Product of FFTs');
subplot(133); imshow(difference); title(sprintf('Difference (SSD=%.1f)',ssd));


kms = 20;
no_run = 150; 

ksize = []; 
conv = [];
mult_fur = [];

for n = 3:2:kms
    kernel = ones(n)/(n^2);
     
    ksize = [ksize, n];
    
    tic
    for n = 1:no_run
        convoluted = extended_convolution(image, kernel);
    end
    conv = [conv; toc/no_run];

    tic
    for n = 1:no_run
        furier = fourier_convolution(image, kernel);
    end
    mult_fur = [mult_fur; toc/no_run];
end

figure(2);
plot(ksize, conv, 'DisplayName', 'Convolution')
hold on
plot(ksize, mult_fur, 'DisplayName', 'FFT')
title(sprintf('result mean %d',no_run));
ylabel('time (s)');
xlabel('Kernel size');
legend
hold off

function C =fourier_convolution(image, kernel)
    
    [kh, kw]= size(kernel);
    c1 = floor(kh/2);
    c2 = floor(kw/2);
    image = padarray(image, [c1,c2], 'replicate', 'both');
    [ph, pw]= size(image);
    C = ifft2(fft2(image).*fft2(kernel,ph,pw));
    C = C(kh:end,kw:end);

end

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
