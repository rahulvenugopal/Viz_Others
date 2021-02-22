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

![Data peek](https://github.com/rahulvenugopal/Viz_Others/blob/master/Box_Point/sample_data.png)

Data looked like this

![Final plot](https://github.com/rahulvenugopal/Viz_Others/blob/master/Box_Point/stroop_order.png)

Code [here](https://github.com/rahulvenugopal/Viz_Others/blob/master/Box_Point/plotemall.py)

> Things I learned from this dataviz
1. My first box+strip plot
2. I could bring a smile to the person who had only 1 hour left to do entire graphing
3. learned how to pick data from multiple columns, generate plot, save and loop

> Yet To Do
1. Removing one label
2. Color palette customisation (learned it later)
3. Learn how to automate creating a large csv from multiple based on some logic
---
## Batchmode Excel to PDF converter
There were ~100s of excel files which had to be converted to PDF

This was more of a challenge than utility hack
> Things I learned
1. Came across this opensource and free utility called [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html)
2. File converting was fun :happy:
> To Do
1. Styling of dataframe for a highlighted and aesthetic html
2. Similar converters for .doc and .docx files
---
## Mean + CI skirt for 12 groups data acquired throughout the day
![Data peek](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/data.png)

Data looked like this

Data had Groups column with 2 levels, Intervention with 2 levels, Recording time point 2 levels and Phase with 2 levels

As a combination there were 12 group combinations

Phase levels (Light and Dark were exclusive)

So, the idea was to represent Phase levels using color (Hours 0-12 with light color and 12-24 in dark color)

![Phase colors](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/light_dark.jpg)

That leaves 6 groups to plot

![Scatter plot](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/scatter_plot.jpg)

I will leave out some attempts to capture all groups in a single plot. Far from complete :unamused:

![Two steps away](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/Phase_Four_Groups.jpg)

The color palette is not standing out in background. The CI skirts are swallowed :unamused:

![Aesthetic but one group](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/Simple_Seabron_facet.jpg)

Phase(Light and Dark are captured) but no group info :unamused:

---

Got back to this Viz. Created a gridplot using `patchwork`

Linetypes captures BL vs PE

Linecolor captures four groups - Group+Intervention

![All_four](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/all_four.jpg)

---

Got the plot to work after some brainstorming!

Patchwork to rescue to stitch four plots

![Final Four](https://github.com/rahulvenugopal/Viz_Others/blob/master/Multiple_groups_mean_CI_skirt/images/all_four_final.jpg)

Detailed documentation provided in script `plotsleep_fourcol.R`

---
## Distribution-KDE | Histogram | Point | Box dataviz
I was inspired by the plot from Anat Arzi's recent nature paper

![Inspire](https://pbs.twimg.com/media/EWyhI7qXYAEaAra.jpg)

- We had four groups
- Reordered the x-axis sequence
- Custom color palette
- New tricks from Cederic Scherer's [talk](https://z3tt.github.io/OutlierConf2021/)
- ggtext based styling

Code is [here](https://github.com/rahulvenugopal/Viz_Others/blob/master/Box_point_violin_histo/data_vert.R)

![Final](https://github.com/rahulvenugopal/Viz_Others/blob/master/Box_point_violin_histo/Perceived_stress.jpeg)

---
## Survey barplot with count label
![Barplot](https://github.com/rahulvenugopal/Viz_Others/blob/master/Survey/country_part.jpg)
- Count of participants from various countries

Code is [here](https://github.com/rahulvenugopal/Viz_Others/blob/master/Survey/dream_survey.R)

---
## Finding missing values | KDE | Robust correlations
![Missing value 1](https://github.com/rahulvenugopal/Viz_Others/blob/master/missing_correlation_KDE/MissingValues.png)

![Missing value 2](https://github.com/rahulvenugopal/Viz_Others/blob/master/missing_correlation_KDE/mising_counts_percentages.png)

![Summary](https://github.com/rahulvenugopal/Viz_Others/blob/master/missing_correlation_KDE/describe_summary.png)

## Robust correlations
![Robust Cor](https://github.com/rahulvenugopal/Viz_Others/blob/master/missing_correlation_KDE/correlation_plot_new.jpeg)

## KDE plots
![KDE](https://github.com/rahulvenugopal/Viz_Others/blob/master/missing_correlation_KDE/KDE.jpeg)

Code is [here](https://github.com/rahulvenugopal/Viz_Others/blob/master/missing_correlation_KDE/missing_cor_KDE_demo.R)