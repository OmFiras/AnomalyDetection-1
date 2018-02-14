clc; clear all;

addpath /Users/meghagupta/sfuvault/Documents/MATLAB/AnomalyDetection/Matrices
addpath /Users/meghagupta/sfuvault/Documents/MATLAB/AnomalyDetection/csv

% GT WEEKDAYS
%load('gt_weekday_meter_1.mat','gt_result','gt_score'); %thresh 90% or 1.65
%load('gt_weekday_meter_2.mat','gt_result','gt_score'); %thresh 95% or 2sd
%load('gt_weekday_meter_3.mat','gt_result','gt_score'); %threshold is 98% or 2.35 sd
%--------------------------------------------------------------------------------------
%load('gt_weekday_meter_4.mat','gt_result','gt_score'); %threshold is 80% or 1.3 sd
%load('gt_weekday_meter_5.mat','gt_result','gt_score'); %threshold is 70% or 1.05 sd
%load('gt_weekday_meter_6.mat','gt_result','gt_score'); %threshold is 60% or 0.85 sd
%load('gt_weekday_meter_7.mat','gt_result','gt_score'); %threshold is 50% or 0.68 sd
%load('gt_weekday_meter_8.mat','gt_result','gt_score'); %threshold is 40% or 0.53 sd
%load('gt_weekday_meter_9.mat','gt_result','gt_score'); %threshold is 30% or 0.39 sd
%load('gt_weekday_meter_10.mat','gt_result','gt_score'); %threshold is 20% or 0.26 sd
%load('gt_weekday_meter_11.mat','gt_result','gt_score'); %threshold is 10% or 0.13 sd

%GT WEEKENDS
%load('gt_weekend_meter_1.mat','gt_result','gt_score');  %thresh 90% or 1.65
%load('gt_weekend_meter_2.mat','gt_result','gt_score'); %thresh 95% or 2sd
load('gt_weekend_meter_3.mat','gt_result','gt_score');  %threshold is 98% or 2.35 sd
%------------------------------------------------------------------------------------
%load('gt_weekend_meter_4.mat','gt_result','gt_score'); %threshold is 80% or 1.3 sd
%load('gt_weekend_meter_5.mat','gt_result','gt_score'); %threshold is 70% or 1.05 sd
%load('gt_weekend_meter_6.mat','gt_result','gt_score'); %threshold is 60% or 0.85 sd
%load('gt_weekend_meter_7.mat','gt_result','gt_score'); %threshold is 50% or 0.68 sd
%load('gt_weekend_meter_8.mat','gt_result','gt_score'); %threshold is 40% or 0.53 sd
%load('gt_weekend_meter_9.mat','gt_result','gt_score'); %threshold is 30% or 0.39 sd
%load('gt_weekend_meter_10.mat','gt_result','gt_score'); %threshold is 20% or 0.26 sd
%load('gt_weekend_meter_11.mat','gt_result','gt_score'); %threshold is 10% or 0.13 sd

%%%FOR SEEM PAPER
%X = load('seem_weekday_meter.mat','result','score');
X = load('seem_weekend_meter.mat','result','score');

house_fields = fieldnames(X);
n = numel(house_fields);
day_result = X.(house_fields{n-1});
day_score = X.(house_fields{n});         %Score generated by the Seem algo
col_size = size(gt_result,2);     

%F-score, TPR, TNR, FPR, Jaccard Index
day_result_mat = cell2mat(day_result(:));
day_score_mat = cell2mat(day_score(:));
gt_result_mat = cell2mat(gt_result(:));
gt_score_mat = cell2mat(gt_score(:));

[fscore,jaccard,tpr,tnr,fpr] = fscore_fun(day_result_mat,day_score_mat,gt_result_mat,gt_score_mat)

%FP-100
true_anom_thresh = 0.9;
[fp_100] = fp_fun(true_anom_thresh,day_result_mat,gt_result_mat,gt_score_mat)

%Rank_power
top_m = 3;
[avg_rank_power] = rankpower_fun(top_m,day_result_mat,day_score_mat,gt_result_mat,gt_score_mat)

%ROC, AUC, PAUC by restricting the fpr values
[roc_weekday1] = load('tpr_fpr_weekday_1.mat');
[roc_weekday2] = load('tpr_fpr_weekday_2.mat');
[roc_weekday3] = load('tpr_fpr_weekday_3.mat');
[roc_weekday4] = load('tpr_fpr_weekday_4.mat');
[roc_weekday5] = load('tpr_fpr_weekday_5.mat');
[roc_weekday6] = load('tpr_fpr_weekday_6.mat');
[roc_weekday7] = load('tpr_fpr_weekday_7.mat');
[roc_weekday8] = load('tpr_fpr_weekday_8.mat');
[roc_weekday9] = load('tpr_fpr_weekday_9.mat');
[roc_weekday10] = load('tpr_fpr_weekday_10.mat');
[roc_weekday11] = load('tpr_fpr_weekday_11.mat');

[roc_weekend1] = load('tpr_fpr_weekend_1.mat');
[roc_weekend2] = load('tpr_fpr_weekend_2.mat');
[roc_weekend3] = load('tpr_fpr_weekend_3.mat');
[roc_weekend4] = load('tpr_fpr_weekend_4.mat');
[roc_weekend5] = load('tpr_fpr_weekend_5.mat');
[roc_weekend6] = load('tpr_fpr_weekend_6.mat');
[roc_weekend7] = load('tpr_fpr_weekend_7.mat');
[roc_weekend8] = load('tpr_fpr_weekend_8.mat');
[roc_weekend9] = load('tpr_fpr_weekend_9.mat');
[roc_weekend10] = load('tpr_fpr_weekend_10.mat');
[roc_weekend11] = load('tpr_fpr_weekend_11.mat');

[auc_weekday, auc_weekend, pauc_weekday,pauc_weekend] = auc_pauc_fun(roc_weekday1,roc_weekday2,roc_weekday3,roc_weekday4,roc_weekday5,roc_weekday6,roc_weekday7,roc_weekday8,roc_weekday9,roc_weekday10,roc_weekday11,roc_weekend1,roc_weekend2,roc_weekend3,roc_weekend4,roc_weekend5,roc_weekend6,roc_weekend7,roc_weekend8,roc_weekend9,roc_weekend10,roc_weekend11)




%%
clc; clear all;
%%For datasets other than seem

%GT WEEKDAYS
GT_weekday = load('gt_weekday_meter_dataset_1.mat','ground_truth_weekday','score_weekday');  %thresh 90% or 1.65
%GT_weekday = load('gt_weekday_meter_dataset_2.mat','ground_truth_weekday','score_weekday');  %thresh 95% or 2
%GT_weekday = load('gt_weekday_meter_dataset_3.mat','ground_truth_weekday','score_weekday');  %thresh 98% or 2.35
%--------------------------------------------------------------------------------------
%GT_weekday = load('gt_weekday_meter_dataset_4.mat','ground_truth_weekday','score_weekday');  %thresh 80% or 1.3
%GT_weekday = load('gt_weekday_meter_dataset_5.mat','ground_truth_weekday','score_weekday'); %thresh 70% or 1.05
%GT_weekday = load('gt_weekday_meter_dataset_6.mat','ground_truth_weekday','score_weekday');  %thresh 60% or 0.85
%GT_weekday = load('gt_weekday_meter_dataset_7.mat','ground_truth_weekday','score_weekday'); %thresh 50% or .68
%GT_weekday = load('gt_weekday_meter_dataset_8.mat','ground_truth_weekday','score_weekday');  %thresh 40% or .53
%GT_weekday = load('gt_weekday_meter_dataset_9.mat','ground_truth_weekday','score_weekday'); %thresh 30% or .39
%GT_weekday = load('gt_weekday_meter_dataset_10.mat','ground_truth_weekday','score_weekday'); %thresh 20% or .26
%GT_weekday = load('gt_weekday_meter_dataset_11.mat','ground_truth_weekday','score_weekday'); %thresh 10% or 0.13


%GT WEEKENDS
GT_weekend = load('gt_weekend_meter_dataset_1.mat','ground_truth_weekend','score_weekend');  %thresh 90% or 1.65
%GT_weekend = load('gt_weekend_meter_dataset_2.mat','ground_truth_weekend','score_weekend'); %thresh 95% or 2
%GT_weekend=load('gt_weekend_meter_dataset_3.mat','ground_truth_weekend','score_weekend'); %thresh 98% or 2.35
%--------------------------------------------------------------------------------------
%GT_weekend=load('gt_weekend_meter_dataset_4.mat','ground_truth_weekend','score_weekend'); %thresh 80% or 1.3
%GT_weekend=load('gt_weekend_meter_dataset_5.mat','ground_truth_weekend','score_weekend'); %thresh 70% or 1.05
%GT_weekend=load('gt_weekend_meter_dataset_6.mat','ground_truth_weekend','score_weekend'); %thresh 60% or 0.85
%GT_weekend=load('gt_weekend_meter_dataset_7.mat','ground_truth_weekend','score_weekend'); %thresh 50% or .68
%GT_weekend=load('gt_weekend_meter_dataset_8.mat','ground_truth_weekend','score_weekend'); %thresh 40% or .53
%GT_weekend=load('gt_weekend_meter_dataset_9.mat','ground_truth_weekend','score_weekend'); %thresh 30% or .39
%GT_weekend=load('gt_weekend_meter_dataset_10.mat','ground_truth_weekend','score_weekend'); %thresh 20% or .26
%GT_weekend=load('gt_weekend_meter_dataset_11.mat','ground_truth_weekend','score_weekend'); %thresh 10% or 0.13


% %HP DATA LOADING
X = load('hp_daytype.mat','hp_data'); % A 30x18 matrix with two consecutive columns representing one house meter data on April and May months.
[roc_weekday1] = load('tpr_fpr_weekday_1_hp.mat');
[roc_weekday2] = load('tpr_fpr_weekday_2_hp.mat');
[roc_weekday3] = load('tpr_fpr_weekday_3_hp.mat');
[roc_weekday4] = load('tpr_fpr_weekday_4_hp.mat');
[roc_weekday5] = load('tpr_fpr_weekday_5_hp.mat');
[roc_weekday6] = load('tpr_fpr_weekday_6_hp.mat');
[roc_weekday7] = load('tpr_fpr_weekday_7_hp.mat');
[roc_weekday8] = load('tpr_fpr_weekday_8_hp.mat');
[roc_weekday9] = load('tpr_fpr_weekday_9_hp.mat');
[roc_weekday10] = load('tpr_fpr_weekday_10_hp.mat');
[roc_weekday11] = load('tpr_fpr_weekday_11_hp.mat');

[roc_weekend1] = load('tpr_fpr_weekend_1_hp.mat');
[roc_weekend2] = load('tpr_fpr_weekend_2_hp.mat');
[roc_weekend3] = load('tpr_fpr_weekend_3_hp.mat');
[roc_weekend4] = load('tpr_fpr_weekend_4_hp.mat');
[roc_weekend5] = load('tpr_fpr_weekend_5_hp.mat');
[roc_weekend6] = load('tpr_fpr_weekend_6_hp.mat');
[roc_weekend7] = load('tpr_fpr_weekend_7_hp.mat');
[roc_weekend8] = load('tpr_fpr_weekend_8_hp.mat');
[roc_weekend9] = load('tpr_fpr_weekend_9_hp.mat');
[roc_weekend10] = load('tpr_fpr_weekend_10_hp.mat');
[roc_weekend11] = load('tpr_fpr_weekend_11_hp.mat');

% X = load('multiuser_daytype.mat','multiuser_data');
% [roc_weekday1] = load('tpr_fpr_weekday_1_multi.mat');
% [roc_weekday2] = load('tpr_fpr_weekday_2_multi.mat');
% [roc_weekday3] = load('tpr_fpr_weekday_3_multi.mat');
% [roc_weekday4] = load('tpr_fpr_weekday_4_multi.mat');
% [roc_weekday5] = load('tpr_fpr_weekday_5_multi.mat');
% [roc_weekday6] = load('tpr_fpr_weekday_6_multi.mat');
% [roc_weekday7] = load('tpr_fpr_weekday_7_multi.mat');
% [roc_weekday8] = load('tpr_fpr_weekday_8_multi.mat');
% [roc_weekday9] = load('tpr_fpr_weekday_9_multi.mat');
% [roc_weekday10] = load('tpr_fpr_weekday_10_multi.mat');
% [roc_weekday11] = load('tpr_fpr_weekday_11_multi.mat');
% 
% [roc_weekend1] = load('tpr_fpr_weekend_1_multi.mat');
% [roc_weekend2] = load('tpr_fpr_weekend_2_multi.mat');
% [roc_weekend3] = load('tpr_fpr_weekend_3_multi.mat');
% [roc_weekend4] = load('tpr_fpr_weekend_4_multi.mat');
% [roc_weekend5] = load('tpr_fpr_weekend_5_multi.mat');
% [roc_weekend6] = load('tpr_fpr_weekend_6_multi.mat');
% [roc_weekend7] = load('tpr_fpr_weekend_7_multi.mat');
% [roc_weekend8] = load('tpr_fpr_weekend_8_multi.mat');
% [roc_weekend9] = load('tpr_fpr_weekend_9_multi.mat');
% [roc_weekend10] = load('tpr_fpr_weekend_10_multi.mat');
% [roc_weekend11] = load('tpr_fpr_weekend_11_multi.mat');
%X = load('rpca_daytype.mat','rpca_score');

house_fields = fieldnames(X);
n = numel(house_fields);
data = X.(house_fields{n});
[weekday,weekend]= sep_month_day_end(data);

gt_weekday_score = GT_weekday.score_weekday;
gt_weekend_score = GT_weekend.score_weekend;
gt_weekday_res = GT_weekday.ground_truth_weekday;
gt_weekend_res = GT_weekend.ground_truth_weekend;
col_size = size(gt_weekday_res,2);
 
 %FP-100
gt_result_weekday = cell2mat(gt_weekday_res(:));
gt_score_weekday = cell2mat(gt_weekday_score(:));
gt_result_weekend = cell2mat(gt_weekend_res(:));
gt_score_weekend = cell2mat(gt_weekend_score(:));
[sort_score_weekday,sort_res_weekday] = sort(weekday,1,'descend');
[sort_score_weekend,sort_res_weekend] = sort(weekend,1,'descend');

weekday_res = sort_res_weekday';
weekend_res = sort_res_weekend';


%F-score, Jaccard Index
[fscore_weekday,jaccard_weekday,tpr_weekday,tnr_weekday,fpr_weekday] = fscore_fun(sort_res_weekday',sort_score_weekday',gt_result_weekday,gt_score_weekday)
[fscore_weekend,jaccard_weekend,tpr_weekend,tnr_weekend,fpr_weekend] = fscore_fun(sort_res_weekend',sort_score_weekend',gt_result_weekend,gt_score_weekend)


% AUC, PAUC  
[auc_weekday, auc_weekend, pauc_weekday,pauc_weekend] = auc_pauc_fun(roc_weekday1,roc_weekday2,roc_weekday3,roc_weekday4,roc_weekday5,roc_weekday6,roc_weekday7,roc_weekday8,roc_weekday9,roc_weekday10,roc_weekday11,roc_weekend1,roc_weekend2,roc_weekend3,roc_weekend4,roc_weekend5,roc_weekend6,roc_weekend7,roc_weekend8,roc_weekend9,roc_weekend10,roc_weekend11)

%FP-100
true_anom_thresh = 0.9;
[fp_100_weekday] = fp_fun(true_anom_thresh,weekday_res,gt_result_weekday,gt_score_weekday)
[fp_100_weekend] = fp_fun(true_anom_thresh,weekend_res,gt_result_weekend,gt_score_weekend)


%Rank Power
top_m = 3;
[avg_rank_power_weekday] = rankpower_fun(top_m,weekday_res,gt_result_weekday)
%top_m = 1:size(weekend_res,2);
[avg_rank_power_weekend] = rankpower_fun(top_m,weekend_res,gt_result_weekend)




