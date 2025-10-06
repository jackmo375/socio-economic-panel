* you do not need to transform the dependend variable
* technically we should be doing ordinal mixed effects regression, eg with clmm, glmmTMB, or brms, but these models are complicated and computationally expenive to run. So we use lme4 for now. use DHARMa fpr diagnostics of non gaussian models
* we could do a follow-up study where we take a cross-sectional slice of the data, say for syear=2015, and then do an ordinal regression fit with a glm for comparison. 
* the association between general health status and life satisfaction could be cyclic, and is not necessarily an indicator that health has such a dramatic effect on life satisfaction - right? If we feel dissatisfied with our life, we may be feeling pessimistic, and hence are more likely to evaluate our general health as worse. A doctor's obejctive assessment may be a more useful measure. 


see here https://quarto.org/docs/publishing/github-pages.html for setting up github pages with quarto. I prefer option 2: using a gh-pages branch 

# to publish changes to the docs to github pages
1. after making changes, run `quarto render mysite` from the project root
2. then `cd` to the folder `mysite/_site`
3. finally (from main branch) run `quarto publish gh-pages`
