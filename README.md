# Clusterability test for categorical data
https://link.springer.com/article/10.1007/s10115-024-02317-x 

[[PDF] arxiv.org](https://arxiv.org/pdf/2307.07346)

[![DOI](https://zenodo.org/badge/660497386.svg)](https://zenodo.org/badge/latestdoi/660497386)

To run the clusterability method, execute `demo.m` (for Matlab) or `demo.R` (for R). These scripts call the functions defined in `TestCat.m` or `TestCat.R`, and `count_attribute_pairs.m` or `Count_attribute_pairs.R` respectively.



For the compared methods, the following scripts run the respective methods:

- `DistanceMethods.R` (2 methods): Dip-dist, Silv-dist
- `DimensionalityReductionMethods.R` (6 methods): MDS Dip, MDS Silv, tSNE Dip, tSNE Silv, UMAP Dip, UMAP Silv
- `EmbeddingMethods.R` (4 methods): PCA Dip, PCA Silv, SPCA Dip, SPCA Silv

## Citation

If you find my code useful please consider citing:

    @article{Hu2025Clusterability,
      title={Clusterability test for categorical data},
      author={Hu, Lianyu and Dong, Junjie and Jiang, Mudi and Liu, Yan and He, Zengyou},
      journal={Knowledge and Information Systems},
      year={2025},
      doi={10.1007/s10115-024-02317-x}
    }
