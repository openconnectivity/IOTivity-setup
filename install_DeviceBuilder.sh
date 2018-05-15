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
cd ..
# clone the repo
git clone https://github.com/openconnectivityfoundation/DeviceBuilder.git
# get the initial example
cp ../DeviceBuilder/DeviceBuilderInputFormat-file-examples/input-lightdevice.json ..
# create the generation script
echo "cd DeviceBuilder" > ../gen.sh
echo "sh ./DeviceBuilder_C++IotivityServer.sh ../input-lightdevice.json  ../device_output \"oic.d.light\"" >> ../gen.sh
echo "cp ../device_output/code/*.cpp ../iotivity/resource/examples/. " >> ../gen.sh
echo "#cp ../device_output/code/server_introspection.dat ../iotivity/out/windows/win32/amd64/debug/resource/examples/." >> ../gen.sh
echo "cp ../device_output/code/server_introspection.dat ../iotivity/out/linux/x86_64/release/resource/examples/." >> ../gen.sh
echo "cd .." >> ../gen.sh
# create the build script
echo "cd iotivity" > ../build.sh
echo "scons resource/examples" > ../build.sh
echo "cd .." >> ../build.sh
cd $CURPWD