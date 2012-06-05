#!/bin/bash - 
#===============================================================================
#
#          FILE:  build-pysal-darwin.sh
# 
#         USAGE:  ./build-pysal-darwin.sh 
# 
#   DESCRIPTION:  This script checks out a fresh copy of PySAL trunk and
#   builds Macintosh source and  binary distribution formats, then copies to
#   a publicly available space with a private address in Dropbox.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  Development libraries.
#          BUGS:  ---
#         NOTES: Run via cron at midnight
#        AUTHOR: PHILIP STEPHENS (), phil.stphns@gmail.com
#       COMPANY: GeoDa Center for Geospatial Analysis and Computation
#       CREATED: 06/01/2012 10:22:07 AM MST
#      REVISION:  ---
#===============================================================================

set -o nounset     # Treat unset variables as an error
mkdir -p /tmp/buildspace/
rm -rf /tmp/buildspace/pysal
cd /tmp/buildspace/
svn checkout http://pysal.googlecode.com/svn/trunk/ pysal
cd pysal
#/Library/Frameworks/Python.framework/Versions/2.7/bin/python setup.py sdist 
/Library/Frameworks/Python.framework/Versions/2.7/bin/bdist_mpkg setup.py build
cd dist/
hdiutil create -fs HFS+ -srcfolder *.mpkg/ pysal-python2.7-Frameworks-macosx.dmg
rsync -uz *.dmg geodacenter.org:~/tmp/builds/