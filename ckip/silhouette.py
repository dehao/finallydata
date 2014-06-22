import Orange

voting = Orange.data.Table("ckip_ed_all_reducedu.csv")
# table = Orange.data.Table("iris")
print "Doneread:"
#for k in range(357, 377):
#    km = Orange.clustering.kmeans.Clustering(voting, k, initialization=Orange.clustering.kmeans.init_diversity, distance=Orange.distance.PearsonR)
#    score = Orange.clustering.kmeans.score_fast_silhouette(km)
#    print k, score

km = Orange.clustering.kmeans.Clustering(voting, 10, initialization=Orange.clustering.kmeans.init_diversity, distance=Orange.distance.PearsonR)
Orange.clustering.kmeans.plot_silhouette(km, "kmeans-silhouette.png")