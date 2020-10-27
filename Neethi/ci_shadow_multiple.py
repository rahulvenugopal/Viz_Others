"""
Created on Tue Oct 27 19:48:32 2020
To visualise sleep data across
multiple groups (in each column)


@author: Rahul Venugopal
"""
#%% Loading libraries
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

#%% Loading data
data = pd.read_csv("data.csv")

#%% Theming
font = {'family': 'Helvetica',
        'color':  'black',
        'weight': 'normal',
        'size': 14,
        }
sns.set_style("ticks")

# Setting custom palette
colors = ["#f05454", "#e94560", "#f9813a","#0e918c"]
# https://www.rgbtohex.net/ RGb to HEX

sns.set_palette(sns.color_palette(colors))

# Getting group combinations
data["Hue"] = data["Group"] + data["Intervention"]

# Plotting data
sns_plot = sns.lineplot(data = data,
             x = "Zeitgeber_Time",
             y = "Sleep",
             hue = "Hue",
             ci = 68,
             err_style = "band")
plt.xlim(0,24)

# Add title
plt.title('Sleep Data', fontdict=font)
# Set x-axis label
plt.xlabel('Time (Hours)', fontdict=font)
# Set y-axis label
plt.ylabel('Sleep Parameter', fontdict=font)

# Adding filler
plt.axvspan(0, 12, facecolor ='#e5de44', alpha = 0.8) 
plt.axvspan(12, 24, facecolor ='#001a26', alpha = 0.8) 

plt.savefig('plot.tiff', dpi = 600)

# Useful resources
# https://stackoverflow.com/questions/24988448/how-to-draw-vertical-lines-on-a-given-plot-in-matplotlib