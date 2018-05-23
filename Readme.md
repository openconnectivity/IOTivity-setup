# IOTivity setup

This repo contains a few scripts to setup:
- Iotivity
- DeviceBuilder
-  MRAA library
All repos are being set up 1 level above this folder.

The devicebuilder script generates a few scripts in the folder above this repo.


Typical folder layout to start from (e.g. create the IOT folder in the home folder)
     
     
     ~/IOT
     
clone in this folder:
git clone https://github.com/openconnectivity/IOTivity-setup.git
     
     This command will give the next folder structure :
     
     ~/IOT
        |-IOTivity-setup 
    
From this folder run the scripts (in order):
- install_IOTivity.sh
- install_DeviceBuilder.sh
- install_MRAA.sh

e.g. exectute in the ~/IOT folder: sh install_<>.sh


Folder structure after everything is installed:
        
        ~/IOT        
            |-- DeviceBuilder    The device builder tool chain
			|-- iotivity         IOTivity source code
			|        | 
			|		 |-- examples
			|		 |		|
			|		 |		|- OCFDeviceBuilder   The folder with the project to build.
			|        |-- out
			|             |-- linux
			|                   |-- x86_64/release/examples/OCFDeviceBuilder  - ubuntu executable folder
			|                   |-- armv7l/release/examples/OCFDeviceBuilder  - pi executable folder
			|
            |-- swagger2x        swagger2x code generation
            |-- core             core resource definitions (in swagger)
            |-- IOTDataModels    oneIOTa resource definitions (in swagger)
            |-- mraa             MRAA library to talk to HW attached to the pi boards
			|-- device_output    The output of device builder.
			|         |
            |	      |-- code   The generated code, the files will be copied to iotivity/examples/OCFDeviceBuilder
            | gen.sh             generation command to convert the input-lightdevice.json in to code
            | build.sh           building the generated code
            | run.sh             run the generated code
            | reset.sh           reset the device to ready for onboarding state.
        
				

#### linux/ubuntu as executable environment
Default the install_DeviceBuilder.sh script installs the gen/build/run/reset scripts for the pi board.
if one wants to use linux (ubuntu PC) as execution platform then add the linux as argument on the commandline:
```sh install_DeviceBuilder.sh linux```
    
# gen.sh
This script runs the DeviceBuilder with the correct arguments.
running this script generates the device_output folder AND copies the result to the correct folder in the iotivity tree structure.
copied:
- server.cpp to simpleserver.cpp in the resource/example folder
- introspection file to the output directory
- security file to the output directory

# build.sh
This script builds the resource/examples by means of scons.
e.g. run in the iotivity folder the ```scons examples/OCFDeviceBuilder``` command

# run.sh
This script goes to the folder where the executable resides and starts it.

e.g. goes to (linux)
./iotivity/out/linux/x86_64/release/examples/OCFDeviceBuilder

e.g. goes to (pi)
./iotivity/out/linux/armv7l/release/examples/OCFDeviceBuilder

and starts the executable from that directory.
note that the executable needs to be started in that directory to avoid issues with reading the security and introspection files.


# reset.sh
This script overwrites the security file from the device_output folder.

Execute this command only when the device is not running.
The device will go to the ready for onboarding state.



# SConscript and SConstruct

SConstruct 

Sconstruct is the main build file.
An addition is made to add the example/OCFDeviceBuilder target.

SConscript

The scon script to build the (generated) server it the folder:

```iotivity/examples/OCFDeviceBuilder```

This build script will:
- have all includes to build the C++ server code 
- MRAA linkage
