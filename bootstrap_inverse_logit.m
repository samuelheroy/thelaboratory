function [est,low,high]=bootstrap_inverse_logit(p,confidence,x,y,n_trials,n_replacements,epochs)
%This function is used to perform calibration (and estimate confidence intervals) at some p for a logistic
%regression fit to binomial data wherein n_trials are performed from each
%(x,y) pair. x, a column vector, is the dependent variable. Each corresponding entry of y, 
%a column vector, gives the number of successes in the n_trials performed
%at the corresponding x value.
%n_replacements is the number of samples to be used in each bootstrapping
%epoch
%confidence is the level of confidence intervals desired (ie 95%).


%First, fit a logistic regression to the data set, define the inverse of
%this fitted model, and estimate the answer to the calibration problem

[b_original,~,~] = glmfit(x,[y n_trials],'binomial','link','logit'); %fit initial model
invLogitPredict = @(p,beta) (log(p./(1-p)) - beta(1))/beta(2); %inverse of model
est=invLogitPredict(p,b_original); %inverse prediction of this model at p


samp=zeros(epochs,1);
for i=1:epochs
    new_y=zeros(length(y),1);
    for j=1:length(y)
        for k=1:n_replacements(j)
            if rand<(y(j)/n_trials(j))
                new_y(j)=new_y(j)+1;
            end
        end
    end
    b=glmfit(x,[new_y n],'binomial','link','logit');
    samp(i)=invLogitPredict(p,b);
end


low=prctile(samp,100-confidence/2);
high=prctile(samp,50+confidence/2);