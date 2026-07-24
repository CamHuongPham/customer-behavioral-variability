# Code

This folder contains the R scripts used to reproduce the empirical analysis of customer behavioral variability.

## Workflow

The analysis pipeline should be executed sequentially:

1. `01_data_preprocessing.R`  
   Merge transaction files and remove invalid purchase records.

2. `02_behavioral_descriptors.R`  
   Construct customer-level behavioral descriptors (Frequency, Diversity, and Entropy) and generate descriptive statistics.

3. `03_behavioral_distributions.R`  
   Visualize the distributions of the behavioral descriptors.

4. `04_correlation_analysis.R`  
   Calculate correlations among behavioral descriptors.

5. `05_descriptor_relationships.R`  
   Visualize relationships among behavioral descriptors.

6. `06_elbow_method.R`  
   Determine the optimal number of customer segments using the Elbow method.

7. `07_customer_segmentation.R`  
   Perform K-means clustering and summarize customer segment profiles.

8. `08_cluster_proportions.R`  
   Calculate the proportion of customers assigned to each segment.

9. `09_kruskal_validation.R`  
   Evaluate behavioral differentiation across customer segments using Kruskal–Wallis tests.

10. `10_dunn_posthoc.R`  
    Perform pairwise comparisons using Dunn’s post-hoc tests with Holm adjustment.

11. `11_revenue_validation.R`  
    Calculate customer revenue and summarize revenue differences across segments.

12. `12_revenue_kruskal_validation.R`  
    Test revenue differences across behavioral segments.

13. `13_revenue_dunn_posthoc.R`  
    Identify pairwise revenue differences using Dunn’s post-hoc tests.

14. `14_fd_vs_fde_comparison.R`  
    Compare the managerial validation performance of FD and FDE representations.

15. `15_fd_vs_fde_dunn_comparison.R`  
    Compare pairwise revenue differences between FD and FDE representations.


## Reproducibility

To run the complete analysis pipeline, execute:

```r
source("code/run_all.R")
```

## Running individual scripts

Each script can also be executed separately when inspecting specific analytical steps.  
Run the scripts in sequential order to ensure that required objects generated in previous steps are available.

Example:

```r
source("code/01_data_preprocessing.R")
source("code/02_behavioral_descriptors.R")
source("code/07_customer_segmentation.R")
```
