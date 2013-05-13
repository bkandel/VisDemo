require(ANTsR)
dim <- 3
#template <- antsImageRead('template_cerebrummask.nii.gz', 3)
template <- antsImageRead('glasshead.nii.gz', 3)
brain <- antsImageRead('glassbrain.nii.gz', 3)
leftright <- antsImageRead('leftright.nii.gz', 3)
template <- maskImage(template, leftright, 1)
brain <- maskImage(brain, leftright, 1)

labels <- antsImageRead( 'cbf_labels.nii.gz', 3 )
network <- antsImageRead('male_dc_aslconn.nii.gz', 2)
labels <- antsImageRead('nirep.nii.gz',3)
network0 <- antsImageRead('age10network.nii.gz',2)
network1 <- antsImageRead('age40network.nii.gz',2)
network2 <- antsImageRead('age77network.nii.gz',2)
gc()
centroids <- LabelImageCentroids( labels, physical=TRUE )


lateralLeft <- rotationMatrix(pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)
mysurf <- renderSurfaceFunction(list(template,brain), alphasurf=c(0.3,0.3), surfval=0.5, smoothsval=1.5,  alphafunc=1, mycol="cadetblue1")
n<-64
subnet0 <- reduceNetwork( network0, N=n )
subnet1 <- reduceNetwork( network1, N=n )
subnet2 <- reduceNetwork( network2, N=n )
mynet<-subnet0
locations <- list( vertices=centroids$vertices[mynet$nodelist,] )
renderNetwork( mynet$network, locations )
rgl.snapshot('age10s.png')
rgl.pop()
mynet<-subnet1
locations <- list( vertices=centroids$vertices[mynet$nodelist,] )
renderNetwork( mynet$network, locations )
rgl.snapshot('age40s.png')
rgl.pop()
mynet<-subnet2
locations <- list( vertices=centroids$vertices[mynet$nodelist,] )
renderNetwork( mynet$network, locations, lwd=2 )
rgl.snapshot('age77s.png')
# try gc to reduce memory
gc()

# par3d(userMatrix=lateralLeft, windowRect=c(25,25,325,325), zoom=0.7)
# rgl.snapshot("lateral_network.png")
# movie3d(spin3d(),duration=10, movie='spin_network',clean=T, dir=getwd(), fps=15)




