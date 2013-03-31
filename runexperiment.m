objectlocation = parameter.patch;

%parameter.initializeiterations = 50;
% generate haar feature randomly and initilize the gaussian distribution 

I = imread(num2str(parameter.imgstart, parameter.imdirformat));
if(size(I, 3) == 3)
    I = rgb2gray(I);
end
imshow(I);
sumimagedata = intimage(I);
% initilize the posgaussian and neggaussian
% strongclassifier(1) total   block
% strongclassifier(2) top     block
% strongclassifier(3) bottom  block
% strongclassifier(4) left    block
% strongclassifier(5) right   block


sstrongclassifier = partbased_init_strongclassifier(I, parameter.patch);
save sstrongclassifier.mat sstrongclassifier parameter;


% generate the patches in the search region
patches = generatepatches(parameter.patch, parameter.searchfactor, parameter.overlap);
% first initilize the weakclassifiers


%selectors_copy = selectors;
%alpha_copy = alpha;
%[boostloc, boostconf, boost_selectors] = boosting(sumimagedata, patches);
%  ======= boost
%

if  parameter.boost
    %[boostloc, boostconf, boost_selectors, strongclassifier, selectors, alpha] = ...
    %    boosting(strongclassifier, sumimagedata, patches);
    [boostloc, boostconf, sstrongclassifier] = ...
         partbased_rawboosting(sstrongclassifier, sumimagedata, patches);
    location_boost{runid} = boostloc;
end

%% assigne parameter


%% generate the patches in the search region


%% ======== sp boost

figure;
load sstrongclassifier.mat;
patches = generatepatches(parameter.patch, parameter.searchfactor, parameter.overlap);

if parameter.spboost
    [spboostloc, spboostconf, sstrongclassifier] = ...
         partbased_sparseboosting(sstrongclassifier, sumimagedata, patches);
    location_spboost{runid} = spboostloc;
end


figure; 
if parameter.boost
    [boosterror, boostsuccess] = calerror(boostloc, groundth_gt, 'b',parameter.imgstart, parameter.imgend); 
    error_boost = [error_boost, boosterror];
    success_boost = [success_boost, boostsuccess];
end
hold on
if parameter.spboost
    [spboosterror, spboostsuccess] = calerror(spboostloc, groundth_gt, 'r', parameter.imgstart, parameter.imgend);
    error_spboost = [error_spboost, spboosterror];
    success_spboost = [success_spboost, spboostsuccess];
end
