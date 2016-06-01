import os
import sys

#  Author: ngrpci May 2015   nina@cis.rit.edu
#  Code tested on jagwire and barracuda's landsat VM 
#  Python code to automatically download L8 scenes given a list of their full file name including version
#  EXAMPLE file name LC80440342004250LGN02
#
#  Input "scene_list.txt"
#  python V2.7.9

#########################################################################################
# ATTN YOU MUST ENTER YOUR OWN Earth Explorer Username and Password below XXXXX  YYYYYY #
#########################################################################################

#  NOTE to download L7 scenes you need to modify this code and use different ports

infile = "scene_list.txt"
f1 =  open(infile, 'r+')
lines = f1.readlines()

# Loop through all Landsat filenames in input list
for n in lines:
    print n[0:21]
    L8filename =  n[0:21]

##########################################################################################
# ATTN YOU MUST ENTER YOUR OWN Earth Explorer Username and Password below XXXXX  YYYYYY	 #
##########################################################################################    
    image_call_step1 = "wget https://ers.cr.usgs.gov/login/ --save-cookies cookies.txt --keep-session-cookies --post-data 'username=jaconcha&password=Odi33i69' --no-check-certificate"

    os.system(image_call_step1)
	
    image_call_step2 ="wget --load-cookies cookies.txt earthexplorer.usgs.gov/download/4923/"+L8filename+"/STANDARD/EE/ --no-check-certificate --output-document="+L8filename+".tar.gz"
    print image_call_step2
    status = os.system(image_call_step2)
    print " img download status = ", status, " a zero means file exists"
    # if download fails	
    if status != 0:
 	    print "**************************************"
 	    print "* WARNING image was not on site      *"
 	    print "**************************************"
    # if download successful
    if status == 0:
	    print "Image EXISTS on ftp site. Download successful"
	    print " Uncompressing tar.gz files ...."
            os.system("tar -zxvf "+L8filename+".tar.gz")

	    # Clean up unused files
            # comment out which files you want to keep
	    # os.system("rm *tar.gz")
  	    # os.system("rm *_B1.TIF")
	    # os.system("rm *_B2.TIF")
	    # os.system("rm *_B3.TIF")
	    # os.system("rm *_B4.TIF")
	    # os.system("rm *_B5.TIF")
	    # os.system("rm *_B6.TIF")
	    # os.system("rm *_B7.TIF")
	    # os.system("rm *_B8.TIF")
            # os.system("rm *_B9.TIF")
	    # Keep just the Thermal Bands
            # os.system("rm *_B10*")
	    # os.system("rm *_B11*")
	    # Keep BQA for L8 cloud detection
            # os.system("rm *_BQA*")
            # gap for L7
            # os.system("rm -R *gap*")

f1.close()



