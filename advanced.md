# Advanced usage
Scripts that are intended for usage after initial setup.

# update_repos.sh
The update_repos.sh script updates the: 
- tooling repos
- datamodels repos

The script does NOT update the code repos:
- iotivity
- mraa
The code repo iotivity is pulled at start up with a specific version.
To get a fresh copy, delete the folder and rerun the install_IOTivity.sh script.

# security 
svr2cbor.sh 

This script is run once during setup by install_DeviceBuilder.sh.
It converts the SVR-OCF1.3-Server.json security json file into cbor.
This file contains the default settings for the SVRs for an OCF1.3 device.

When running the script the result (server_security.dat) will be placed in ../device_output/code.
The script can also be used to convert the ../device_output/code/server_security.dat file back to json.
When converting the dat back to json the result will be placed ../device_output/code/server_security.dat.json (appending .json).
This is done to avoid overwriting the default SVR settings.


Note that one has to edit the SVR-OCF1.3-Server.json to get a different file installed.

The commands to do the conversions: (to be excuted in the IOTivity-setup folder)

to convert SVR-OCF1.3-Server.json to cbor: ```sh svr2cbor.sh tocbor```

to convert ../device_output/code/security.dat to json: ```sh svr2cbor.sh tojson```

    
    script     action on the security file.
    
    install_DeviceBuilder.sh    
    
               currently ignored << IOTivity-setup/SVR-OCF1.3-Server.json      --converts-->   ../device_output/code/server_security.dat (using svr2cbor.sh tocbor) >>
               ../device_output/code/oic_svr_db_server_mvjustworks.dat  --- copy --->   ../device_output/code/server_security.dat
               ../device_output/code/server_security.dat  --- copy --->   ../iotivity/out/linux/${ARCH}/release/examples/${code_path}/server_security.dat
               
    gen.sh 
               ../device_output/code/server_security.dat  --- copy --->   ../iotivity/out/linux/${ARCH}/release/examples/${code_path}/server_security.dat
    reset.sh
               ../device_output/code/server_security.dat  --- copy --->   ../iotivity/out/linux/${ARCH}/release/examples/${code_path}/server_security.dat
               
    svr2cbor.sh tocbor
               IOTivity-setup/SVR-OCF1.3-Server.json      --converts-->   ../device_output/code/server_security.dat
    
    svr2cbor.sh tojson
               ../device_output/code/server_security.dat  --converts-->   ../device_output/code/server_security.dat.json


more info about security:   
            
https://github.com/iotivity/iotivity/blob/master/resource/csdk/security/README-building-and-running-secure-IoTivity-stack.txt
       
more about provisioning

https://github.com/iotivity/iotivity/tree/master/resource/csdk/security/provisioning
       

security sample files:

https://github.com/iotivity/iotivity/tree/master/resource/csdk/security/provisioning/sample
               
               
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
