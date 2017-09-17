# # Put the following in your ipython default profile OR
# ... for PyCharm
# # Load ipython default config
# config_file = r'~/Code/dotfiles/ipython_science_config.py
# exec(open(config_file).read())

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import tims_py_utils.pandas_utils as tpu
import tims_py_utils.py_utils as tu
pd.set_option('display.max_columns', 12)
pd.set_option('display.max_rows', 10)
pd.set_option('display.width', 500)

#get_ipython().magic('precision %.3e')# Floats to display 3 decimal places in exponential notation

custom_style = {
    'axes.edgecolor': '#FAFAFA',
    'axes.facecolor': '#313131',
    'figure.facecolor': '#313131',
    'axes.labelcolor': '#FAFAFA',
    'axes.grid': True,
    'grid.linestyle': u'-',
    'axes.linewidth': 1.5,
    'grid.color': '#717171',
    'text.color': '#FAFAFA',
    'xtick.color': '#FAFAFA',
    'ytick.color': '#FAFAFA',
    'legend.numpoints': 2
}
# import warnings
# warnings.filterwarnings('always')
#import seaborn as sns
#sns.set_style("darkgrid", rc=custom_style)
#PALERED = '#d65f5f'
#RED = sns.xkcd_rgb["pale red"]
#BLUE = '#5C81C4'
#DARKBLUE = sns.xkcd_rgb["denim blue"]
#GREEN = sns.xkcd_rgb["medium green"]
