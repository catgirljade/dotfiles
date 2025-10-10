#!/usr/bin/env python
# -*- coding: utf-8 -*-

# GIMP plugin to export a file without listing the directory contents

# (c) Ofnuts 2022
#
#   History:
#
#   v0.0: 2022-02-26 First published version

#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published
#   by the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#
#   This very file is the complete source code to the program.
#
#   If you make and redistribute changes to this code, please mark it
#   in reasonable ways as different from the original version. 
#   
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   The GPL v3 licence is available at: https://www.gnu.org/licenses/gpl-3.0.en.html

import sys,os,os.path,traceback
from gimpfu import *

def quickExport(image,directory,imageFile):

    try:
        dirty=image.dirty
        exportLayer=pdb.gimp_layer_new_from_visible(image,image,'### temp ###')
        image.add_layer(exportLayer,0)
        filename=os.path.join(directory,imageFile)
        pdb.gimp_file_save(image, exportLayer,filename,filename,run_mode=RUN_INTERACTIVE)
        image.remove_layer(exportLayer)
        if not dirty:
            image.clean_all()
            
    except Exception as e:
        pdb.gimp_message(e.args[0])
        print traceback.format_exc()


### Registrations
author='Ofnuts'
year='2022'
exportMenu='<Image>/File/Export/'
exportDesc='Quick export'
whoiam='\n'+os.path.abspath(sys.argv[0])

register(
    'ofn-quick-export',
    exportDesc,exportDesc+whoiam,author,author,year,exportDesc+'...',
    '*',
    [
        (PF_IMAGE,      'image',        'Input image', None),
        (PF_DIRNAME,    'directory',    'Directory',   '.'),
        (PF_STRING,     'imageFile',    'Image file',  'Untitled.png'),
    ],
    [],
    quickExport,
    menu=exportMenu
)
    
main()
