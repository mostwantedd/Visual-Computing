image = im2double(imread('cameraman.tif'));
hk = [-1, 0, 1];
vk = [-1; 0; 1];
dk = [-1, 0, 0; 0, 0, 0; 0, 0, 1];
sk = [0, -1, 0; -1, 5, -1; 0, -1, 0];
       
h_fct = extended_convolution(image, hk);
v_fct = extended_convolution(image, vk);
d_fct = extended_convolution(image, dk);
s_fct = extended_convolution(image, sk);

figure;
subplot(221); imshow(h_fct); title('Horizontal');
subplot(222); imshow(v_fct); title('Vertical');
subplot(223); imshow(d_fct); title('Diagonal');
subplot(224); imshow(s_fct); title('Sharp');

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