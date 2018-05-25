#!/bin/bash
set -x #echo on
#############################
#
#    copyright 2018 Open Interconnect Consortium, Inc. All rights reserved.
#    Redistribution and use in source and binary forms, with or without modification,
#    are permitted provided that the following conditions are met:
#    1.  Redistributions of source code must retain the above copyright notice,
#        this list of conditions and the following disclaimer.
#    2.  Redistributions in binary form must reproduce the above copyright notice,
#        this list of conditions and the following disclaimer in the documentation and/or other materials provided
#        with the distribution.
#
#    THIS SOFTWARE IS PROVIDED BY THE OPEN INTERCONNECT CONSORTIUM, INC. "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
#    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE OR
#    WARRANTIES OF NON-INFRINGEMENT, ARE DISCLAIMED. IN NO EVENT SHALL THE OPEN INTERCONNECT CONSORTIUM, INC. OR
#    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#    OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
#    EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#############################
CURPWD=`pwd`

#path of the code
code_path=OCFDeviceBuilder

# linux pi
# default
ARCH=armv7l
a="linux"
b=$1
echo "1=$a "
# supplied linux on the command line, overwrite the architecture
if [ "$a" = "$b" ]; then
# linux unbuntu
ARCH=x86_64
fi

echo "using architecture: $ARCH"

cd ..
# clone the repo
git clone https://github.com/openconnectivityfoundation/DeviceBuilder.git
# get the initial example 
cp DeviceBuilder/DeviceBuilderInputFormat-file-examples/input-lightdevice.json example.json

# clone the iotivity cbor conversion tool 
git clone https://github.com/alshafi/iotivity-tool.git
# create the initial security file and place it in the code directory.
cd $CURPWD
sh svr2cbor.sh tocbor
cd ..

# create the generation script
echo "#!/bin/bash" > gen.sh
echo "cd DeviceBuilder" >> gen.sh
echo "sh ./DeviceBuilder_C++IotivityServer.sh ../example.json  ../device_output \"oic.d.light\"" >> gen.sh
echo "cp ../device_output/code/server.cpp ../iotivity/examples/${code_path}/server.cpp " >> gen.sh
echo "mkdir -p ../iotivity/out/linux/${ARCH}/release/examples/${code_path} >/dev/null 2>&1" >> gen.sh
echo "cp ../device_output/code/server_introspection.dat ../iotivity/out/linux/${ARCH}/release/examples/${code_path}/." >> gen.sh
echo "cp ../device_output/code/server_security.dat ../iotivity/out/linux/${ARCH}/release/examples/${code_path}/." >> gen.sh
echo "cd .." >> gen.sh

# create the build script
echo "#!/bin/bash" > build.sh
echo "cd iotivity" >> build.sh
echo "#scons resource/examples" >> build.sh
echo "scons examples/${code_path}" >> build.sh
echo "cd .." >> build.sh

# create the edit script
echo "#!/bin/bash" > edit_code.sh
echo "nano ./iotivity/examples/${code_path}/server.cpp" >> edit_code.sh

# create the run script
echo "#!/bin/bash"> run.sh
echo "CURPWD=`pwd`">> run.sh
echo "cd ./iotivity/out/linux/${ARCH}/release/examples/${code_path}" >> run.sh
echo "./server" >> run.sh
echo "cd $CURPWD" >> run.sh

# create the reset script
echo "#!/bin/bash"> reset.sh
echo "mkdir -p ./iotivity/out/linux/${ARCH}/release/examples/${code_path} >/dev/null 2>&1" >> reset.sh
echo "cp ./device_output/code/server_security.dat ./iotivity/out/linux/${ARCH}/release/resource/examples/server_security.dat" >> reset.sh


cd $CURPWD

echo "making the example directory"
mkdir -p ../iotivity/examples/${code_path}
# add the build file
cp ./SConscript ../iotivity/examples/${code_path}/SConscript 
# add the build dir
cp ./SConstruct ../iotivity/.



chmod a+x ../*.sh