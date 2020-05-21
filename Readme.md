# IoTivity Classic setup

This repo contains bash scripts to setup a build enviroment to use DeviceBuilder with IoTivity Classic.
The scripts setup the next repos (from git) in the folders:
- IoTivity Classic (IOTivity 1.3.1 or 2.0.0)
- DeviceBuilder (latest version)
- mraa (MRAA library to interact with HW)

All repos are being set up 1 level above the folder of IOTivity-setup folder.

Running the curl command below installs the development environment with IOTivity 1.3.1:

```curl  https://openconnectivity.github.io/IOTivity-setup/install.sh | bash```

Running the curl command below installs the development environment with IOTivity 2.0.0:

```curl  https://openconnectivity.github.io/IOTivity-setup/install2.0.sh | bash```


for manual installation instructions see: 
https://github.com/openconnectivity/IOTivity-setup/blob/master/advanced.md

# Folder structure 

Folder structure after everything is installed:
    
    ~/iot        
        |-- core             core resource definitions (in swagger) 
        |-- DeviceBuilder    The device builder tool chain
        |-- device_output    The output of device builder.
        |         |
        |         |-- code   The generated code.
        |               |    the files will be copied to folder iotivity/examples/OCFDeviceBuilder
        |               |- server.cpp
        |               |- server_security.dat       SVR data
        |               |- server_introspection.dat  introspection device data
        |
        |-- iotivity         IOTivity source code
        |        | 
        |        |-- examples
        |        |        |
        |        |        |- OCFDeviceBuilder   The folder with the project to build.
        |        |                  |- server.cpp  file that is being build and edited.
        |        |
        |        |-- out
        |             |-- linux                          ARCH=x86_64:Ubuntu, ARCH=armv71:pi
        |                   |-- <ARCH>/release/examples/OCFDeviceBuilder   executable folder
        |                                                 |- server                    executable
        |                                                 |- server_security.dat       SVR data
        |                                                 |- server_introspection.dat  introspection device data
        |                   
        |-- IOTDataModels    oneIOTa resource definitions (in swagger)
        |-- mraa             MRAA library to talk to HW attached to the pi boards
        |-- IOTivity-setup   This repo.
        |-- iotivity-tool    Tool to convert the SVR json in to cbor (and visa versa)
        |-- mraa             MRAA library to talk to HW attached to the pi boards
        |-- swagger2x        swagger2x code generation
        |- gen.sh            generation command to convert the example.json in to code
        |- build.sh          building the generated code
        |- run.sh            run the generated code
        |- reset.sh          reset the device to ready for onboarding state.
        |- edit_code.sh      edits the iotivity/examples/OCFDeviceBuilder/server.cpp file with nano.
        |- edit_input.sh     edits the input file for device builder with nano.
        |- example.json      the input for device builder.
            
            
     legenda:  folder
                  |-- folder
                  |-- folder/subfolder
                  |- file

        
        
The installDeviceBuilder script generates scripts in the folder above this repo.
These scripts are convienent scripts, e.g. they are short cuts for entering generation, build, excute and reset commands.


referenced information:

| repo  |  description | location |
| ----- | ----- | -------|
| DeviceBuilder |  tool chain  | https://github.com/openconnectivityfoundation/DeviceBuilder |
| swagger2x |  code generation  | https://github.com/openconnectivityfoundation/swagger2x |
| iotivity-tool |  cbor conversion for IOTivity Security  | https://github.com/alshafi/iotivity-tool.git |
| IoTivity Classic   |  C++ code (v1.3.1 or v2.0.0)     | https://iotivity.org/ https://github.com/iotivity/iotivity |
| MRAA          |  code library, communication abstracting hardware   | https://github.com/intel-iot-devkit/mraa.git |
| IOTdataModels  |  oneIOTa data models https://oneiota.org  |https://github.com/openconnectivityfoundation/IoTDataModels |
| core          |  OCF core data models  | https://github.com/openconnectivityfoundation/core |

    
    
# development flow  

The development flow is depicted the figure below:

                   start
                     |       
                     v
               --------------                  
              |              |     
              | edit_input.sh|             --- edit the input file for the code generation
              |              |                 default file contains the binary switch resource
               -------------- 
                     |
                     |       
                     v
               --------------
              |              |
              |    gen.sh    |             ---  generates the code & introspection file
              |              |             --- script contains the device type, 
               --------------                  change the argument to change the device type.
                     |
                     | initial code        --- in iotivity classic tree, to build
                     v                     --- introspection/security files 
               --------------                  in the iotivity executable folder
              |              |     
              | edit_code.sh |<--------    --- edit the generated code
              |              |         |
               --------------          |
                     |                 |
                     | edited code     |
                     v                 |
               --------------          |
              |              |  build  |
              |   build.sh   |---->----|   --- build the executable
              |              |  failed |
               --------------          |
                     |                 |
                     | ok              |
                     v                 |
               --------------          |
    run       |              | modify  |
    --------->|    run.sh    |---->----      --- onboarding will change the security file 
    clients   |              | behaviour         in the executable folder
    against    --------------                    to refresh/reset the security file execute reset.sh
    application      |
                     v
                  finished
                 
        Note: if gen.sh is run again, the generated code is overwritten.
        e.g. before running that tool again, safe the file in the iotivivty tree to another name 
        if one wants to keep that code as reference

    
### OCF clients
information about the clients for development support can be found at:

https://github.com/openconnectivityfoundation/development-support   
    
## edit_input.sh
This scripts edits the device builder input file with nano.

### Nano
Nano is supplied on various linux systems like ubuntu and pi.
The file being edited is the file in IoTivity classic tree.
so please make sure when generating a new version, that a changed file is saved under a different name.

nano beginners guide:

https://www.howtogeek.com/howto/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/

### input file
Device Builder input file information can be found at:
https://github.com/openconnectivityfoundation/DeviceBuilder/tree/master/DeviceBuilderInputFormat-file-examples

## gen.sh
This script runs the DeviceBuilder with the arguments:
- ~IOT/example.json as input file
- light device as device type

when the device type needs to change from oic.d.light to something else
the next mechanisms are available to change the device type:
- change the server code from oic.d.light to the specific value
	- search for oic.d.light in the server code, and change the value.
	- no need to re-generate the server code
	- can be done when one is already changing the server code.
- change the gen.sh file e.g. replace oic.d.light to something
	- to see the changes the code needs to be re-generated by running gen.sh
	- can be done when no code has been changed yet.


Running this script generates the device_output folder AND copies the result to the correct executable folder in the IoTivity classic tree structure.

copied to the executable folder from the device:
- server.cpp to simpleserver.cpp in the examples/OCFDeviceBuilder folder
- introspection file (in CBOR format) to the out/linux/$ARCH/release/examples/OCFDeviceBuilder directory
- security file (in CBOR format) to the out/linux/$ARCH/release/examples/OCFDeviceBuilder directory
	- The original JSON file is using "just works" onboarding

## edit_code.sh
This scripts edits the code with nano.
The file being edited is the file in IoTivity classic tree.
so please make sure when generating a new version, that a changed file is saved under a different name.


## build.sh
This script builds the examples/OCFDeviceBuilder by means of scons.
e.g. run in the IoTivity classic folder the ```scons examples/OCFDeviceBuilder``` command

## run.sh
This script executes the executable in the folder where the executable resides in.

linux executes in folder:

./iotivity/out/linux/x86_64/release/examples/OCFDeviceBuilder

pi executes in folder:

./iotivity/out/linux/armv7l/release/examples/OCFDeviceBuilder

note that the executable needs to be started in folder where it recides to avoid issues with reading the security and introspection files.


# reset.sh
This script overwrites the SVR settings in the security file from the device_output folder to the 
out/linux/$ARCH/release/examples/OCFDeviceBuilder folder.

Note execute this command only when the device is not running.
The device will go to the ready for onboarding state.



# advanced usage

see https://github.com/openconnectivity/IOTivity-setup/blob/master/advanced.md

# Device Builder OCF developer kit info

https://github.com/openconnectivity/IOTivity-setup/tree/master/pi-boards
