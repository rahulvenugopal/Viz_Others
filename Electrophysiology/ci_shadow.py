"""
Created on Wed Oct 14 19:48:32 2020

Create Visualisation for electrophysiology data
Across time, there is a electrophysiology measure
Each time point, there would be measurements from n number of slices
These n slices can be from different animals
Using estimator as mean and CI 95% to capture location & spread
Melting done only for slice columns and Group identity retained
Group 1 has 8 slices, Group 2 and 3 has 12 slices data coming in
So nan are filled in Group 1

@author: Rahul Venugopal
"""
#%% Loading libraries
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

#%% Loading data
data = pd.read_excel("data_ltp.xlsx")

#%% Melting the dataframe
data_reshaped =  pd.melt(data,id_vars=['Time (in mins)',"Group"],
                     var_name ='slice',
                     value_name ='fEPSP')
#%% Theming and fonts
font = {'family': 'Helvetica',
        'color':  'black',
        'weight': 'normal',
        'size': 14,
        }
sns.set_style("ticks")

# Setting custom palette
colors = ["#756BB1", "#31A354", "#DE2330"]
# I had a palette in mind and those were in RGB values
# RGB
#G1 117 107 177
#G2 49 163 84
#G3 222 35 48

# You may use the below to convert them to hex values
# https://www.rgbtohex.net/ RGb to HEX

# Adding custome colors to palette
sns.set_palette(sns.color_palette(colors))

# Plotting data
sns_plot = sns.lineplot(data = data_reshaped,
             x = "Time (in mins)",
             y = "fEPSP",
             hue = "Group",
             ci = 68,
             err_style = "band",
             hue_order = ["NC", "VSL","VC"]) # These are three groups

# Setting x and y limits
plt.ylim(0.5,2.5)
plt.xlim(0,85)

# Add title
plt.title('Electrophysiology Plot', fontdict=font)

# Set x-axis label
plt.xlabel('Time (minutes)', fontdict=font)
# Set y-axis label
plt.ylabel('Normalised fEPSP slope', fontdict=font)

# Adding vertical and horitontal lines
plt.vlines(x = 20, ymin = 0.5,
           ymax = 1, colors='black', ls=':', lw=2,
           linestyles = 'dotted', alpha = 0.5)
plt.axhline(y = 1, color = 'black', ls = ':', lw = 2,
            dash_capstyle = 'round', alpha = 0.5)

# Adding filler
plt.axhspan(0.25, 1, facecolor ='#F8EEE1', alpha = 0.3) 

plt.savefig('slice_electro.tiff', dpi = 600)

# Useful resources
# https://stackoverflow.com/questions/24988448/how-to-draw-vertical-lines-on-a-given-plot-in-matplotlib