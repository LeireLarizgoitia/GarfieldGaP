Generate GasFile

- GENERATE GAS FILE in mac terminal

https://garfieldpp.web.cern.ch/garfieldpp/getting-started/

- Make sure Garfield is up to date
(the code is still frequently modified. To obtain the latest version, use the command git pull origin master and rebuild the project.
source_Garfield)
	-  git pull origin master
	-  act_root
	- rebuild the project
		- remove if any: cmake_install.cmake , CMakeCache.txt, CMakeFiles Folder
		- mkdir build | cd build
		- cmake ..
		- make
		READY with correct paths!

GasFile

source_Garfield
make
./generate

this will save gas properties for a give gas and pressure -
input this file in EL Garfield simulation directly
