# Advanced usage

# update_repos.sh
This script updates the: 
- tooling repos
- datamodels repos

does NOT update repos:
- iotivity
- mraa

### security 
svr2cbor.sh (advanced usage)

This script is run once during setup by install_DeviceBuilder.sh.
It converts the SVR-OCF1.3-Server.json security json file into cbor.
This file contains the default settings for the SVRs for an OCF1.3 device.

When running the script the result (server_security.dat) will be placed in ../device_output/code.
The script can also be used to convert the ../device_output/code/security.dat file back to json.
When converting the dat back to json the result will be placed ../device_output/code/security.dat.json
This is done to avoid overwriting the default SVR settings.
Note that one has to edit the SVR-OCF1.3-Server.json to get a different file installed.

The commands to do the conversions: (to be excuted in the IOTivity-setup folder)

to convert SVR-OCF1.3-Server.json to cbor: ```sh svr2cbor.sh tocbor```

to convert ../device_output/code/security.dat to json: ```sh svr2cbor.sh tojson```


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
