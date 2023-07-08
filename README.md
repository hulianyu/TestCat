# TestCat
assess the clusterability of categorical data



To run the testing-based approach, execute `demo.m` (for Matlab) or `demo.R` (for R). These scripts call the functions defined in `TestCat.m` or `TestCat.R`, and `count_attribute_pairs.m` or `count_attribute_pairs.R` respectively.



For the compared methods, the following scripts run the respective methods:

- `DistanceMethods.R` (2 methods): Dip-dist, Silv-dist
- `DimensionalityReductionMethods.R` (6 methods): MDS Dip, MDS Silv, tSNE Dip, tSNE Silv, UMAP Dip, UMAP Silv
- `EmbeddingMethods.R` (4 methods): PCA Dip, PCA Silv, SPCA Dip, SPCA Silv
