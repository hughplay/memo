# Visualization using ChimeraX

## plot molecular
# comands: https://www.cgl.ucsf.edu/chimerax/docs/user/tools/moldisplay.html
style stick
color #1.271 byelement transparency 70
hide #1.1-361 target m
show #1.241,271,301,331,361 target m

windowsize 700 700
view matrix camera 0.93651,0.013377,-0.35039,-20.83,0.2327,-0.77122,0.59251,34.296,-0.2623,-0.63642,-0.72537,-44.217
view matrix models #1,1,0,0,0,0,1,0,0,0,0,1,0,#1.1,1,0,0,0,0,1,0,0,0,0,1,0,#2,1,0,0,0,0,1,0,0,0,0,1,0,#3,1,0,0,0,0,1,0,0,0,0,1,0
lighting flat shadows true intensity 0.5
graphics silhouettes true width 1
color sel #4a669dff
select clear

select #2/A
select sel :< 6 & ~sel


mol:
view matrix camera -0.74332,0.56832,-0.35282,-4.5651,-0.10434,-0.61948,-0.77804,-12.18,-0.66075,-0.54152,0.51978,4.13
view matrix models #1,1,0,0,0,0,1,0,0,0,0,1,0,#1.1,1,0,0,0,0,1,0,0,0,0,1,0,#1.1.1,1,0,0,0,0,1,0,0,0,0,1,0,#2,1,0,0,0,0,1,0,0,0,0,1,0,#3,1,0,0,0,0,1,0,0,0,0,1,0

complex:
view matrix camera 0.018061,0.50236,0.86447,80.123,0.23771,0.83766,-0.49175,-9.9675,-0.97117,0.21437,-0.10429,-12.228
view matrix models #1,1,0,0,0,0,1,0,0,0,0,1,0

select ligand
color sel dark orange
color sel byhetero
sel clear

pure molecule:
color sienna

genpack:
window 700 500

view matrix camera 0.29501,0.82117,0.48851,53.288,0.86118,-0.44999,0.23638,50.756,0.41393,0.35096,-0.83993,-76.306
view matrix models #1,1,0,0,0,0,1,0,0,0,0,1,0

lighting flat shadows true intensity 0.5
graphics silhouettes true width 1

hide ligand
select protein
color sel gray

select ligand
select sel :< 6 & ~sel
color sel #4a669dff
show sel target ab


hide sel target a
sel clear
