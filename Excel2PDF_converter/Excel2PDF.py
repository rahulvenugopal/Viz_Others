# -*- coding: utf-8 -*-
"""
Created on Thu May 28 09:21:35 2020
This script helps to save excel files into PDF in batch
Currently this will automatically take .xls and .xlsx formats
Currently the flow is Excel file --> Pandas dataframe --> HTML --> PD

Dependencies:
    Download wkhtmltopdf from https://wkhtmltopdf.org/downloads.html and install
    This is a HTML to PDF render which runs without any display
    After installing, this can be used standalone also. Refer documentation
    https://wkhtmltopdf.org/index.html
    
@author: Rahul Venugopal
"""
#%% Loading libraries and getting paths and files
import os
import pandas as pd
import pdfkit
from tkinter.filedialog import askdirectory
from tkinter import Tk

# Manually select the folder where all excel files are stored
root = Tk()
root.withdraw()
path = askdirectory(title = "Select the folder with excel files")
root.destroy() # To close the gui remnants (a bug in "tkinter")

# Changing working directory to path where we have all the files
os.chdir(path)

# Loads all excel files within the folder [Old and new versions]
files = [f for f in os.listdir(path) if (f.endswith('.xls') or f.endswith('.xlsx'))]

# Setting configuration file
config = pdfkit.configuration(wkhtmltopdf='C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe')
# This was set like this because for some weird reason even after adding the exe to system path
# python was not able to find it

# Looping through each file
for file in range(len(files)):
    excel_path = files[file]
    df = pd.read_excel(excel_path)

    # Getting the name for PDF files
    pdf_file = os.path.splitext(files[file])[0]+'.pdf'
    
    f = open('dummy.html','w')
    # The dataframe read from excel file is converted to html
    # Styling can be done to make beautiful html from dataframes
    data_in_html = df.to_html(index=False,border=1, justify = 'center',bold_rows=False)
    # border=1 will give borders. More options are available
    # https://pandas.pydata.org/pandas-docs/version/0.23.4/generated/pandas.DataFrame.to_html.html
    
    f.write(data_in_html)
    f.close()
    
    pdfkit.from_file('dummy.html', pdf_file,configuration = config)

#%% Future enhancements
"""
1. Styling of dataframe for a highlighted and aesthetic html
2. Similar converters for .doc and .docx files
"""