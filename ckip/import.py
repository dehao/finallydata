import os
import hashlib

download_dir = "/Users/dehao/github/Lydata/issckip/C1/"
save_dir = "/Users/dehao/github/Lydata/issckip/C1parse/"
clustertxt = "/Users/dehao/github/Lydata/issckip/C1cluster.txt"

'''
#clusteropen = open(clustertxt, 'r')
with open(clustertxt, 'r') as f:
    next(f)
    for line in f:
        split = line.split('	')
        print split[0]
        print split[1]
'''
'''
FileList = os.listdir(download_dir)
for File in FileList:
'''
with open(clustertxt, 'r') as f:
	next(f)
	for line in f:
		split = line.split('	')
		print split[0]
		File = split[1].strip("\n")
		print File
		extension = split[0]
		name = split[1]
		ext = extension

		if os.path.isdir(download_dir + File):
			pass

		elif os.path.exists(save_dir + ext + "/" + File):
				Data = open(download_dir + File, "r").read()
				m = hashlib.sha1() 
				m.update(Data) 
				h = (m.hexdigest())[0:5]
				file(save_dir + ext + "/" +name+"-"+h+"."+ext, "w").write(Data)
				print File, " ","-->"," ",name+"-"+h+"."+ext
				os.remove(download_dir + File)

		elif os.path.exists(save_dir + ext):
				Data = open(download_dir + File, "r").read()
				file(save_dir + ext + "/" + File, "w").write(Data)
				print File #, " ","-->"," ",name+"."+ext
				os.remove(download_dir + File)

		elif os.path.exists(save_dir + ext) != True:
				os.makedirs(save_dir + ext)
				Data = open(download_dir + File, "r").read()
				file(save_dir + ext + "/" + File, "w").write(Data)
				print File , " ","-->"," ","/"+ext+"/"+name+"."+ext
				os.remove(download_dir + File)


