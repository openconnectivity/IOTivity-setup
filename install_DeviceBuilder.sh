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

# linux pi
ARCH=armv7l
# linux unbuntu
ARCH=x86_64

cd ..
# clone the repo
git clone https://github.com/openconnectivityfoundation/DeviceBuilder.git
# get the initial example 
cp DeviceBuilder/DeviceBuilderInputFormat-file-examples/input-lightdevice.json example.json
# replace the build file
cp ./SConscript ../iotivity/examples/OCFSecure/.  

# create the generation script
echo "cd DeviceBuilder" > gen.sh

echo "sh ./DeviceBuilder_C++IotivityServer.sh ../example.json  ../device_output \"oic.d.light\"" >> gen.sh
echo "cp ../device_output/code/server.cpp ../iotivity/examples/OCFSecure/server.cpp " >> gen.sh
echo "mkdir ../iotivity/out/linux/${ARCH}/release/examples/OCFSecure" >> gen.sh
echo "cp ../device_output/code/server_introspection.dat ../iotivity/out/linux/${ARCH}/release/examples/OCFSecure/." >> gen.sh
echo "cp ../device_output/code/oic_svr_db_server_mvjustworks.dat ../iotivity/out/linux/${ARCH}/release/examples/OCFSecure/server_security.dat" >> gen.sh
echo "cd .." >> gen.sh
# create the build script
echo "cd iotivity" > build.sh
echo "#scons resource/examples" >> build.sh
echo "scons examples/OCFSecure" >> build.sh
echo "cd .." >> build.sh
# create the run script
echo "CURPWD=`pwd`"> run.sh
echo "#cd ./iotivity/out/linux/${ARCH}/release/resource/examples" >> run.sh
echo "#./simpleserver" >> run.sh
echo "cd ./iotivity/out/linux/${ARCH}/release/examples/OCFSecure" >> run.sh
echo "./server" >> run.sh
echo "cd $CURPWD" >> run.sh
# create the reset script
echo "CURPWD=`pwd`"> reset.sh
echo "#cp ../device_output/code/oic_svr_db_server_mvjustworks.dat ../iotivity/out/linux/${ARCH}/release/resource/examples/server_security.dat" >> reset.sh

echo "mkdir ../iotivity/out/linux/${ARCH}/release/examples/OCFSecure"
echo "cp ../device_output/code/oic_svr_db_server_mvjustworks.dat ../iotivity/out/linux/${ARCH}/release/resource/examples/server_security.dat" >> reset.sh

echo "cd $CURPWD" >> reset.sh

cd $CURPWD

chmod a+x ../*.sh