# -*- coding: utf-8 -*-
"""
Created on Wed Mar  4 17:16:13 2020
Quick dirty plots
@author: Rahul Venugopal
"""

#%% Importing libraries
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


#%% Digit Span forward backward
digitspan_data = pd.read_csv('I:/NEW Digit_span_Forward_Backward.csv')  

for col in digitspan_data.columns[2:5]:
    sns_plot = sns.boxplot(data = digitspan_data, x = 'Group', y = col,
                       hue = "Order")  
    sns_plot = sns.stripplot(data = digitspan_data, edgecolor = "black",linewidth = 1,
                         jitter = True, marker = 'o', alpha = 0.75,
                         dodge = True, x = 'Group', y = col,
                         hue = "Order")  
    
    sns_plot.legend(bbox_to_anchor = (0.5, 1), ncol = 2)
    plt.figure(figsize = (6, 5)) 
        
    plt.figure()  
    sns_plot.figure.savefig('I:/Home//'+col,dpi = 300)
    plt.clf() # Clear figure


#%% Stroop test
stroop_data = pd.read_csv('I:/Stroop_Test .csv')  

sns_plot = sns.boxplot(data = stroop_data, x ='Condition',
                       y='Stroop_Test_Condition_Total_Time',
                       hue = "Order")  
sns_plot = sns.stripplot(data = stroop_data, edgecolor = "black",linewidth = 1,
                         jitter = True,marker = 'o',alpha = 0.75,
                         dodge = True, x = 'Condition',
                         y = 'Stroop_Test_Condition_Total_Time',
                         hue = "Order")  
    
sns_plot.legend(bbox_to_anchor = (0.5, 1), ncol = 2)
plt.figure(figsize = (4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('stroop_order',dpi = 300 )
plt.clf()

stroop_data = pd.read_csv('Stroop_Test .csv')  

sns_plot = sns.boxplot(data = stroop_data, x = 'Condition',
                       y = 'Stroop_Test_Condition_Total_Time',
                       hue = "Group")  
sns_plot = sns.stripplot(data = stroop_data, edgecolor = "black",linewidth = 1,
                         jitter = True,marker = 'o',alpha = 0.75,
                         dodge = True, x = 'Condition',
                         y = 'Stroop_Test_Condition_Total_Time',
                         hue = "Group")  
    
sns_plot.legend(bbox_to_anchor = (0.5, 1), ncol = 2)
plt.figure(figsize = (4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('stroop_group',dpi = 300 )
plt.clf()
