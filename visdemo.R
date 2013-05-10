require(ANTsR)
dim <- 3
template <- antsImageRead('glasshead.nii.gz', 3)
brain <- antsImageRead('glassbrain.nii.gz', 3)
wm <- antsImageRead('WM_smoothed.nii.gz', 3)
gm <- antsImageRead('GM_glassbrain.nii.gz', 3)
leftright <- antsImageRead('leftright.nii.gz', 3)
template.left <- maskImage(template, leftright, 1)
brain.left <- maskImage(brain, leftright, 1)
wm.left <- maskImage(wm, leftright, 1)
gm.left <- maskImage(gm, leftright, 1)
gc()
lateralLeft <- rotationMatrix(pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)

  mysurf.wm <- renderSurfaceFunction(list(template.left, brain.left), list(wm.left), 
                surfval=0.5, smoothsval=1.5, alphasurf=c(0.3, 0.3), 
                                  alphafunc=1, mycol="cadetblue1")

# try gc to reduce memory
gc()

 par3d(userMatrix=lateralLeft, windowRect=c(25,25,325,325), zoom=0.7)
 rgl.snapshot("lateral_wm.png")
 movie3d(spin3d(),duration=10, movie='spin_wm',clean=T, dir=getwd(), fps=15)
 
 rm(mysurf.wm)

mysurf.gm <- renderSurfaceFunction(list(template.left), list(gm.left), 
                                   surfval=0.5, smoothsval=1.5, alphasurf=c(0.3, 0.3), 
                                   smoothfval=1.5, alphafunc=1, mycol="firebrick1")
gc()
par3d(userMatrix=lateralLeft, windowRect=c(25,25,325, 325),zoom=0.7)
rgl.snapshot("lateral_gm.png")
movie3d(spin3d(),duration=10, movie='spin_gm',clean=T, dir=getwd(), fps=15)



