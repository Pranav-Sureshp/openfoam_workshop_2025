#!/bin/bash

cores=8

blockMesh 2>&1 | tee log.blockMesh

if [[ ! $cores -eq 1 ]]
then
	decomposePar 2>&1 | tee log.decomposePar
	orterun -np $cores mhdFoam -parallel 2>&1 | tee log.epotFoam
	reconstructPar 2>&1 | tee log.reconstructPar
else
	epotFoam 2>&1 | tee log.mhdFoam
fi
