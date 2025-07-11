# 10 JULY 2025
# PYMOL RENDERING FOR ACTIVE NHE1 W/ CALCINEURIN REMOVED
# MIT LICENSE

fetch 7DSX
remove solvent
rotate x,90

# remove calcineurin
remove chain C+D

# color whole protein tv_green
color tv_green, chain A
color gray80, chain B

# color long c-terminal blue
color tv_blue, chain A and resi 520-600
color cyan, chain B and resi 520-600

# show cariporide as spheres and color orange
show spheres, resn HG0
color tv_orange, resn HG0

# cartoon-style rendering
set specular, 0
set ray_trace_gain, 0 
set ray_trace_mode, 3
bg_color white
set ray_trace_color, black
unset depth cue

ray 4000 
save nhe1-active-cariporide-01.png
