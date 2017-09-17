#!/usr/bin/env python

## This script creates aws credentials from the temporary ones alloted to the EC2 by IAM
## Only certain applications require this format (e.g serverless). Boto3 will
## automatically get these credentials.

## On linux add a crontab
# 51 * * * * bash -login -c "python ~/dotfiles/get_aws_creds.py""

import urllib2
import json
import os
import os.path as pt
import sys

url = "http://169.254.169.254/latest/meta-data/iam/security-credentials/gotopo-dev-role"
ret = json.loads(urllib2.urlopen(url).read())

if not ret['Code'] == 'Success':
    sys.exit(1)  # fail

# Write a file
target_dir = pt.join(pt.expanduser("~"), ".aws")
if not pt.exists(target_dir):
    os.makedirs(target_dir)

credential_string = '''
[role-credentials]
aws_access_key_id = {}
aws_secret_access_key = {}
'''

with open(pt.join(target_dir, 'credentials'), 'w+') as f:
    f.write(credential_string.format(ret['AccessKeyId'], ret['SecretAccessKey']))



