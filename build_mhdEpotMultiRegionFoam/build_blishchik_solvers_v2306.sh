#!/bin/bash
source ~/.openfoam_v2306_profile 

INSTALL_DIR=$WM_PROJECT_USER_DIR/applications/solvers/electromagnetics/
ORIG_DIR=$PWD
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
echo "Installing in $INSTALL_DIR"
git clone https://github.com/Kommbinator/MHD_Solvers_OpenFOAM.git


# Blishchik mhdEpot solver compilation process

cd MHD_Solvers_OpenFOAM

# Apply v2306 patch
cp $ORIG_DIR/v2306_potentialFvPatchScalarField.patch .
git apply v2306_potentialFvPatchScalarField.patch

cd solvers

#

#

cd mhdEpotInterFoam
cd transportModels
cd incompressible
wmake
cd ../immiscibleIncompressibleTwoPhaseMhdMixture
wmake
cd ../..
wmake
cd ..

#

cd mhdEpotMultiRegionFoam
cd potentialFvPatchScalarField
# start: fixes which should be resolved with changes to the main repo (included files which break the installation)
rm lnInclude Make/{files~,linux64GccDPInt64Opt}
# end
wmake
cd ..
wmake
cd ..

#

#cd mhdEpotMultiRegionInterFoam
#cd transportModels
#cd incompressible
#wmake
#cd ../immiscibleIncompressibleTwoPhaseMhdMixture
#wmake
#cd ../..
#wmake
#cd ..
#
##
#cd mhdEpotBuoyantBoussinesqPimpleFoam
#wmake
#cd ..
#
##
#
#cd mhdEpotFoam
#wmake
#cd ..
#
#
#cd ../turbulenceModels
#
## 
#
#cd dynamicSmagorinsky
#wmake
#cd ..
#
##
#
#cd kEpsilonMHD
#cd incompressible
#wmake
#
##
# 
