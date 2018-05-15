# IOTivity setup

This repo contains a few scripts to setup:
- Iotivity
- DeviceBuilder
- MRAA library
All repos are being set up 1 level above this folder.

The devicebuilder script generates a few scripts in the folder above this repo.


Typical folder layout to start from (e.g. create the IOT folder in the home folder)
     
     
     ~/IOT
     
clone in this folder:
git clone https://github.com/openconnectivity/IOTivity-setup.git
     
     This command will give the next folder structure
     
     ~/IOT
        |-IOTivity-setup 
    
From this folder run the scripts:
- install_DeviceBuilder.sh
- install_IOTivity.sh
- install_MRAA.sh
e.g. exectute in the folder: sh install_<>.sh
    
    
Folder structure after everything is installed:
        
        ~/IOT        
            |-- iotivity         IOTivity source code
            |-- DeviceBuilder    The device builder tool chain
            |-- swagger2x        swagger2x code generation
            |-- core             core resource definitions (in swagger)
            |-- IOTDataModels    oneIOTa resource definitions (in swagger)
            |-- mraa             MRAA library to talk to HW attached to the pi boards
            | gen.sh             generation command to convert the input-lightdevice.json in to code
            | build.sh           building the generated code
            | run.sh             run the generated code
            | reset.sh           reset the device to ready for onboarding state.
        
        
        The generated code will be in 
        ~/IOT        
            |-- device_output
        
# gen.sh
This script runs the DeviceBuilder with the correct arguments.
running this script generates the device_output folder AND copies the result to the correct folder in the iotivity tree structure.
copied:
- server.cpp to simpleserver.cpp in the resource/example folder
- introspection file to the output directory
- security file to the output directory

# build.sh
This script builds the resource/examples by means of scons.

# run.sh
This script goes to the folder where the executable resides and starts it.

# reset.sh
This script overwrites the security file from the device_output folder