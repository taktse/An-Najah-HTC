#!/usr/bin/python

import yaml
import collections
import sys
import re

if __name__ == '__main__':

    try:
        hostname = sys.argv[1]
    except:
        print "ERROR: You must pass a hostname"
        sys.exit(1)

    enc = {}
    enc['classes'] = {}
    node_class = 'desktop'
    node_types = collections.OrderedDict()
    node_types['htcxxx'] =                 '^htc'
    for type in node_types.keys():
        if re.match(node_types[type], hostname):
            node_class = type
            break

    enc['classes']['role::' + node_class] = {}
    print "---"
    print yaml.dump(enc, default_flow_style=False)

