## Electrophysiology data
![Data peek](https://github.com/rahulvenugopal/Viz_Others/blob/master/Electrophysiology/data_head.png)
Data looked like this

There were three groups. Electrophysiology parameter was measured every 30 seconds
This data came from multiple slices from multiple animals

Typically this is the way many researchers plot
![Horrible plot](https://github.com/rahulvenugopal/Viz_Others/blob/master/Electrophysiology/horrible_plot.jpg)

Weird graphing softwares add their horrible palettes with meshes and grids.
With more than 4 groups the entire visualisation gets muddy :weary:

Enter seaborn + matplotlib. ![Kickass](https://github.com/rahulvenugopal/Viz_Others/blob/master/Electrophysiology/mean_CI_skirt.jpeg)

Code updated [here](https://github.com/rahulvenugopal/Viz_Others/blob/master/Electrophysiology/ci_shadow.py)

> Things I learned from this dataviz
1. Melting dataframes
2. Color palette customisation
3. Adding background fills
---
## Boxplots plus Strip plots
This set was just an average, quick and dirty requirement

There were heaps of excel sheets and need of the hour was box+point plots across two groups
Graphs were not visually pleasing :weary:
But the job was done!
Code [here](https://github.com/rahulvenugopal/Viz_Others/blob/master/Inba/plotemall.py)




