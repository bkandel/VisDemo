require(ANTsR)
dim <- 3
template <- antsImageRead('template_cerebrummask.nii.gz', 3)
labels <- antsImageRead( 'cbf_labels.nii.gz', 3 )
network <- antsImageRead('male_dc_aslconn.nii.gz', 2)
gc()

lateralLeft <- rotationMatrix(pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)
mysurf <- renderSurfaceFunction(list(template), alphasurf=c(0.3))

centroids <- LabelImageCentroids( labels, physical=TRUE )
subnet <- reduceNetwork( network, N=50 )
locations <- list( vertices=centroids$vertices[subnet$nodelist,] )
renderNetwork( subnet$network, locations )

# try gc to reduce memory
gc()

par3d(userMatrix=lateralLeft, windowRect=c(25,25,325,325), zoom=0.7)
rgl.snapshot("lateral_network.png")
movie3d(spin3d(),duration=10, movie='spin_network',clean=T, dir=getwd(), fps=15)
 
# rm(mysurf.wm)

#mysurf.gm <- renderSurfaceFunction(list(template.left), list(gm.left), 
#                                   surfval=0.5, smoothsval=1.5, alphasurf=c(0.3, 0.3), 
#                                   smoothfval=1.5, alphafunc=1, mycol="firebrick1")
#gc()
#par3d(userMatrix=lateralLeft, windowRect=c(25,25,325, 325),zoom=0.7)
#rgl.snapshot("lateral_gm.png")
#movie3d(spin3d(),duration=10, movie='spin_gm',clean=T, dir=getwd(), fps=15)



