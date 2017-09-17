#!/usr/bin/env python

import subprocess, re

res = subprocess.Popen("""egrep -r 'import' *""",  stdout=subprocess.PIPE, shell=True).communicate()
string = res[0].split('\n')

modules = []

for line in string:
    if re.search(r"#.*import", line):
        # the import is commented out
        continue
    
    mObj1 = re.search(r"import (\w+) as.*$", string[4])
    modules = [mObj1.group(1)]
    
    mObj2 = re.search(r"import ([\w\s,]+).*$", string[5])
    mods = mObj2.group(1).replace(' ','').split(',')
    modules.extend(mods)

paths = []
for mod in set(modules):
    #import pdb; pdb.set_trace()
    var = __import__(mod)
    try:
        path = var.__file__
        mObj3 = re.search(r"(^.*/)__init__\.py[c]*$", path)
        
        if mObj3:
            paths += [mObj3.group(1)]
        else:
            mObj4 = re.search(r"(^.*/.*\.py)[c]*$", path)
            paths += [mObj4.group(1)]

    except AttributeError : 
        pass

cmd = """ctags -L -  --fields=+iaS --extra=+q --language-force=python --python-kinds=-i %s """ % ' '.join(paths)
#res = subprocess.Popen( cmd,  stdout=subprocess.PIPE, shell=True).communicate()
print cmd
#print paths

#return ' '.join(paths)
