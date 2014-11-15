#!/bin/bash

#-D__INSIDE_RTEMS_BSD_TCPIP_STACK__ 

export RLIMIT_RTTIME=60
export FIJI_HOME=/home/j3/dev/projects/utilities/fivm
export RTEM_BUILD_DIR=/home/j3/dev/projects/utilities/rtems/built/4.10
export JPAPBENCH_DIR=~/dev/projects/RA/cPapProject/paparazzi_in_java

echo "> the following script will need root right!\n"
echo "> Do you want to recompile the executable, "y/n"(default:n)"
read IS_RECOMPILE
#we need to configure the fiji compile to lift the max threads to 2000 for exp
#we also need to use "ulimit -s 2014" to increase the stack size for thread creation.
#RTEMS-leon3-rtems4.9-sparc-32
if [ "$IS_RECOMPILE" = "y" ] || [ "$IS_RECOMPILE" = "Y" ]; then
	cd ./output/jar/
	echo "cd ./output/jar/"
$FIJI_HOME/bin/fivmc --max-threads=110 --r-max-os-threads=110 --more-opt --r-nanos-per-tick=100000 --r-max-fds=20 --sys-cppflags="-D_RTEMS_ENABLE_NETWORK -DHAVE_CONFIG_H -B${RTEM_BUILD_DIR}/sparc-rtems4.10/leon3/lib -qrtems -D_REENTRANT -D_GNU_SOURCE -I{RTEM_BUILD_DIR}/sparc-rtems4.10/leon3/lib/include" --r-thr-stack-size=300000 --rt-library=RTSJ --gc CMR --target RTEMS-leon3-rtems4.10-sparc-32 -o juav-java ${JPAPBENCH_DIR}/jpapabench-build/output/jar/jpapabench-pj.jar ${JPAPBENCH_DIR}/jpapabench-build/output/jar/jpapabench-core.jar ${JPAPBENCH_DIR}/jpapabench-build/output/jar/jpapabench-core-flightplans.jar
    echo "complete compile. \n"
	cd ../..
fi



