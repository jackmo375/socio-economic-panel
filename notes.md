* you do not need to transform the dependend variable
* technically we should be doing ordinal mixed effects regression, eg with clmm, glmmTMB, or brms, but these models are complicated and computationally expenive to run. So we use lme4 for now. use DHARMa fpr diagnostics of non gaussian models
* we could do a follow-up study where we take a cross-sectional slice of the data, say for syear=2015, and then do an ordinal regression fit with a glm for comparison. 
