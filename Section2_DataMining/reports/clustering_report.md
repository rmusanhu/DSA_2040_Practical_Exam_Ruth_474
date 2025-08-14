# Clustering Analysis Report

The K-Means model achieved an Adjusted Rand Index (ARI) of 0.716, indicating moderate to strong agreement between predicted clusters and true species. The highest alignment is seen with *setosa*, which is clearly separated in petal dimensions. However, some misclassifications occur between *versicolor* and *virginica*, which overlap in feature space .

The elbow curve shows a clear bend at k=3, confirming that three clusters are optimal. This supports the biological reality of three species and validates our choice of k.

Visually, the cluster centroids (red X) are well-placed within their respective groups. Minor errors arise due to the algorithm’s assumption of spherical clusters, while real classes have slight elliptical spread.

In real-world applications, K-Means is useful for customer segmentation, image compression, and anomaly detection. Even with synthetic data, the results would be similar if cluster structure is preserved. Overall, this task demonstrates how unsupervised learning can uncover hidden patterns in data without using class labels.