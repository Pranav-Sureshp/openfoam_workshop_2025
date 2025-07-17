#!/bin/bash

cores=4
solver=mhdEpotFoam

blockMesh 2>&1 | tee log.blockMesh_walls

if [[ ! $cores -eq 1 ]]
then
  decomposePar 2>&1 | tee log.decomposePar
  /usr/bin/mpirun -np $cores $solver -parallel  2>&1 | tee log.$solver
  
	reconstructPar 2>&1 | tee log.reconstructPar
else
	$solver 2>&1 | tee log.$solver
fi

touch foam.foam
