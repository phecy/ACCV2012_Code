% program is programming by chenyuefeng on 2012-03-06
% demo main function
% part based model
% top , bottom, left , right
%

clear;
error_boost = [];
error_spboost = [];
success_boost = [];
success_spboost = [];
location_boost = {};
location_spboost = {};
for runid = 1:30
close all;
clear global parameter;
global parameter;

load faceocc_gt.mat;

groundth_gt = faceocc_gt;
parameter.numselectors = 10;
parameter.overlap = 0.99;
parameter.searchfactor = 2;
parameter.minfactor = 0.001;
parameter.patch = groundth_gt(1,:);
parameter.iterationinit = 0;
parameter.numweakclassifiers = 200;
parameter.minarea = 9;
parameter.imagewidth = 352;
parameter.imageheight = 288;
parameter.imdirformat = './/data//faceocc//imgs//img%05d.png';

parameter.imgstart = 0;
parameter.imgend = 885;


parameter.saveresult = false;
parameter.boost = true;
parameter.spboost = true;

%% partbased


%% random part 
% 2012-04-06
parameter.partbased = true;
parameter.randompart = false;
parameter.partnumber = 5;
parameter.sizefixed = true;
parameter.fixedwidth = floor(parameter.patch(3) / 2);
parameter.fixedheight = floor(parameter.patch(4) / 2);

%% edgebased haar feature
parameter.edgefeature = false;
parameter.edgethreshold = 0.7;

%% overlap
parameter.overlapconstrain = 0.5;

%% weak classifier feature size
parameter.haar_size = 5;

%% initeration 
parameter.init_iteration = 50;

runexperiment;

end
save faceocc_error_boost.mat error_boost;
save faceocc_error_spboost.mat error_spboost;
save faceocc_success_boost.mat success_boost;
save faceocc_success_spboost.mat success_spboost;
save faceocc_location_boost.mat location_boost;
save faceocc_location_spboost.mat location_spboost;