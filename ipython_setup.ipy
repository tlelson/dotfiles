## This allows different ipython setup for each conda environment
## simply put a file named 'ipython_setup.py' in the root env directory
## find by:
##      $ echo ${CONDA_PREFIX}


## Setup --------------------------------------------------------------------##
import os
import sys

try:  # ... get the conda environment location
    env_pth = os.environ['CONDA_ENV_PATH']
except KeyError:
    # Try looking in executable path (this happen inside PyCharm)
    if 'envs' in sys.executable:
        pth1, pth2 = sys.executable.split('envs/')
        env = pth2.split('/')[0]
        env_pth = os.path.join(pth1, 'envs', env)
    else:
        env_pth = None

# Try find the setup file ...
if env_pth:
    config_file = os.path.join(env_pth, 'ipython_setup.py')
    try:
        exec(open(config_file).read())
    except IOError:
        print("No env specific 'ipython_setup.py' found in {} ...".format(env_pth))
        del config_file
else:
    print("Not in a conda environment ...")

## Global Config -----------------------------------------------------------------##

# Ipython stuff
%load_ext autoreload
%autoreload 2
