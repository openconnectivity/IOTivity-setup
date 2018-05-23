# IOTivity setup

This repo contains bash scripts to setup a build enviroment to use DeviceBuilder with IOTivity.
The scripts setup the next repos (from git) in the folders:
- iotivity (IOTivity 1.3.1)
- DeviceBuilder (latest version)
- mraa (MRAA library to interact with HW)

All repos are being set up 1 level above the folder of IOTivity-setup folder.

Typical folder layout to start from (e.g. create the IOT folder in the home folder)
     
     
     ~/IOT
     
clone in this folder:

```git clone https://github.com/openconnectivity/IOTivity-setup.git```
     
This command will give the next folder structure :
     
     ~/IOT
        |-IOTivity-setup 
    
From the IOTivity-setup folder run the scripts (in order):
- install_IOTivity.sh
- install_DeviceBuilder.sh
- install_MRAA.sh

e.g. exectute in the ~/IOT/IOTivity-setup folder: sh install_<>.sh


Folder structure after everything is installed:
        
        ~/IOT        
            |-- DeviceBuilder    The device builder tool chain
            |-- iotivity         IOTivity source code
            |        | 
            |        |-- examples
            |        |        |
            |        |        |- OCFDeviceBuilder   The folder with the project to build.
            |        |
            |        |-- out
            |             |-- linux
            |                   |-- x86_64/release/examples/OCFDeviceBuilder  - ubuntu executable folder
            |                   |-- armv7l/release/examples/OCFDeviceBuilder  - pi executable folder
            |
            |-- swagger2x        swagger2x code generation
            |-- core             core resource definitions (in swagger)
            |-- IOTDataModels    oneIOTa resource definitions (in swagger)
            |-- mraa             MRAA library to talk to HW attached to the pi boards
            |-- IOTivity-setup   This repo, not used anymore after everyting is installed.
            |-- device_output    The output of device builder.
            |         |
            |         |-- code   The generated code, the files will be copied to iotivity/examples/OCFDeviceBuilder
            |
            |- gen.sh            generation command to convert the example.json in to code
            |- build.sh          building the generated code
            |- run.sh            run the generated code
            |- reset.sh          reset the device to ready for onboarding state.
            |- example.json      the input for device builder.
            
			
         legenda:  folder
		              |-- folder
                      |- file

        
        
The installDeviceBuilder script generates scripts in the folder above this repo.
These scripts are convienent scripts, e.g. they are short cuts for entering generation, build, excute and reset commands.


#### linux/ubuntu as executable environment
Default the install_DeviceBuilder.sh script installs the gen/build/run/reset scripts for the raspberry pi board.
if one wants to use linux (ubuntu PC) as execution platform then add ```linux``` as argument on the commandline:
```sh install_DeviceBuilder.sh linux```
This make sure that all convienent scripts will use the linux target/paths.
    
# gen.sh
This script runs the DeviceBuilder with the arguments:
- ~IOT/example.json as input file
- light device as device type

Running this script generates the device_output folder AND copies the result to the correct folder in the iotivity tree structure.
copied:
- server.cpp to simpleserver.cpp in the examples/OCFDeviceBuilder folder
- introspection file (in CBOR format) to the out/linux/$ARCH/release/examples/OCFDeviceBuilder directory
- security file to the out/linux/$ARCH/release/examples/OCFDeviceBuilder directory

# build.sh
This script builds the examples/OCFDeviceBuilder by means of scons.
e.g. run in the iotivity folder the ```scons examples/OCFDeviceBuilder``` command

# run.sh
This script executes the executable in the folder where the executable resides in.

linux executes in folder:

./iotivity/out/linux/x86_64/release/examples/OCFDeviceBuilder

pi executes in folder:

./iotivity/out/linux/armv7l/release/examples/OCFDeviceBuilder

note that the executable needs to be started in folder where it recides to avoid issues with reading the security and introspection files.


# reset.sh
This script overwrites the security file from the device_output folder to the 
out/linux/$ARCH/release/examples/OCFDeviceBuilder folder.

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
