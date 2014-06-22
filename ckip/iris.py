import Orange
iris = Orange.data.Table("ckip_ed_all_reducedu.csv")

#iris = Orange.data.Table("iris")

matrix = Orange.misc.SymMatrix(len(iris))
matrix = Orange.distance.distance_matrix(iris, Orange.distance.PearsonR)

clustering = Orange.clustering.hierarchical.HierarchicalClustering()
clustering.linkage = Orange.clustering.hierarchical.WARD
root = clustering(matrix)

root.mapping.objects = iris