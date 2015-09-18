function idx = segmentImg(I, k)
% function idx = segmentImage(img)
% Returns the logical image containing the segment ids obtained from 
%   segmenting the input image
%
% INPUTS
% I - The input image contining textured foreground objects to be segmented
%     out.
% k - The number of segments to compute (also the k-means parameter).
%
% OUTPUTS
% idx - The logical image (same dimensions as the input image) contining 
%       the segment ids after segmentation. The maximum value of idx is k.
%          

    % 1. Create your bank of filters using the given alogrithm; 
    % 2. Compute the filter responses by convolving your input image with  
    %     each of the num_filters in the bank of filters F.
    %     responses(:,:,i)=conv2(I,F(:,:,i),'same')
    %     NOTE: we suggest to use 'same' instead of 'full' or 'valid'.
    % 3. Remember to take the absolute value of the filter responses (no
    %     negative values should be used).
    % 4. Construct a matrix X of the points to be clustered, where 
    %     the rows of X = the total number of pixels in I (rows*cols); and
    %     the columns of X = num_filters;
    %     i.e. each pixel is transformed into a num_filters-dimensional
    %     vector.
    % 5. Run kmeans to cluster the pixel features into k clusters,
    %     returning a vector IDX of labels.
    % 6. Reshape IDX into an image with same dimensionality as I and return
    %     the reshaped index image.
    %
	
	
    %I = double(rgb2gray(fullim)); 
	%I=(:,:,1);
    F=makeLMfilters;
    [fht,fwd,num_filters] = size(F);
	
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
        %filter_responses=I;
		
		for i=1:num_filters
			filter_responses(:,:,i)=conv2(I(),F(:,:,i),'same');
		end
		 [ht,wd,n]=size(filter_responses);
		
		for a=1:ht
			for b=1:wd
				for c=1:n
					if filter_responses(a,b,c)<0
						filter_responses(a,b,c)=abs(filter_responses(a,b,c));
					end	
				end
			end
		end
		

		
		X=reshape(filter_responses,ht*wd,n);
		
		[IDX, C] = kmeans(X, k);
		
		IDX=reshape(IDX,ht,wd);
		
		figure(2);
		imagesc(IDX);
		
		%init the fgs array to select the clusters you want to show 
		fgs=[ 2 4 6 7];
		
		%original image
		actualI=imread('images/zebra.jpg');
		actualI=im2double(actualI);

		%new background
		newbg=imread('images/bg.jpg');
		newbg=im2double(newbg);
		
		newI=transferImg(fgs,IDX,actualI,newbg);
		
		figure(3);
		imshow(newI);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


%Notes
%cheetah 5>1245

%for dog better image
% 6>12345

%gecko 5>123
%7>1345

