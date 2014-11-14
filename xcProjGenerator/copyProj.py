import os
import errno
import shutil

def copy(src, dest):
    try:
        shutil.copytree(src, dest)
    except OSError as e:
        # If the error was caused because the source wasn't a directory
        if e.errno == errno.ENOTDIR:
            shutil.copy(src, dst)
        else:
            print('Directory not copied. Error: %s' % e)

username = 'joe'
appname = 'ASDapp'
prefix = 'projects/user-'+username+'/app-'+appname+'/'

copy("GeneratedApp", prefix)
