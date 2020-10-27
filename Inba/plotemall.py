# -*- coding: utf-8 -*-
"""
Created on Wed Mar  4 17:16:13 2020

@author: Rahul Venugopal
"""

#%% Importing libraries
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


#%% Color Trial
color_data = pd.read_csv('I:/Inba/Colour_Trial.csv')

sns_plot = sns.boxplot(data=color_data, x='Group', y='Colour_Trial_Test_1',
                       hue="Order")  
sns_plot = sns.stripplot(data=color_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Group', y='Colour_Trial_Test_1',
                         hue="Order")  
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('I:/Inba/color_test1',dpi=300 )
plt.clf()

sns_plot = sns.boxplot(data=color_data, x='Group', y='Colour_Trial_Test_2',
                       hue="Order")  
sns_plot = sns.stripplot(data=color_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Group', y='Colour_Trial_Test_2',
                         hue="Order")  
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('I:/Inba/color_test2',dpi=300 )
plt.clf()
#%% Digit Span forward backward
digitspan_data = pd.read_csv('I:/Inba/NEW Digit_span_Forward_Backward.csv')  

for col in digitspan_data.columns[2:5]:
    sns_plot = sns.boxplot(data=digitspan_data, x='Group', y=col,
                       hue="Order")  
    sns_plot = sns.stripplot(data=digitspan_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Group', y=col,
                         hue="Order")  
    
    sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
    plt.figure(figsize=(6, 5)) 
        
    plt.figure()  
    sns_plot.figure.savefig('I:/Inba//'+col,dpi=300 )
    plt.clf()

#%% Perceived Stress
perceivedstress_data = pd.read_csv('I:/Inba/Perceived_Stress.csv')  

sns_plot = sns.boxplot(data=perceivedstress_data, x='Group', y='Perceived_Stress_Scale',
                       hue="Order")  
sns_plot = sns.stripplot(data=perceivedstress_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Group', y='Perceived_Stress_Scale',
                         hue="Order")  
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('I:/Inba/stress',dpi=300 )
plt.clf()

#%% Total number of problems solved
problems_solved__data = pd.read_csv('I:/Inba/Total_Number_of_Problems_Solved.csv')  

sns_plot = sns.boxplot(data=problems_solved__data,x='Order',hue="Group",y='Total_Number_of_Problems_Solved') 
sns_plot = sns.stripplot(data=problems_solved__data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Order', y='Total_Number_of_Problems_Solved',
                         hue="Group") 
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 6)) 

        
plt.figure()  
sns_plot.figure.savefig('I:/Inba/totalproblemssolved',dpi=300 )
plt.clf()

#%% Stroop test
stroop_data = pd.read_csv('I:/Inba/Stroop_Test .csv')  

sns_plot = sns.boxplot(data=stroop_data, x='Condition', y='Stroop_Test_Condition_Total_Time',
                       hue="Order")  
sns_plot = sns.stripplot(data=stroop_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Condition', y='Stroop_Test_Condition_Total_Time',
                         hue="Order")  
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('I:/Inba/stroop_order',dpi=300 )
plt.clf()

stroop_data = pd.read_csv('I:/Inba/Stroop_Test .csv')  

sns_plot = sns.boxplot(data=stroop_data, x='Condition', y='Stroop_Test_Condition_Total_Time',
                       hue="Group")  
sns_plot = sns.stripplot(data=stroop_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Condition', y='Stroop_Test_Condition_Total_Time',
                         hue="Group")  
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 5)) 

        
plt.figure()  
sns_plot.figure.savefig('I:/Inba/stroop_group',dpi=300 )
plt.clf()

#%% Wordlist
wordlist_data = pd.read_csv('I:/Inba/NEW Word_List_Trial_Test.csv') 

for col in wordlist_data.columns[2:14]:
    sns_plot = sns.boxplot(data=wordlist_data, x='Group', y=col,hue="Order")  
    sns_plot = sns.stripplot(data=wordlist_data,
                             edgecolor="black",linewidth=1,jitter=True
                             ,marker='o',alpha=0.75,dodge=True, x='Group', y=col,
                             hue="Order")  
    
    # get legend information from the plot object
    handles, labels = sns_plot.get_legend_handles_labels()
    
    # specify just one legend
    l = plt.legend(handles[0:2], labels[0:2])
    sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)    
    plt.figure()  
    sns_plot.figure.savefig('I:/Inba//'+col,dpi=300 )
    plt.clf()
    
for col in wordlist_data.columns[2:14]:
    sns_plot = sns.boxplot(data=wordlist_data, x='Order', y=col,hue="Group")  
    sns_plot = sns.stripplot(data=wordlist_data,
                             edgecolor="black",linewidth=1,jitter=True
                             ,marker='o',alpha=0.75,dodge=True, x='Order', y=col,
                             hue="Group")  
    
    # get legend information from the plot object
    handles, labels = sns_plot.get_legend_handles_labels()
    
    # specify just one legend
    l = plt.legend(handles[0:2], labels[0:2])
    sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)    
    plt.figure()  
    sns_plot.figure.savefig('I:/Inba//'+col,dpi=300 )
    plt.clf()
#%% Visual Reproduction
visual_reproduction_data = pd.read_csv('I:/Inba/NEW Visual_Reporoduction_Test.csv') 

for col in visual_reproduction_data.columns[2:14]:
    sns_plot = sns.boxplot(data=visual_reproduction_data, x='Group', y=col,hue="Order")  
    sns_plot = sns.stripplot(data=visual_reproduction_data,
                             edgecolor="black",linewidth=1,jitter=True
                             ,marker='o',alpha=0.75,dodge=True, x='Group', y=col,
                             hue="Order")  
    
    # get legend information from the plot object
    handles, labels = sns_plot.get_legend_handles_labels()
    
    # specify just one legend
    l = plt.legend(handles[0:2], labels[0:2])
    sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)    
    plt.figure()  
    sns_plot.figure.savefig('I:/Inba//'+col,dpi=300 )
    plt.clf()    

for col in visual_reproduction_data.columns[2:14]:
    sns_plot = sns.boxplot(data=visual_reproduction_data, x='Order', y=col,hue="Group")  
    sns_plot = sns.stripplot(data=visual_reproduction_data,
                             edgecolor="black",linewidth=1,jitter=True
                             ,marker='o',alpha=0.75,dodge=True, x='Order', y=col,
                             hue="Group")  
    
    # get legend information from the plot object
    handles, labels = sns_plot.get_legend_handles_labels()
    
    # specify just one legend
    l = plt.legend(handles[0:2], labels[0:2])
    sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)    
    plt.figure()  
    sns_plot.figure.savefig('I:/Inba//'+col,dpi=300 )
    plt.clf()    

#%% Digit symbol
digit_symbol_data = pd.read_csv('I:/Inba/Digit_Symbol_Substution_Test.csv')  

sns_plot = sns.boxplot(data=digit_symbol_data, x='Group', y='Digit_Symbol_Substution_Test',
                       hue="Order")  
sns_plot = sns.stripplot(data=digit_symbol_data, edgecolor="black",linewidth=1,
                         jitter=True,marker='o',alpha=0.75,dodge=True, x='Group', y='Digit_Symbol_Substution_Test',
                         hue="Order")  
    
sns_plot.legend(bbox_to_anchor=(0.5, 1), ncol=2)
plt.figure(figsize=(4.5, 5)) 
sns_plot.figure.savefig('I:/Inba/digit_symbol',dpi=300)    

















