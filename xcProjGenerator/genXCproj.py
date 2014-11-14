import os
from jinja2 import Template

from jinja2 import Environment, PackageLoader
env = Environment(loader=PackageLoader('test', 'templates'))

username = 'joe'
appname = 'GenApp'
prefix = 'projects/user-'+username+'/app-'+appname+'/'

# DO NOT MODIFY THE ORDER OF THIS ARRAY. NEVER DO THAT
paths = [
    appname,
    appname+'/'+appname+'.xcodeproj',
    appname+'/'+appname+'.xcodeproj/project.xcworkspace',
    appname+'/'+appname+'.xcodeproj/project.xcworkspace/xcuserdata',
    appname+'/'+appname+'.xcodeproj/project.xcworkspace/xcuserdata/'+username+'.xcuserdatad',
    appname+'/'+appname,
    appname+'/'+appname+'/Base.lproj',
    appname+'/'+appname+'/'+appname+'.xcdatamodeld',
    appname+'/'+appname+'/Images.xcassets/AppIcon.appiconset',
    appname+'/'+appname+'/'+appname+'.xcdatamodeld/'+appname+'.xcdatamodel',

]

for i in range(len(paths)):
    paths[i] = prefix + paths[i]

for path in paths:
    if not os.path.exists(path):
        os.makedirs(path)

files = [ # (index of directory from paths array, file name)
    (3,'contents.xcworkspacedata'),
    (1,'project.pbxproj'),
    (6,'LaunchScreen.xib'),
    (6,'Main.storyboard'),
    (8,'Contents.json'),
    (5,'Info.plist'),
    (5,'AppDelegate.swift'),
    (5,'DataSet.swift'),
    (5,'DataSetCollection.swift'),
    (5,'ListViewController.swift'),
    (5,'MainViewController.swift'),
    (5,'PagesCollection.swift'),
    (5,'PagesViewController.swift'),
    (9,'contents'),
    (7,'.xccurrentversion')
]

jessiescode=''
if os.path.exists(prefix+'jessies.txt'):
    with open (prefix+'jessies.txt', 'r') as myfile:
        jessiescode=myfile.read()

for i in range(len(files)):

    template = env.get_template(files[i][1]+'.tpl')

    with open(os.path.join(paths[files[i][0]], files[i][1]), 'wb') as temp_file:
        temp_file.write(template.render(appname=appname, jessiescode=jessiescode))
