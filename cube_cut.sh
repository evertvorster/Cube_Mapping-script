#!/bin/bash
if  [ "$1" == "" ]; then
echo "You need to specify a file name of an equirectangular spheremap to cut up into faces"
echo "Example: $0 IMAGE.tiff 4096"
exit
fi
#Get width and height
WIDTH=$(magick identify "$1" | cut -d " " -f3 | cut -d"x" -f1)
HEIGHT=$(magick identify "$1" | cut -d " " -f3 | cut -d"x" -f2)

#Face size
if  [ "$2" == "" ]; then
echo "You need to specify an edge size in pixels of the cube faces"
echo "Example: $0 IMAGE.tiff 4096"
exit
fi

#output Filename
F="cubic.pto"

#erect2cubic --erect="$1" --ptofile=cubic.pto
rm -vf "cubic.pto"
echo "# hugin project file" > $F
echo "#hugin_ptoversion 2" >> $F
echo "p f0 w"$2" h"$2" v90  E0 R0 n\"TIFF_m c:LZW\"" >> $F
echo "m i0" >> $F
echo "" >> $F
echo "# image lines" >> $F
echo "#-hugin  cropFactor=1"
echo "i w"$WIDTH" h"$HEIGHT" f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\""$1"\"" >> $F
echo "#-hugin  cropFactor=1" >> $F
echo "i w"$WIDTH" h"$HEIGHT" f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y-90 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\""$1"\"" >> $F
echo "#-hugin  cropFactor=1" >> $F
echo "i w"$WIDTH" h"$HEIGHT" f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y180 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\""$1"\"" >> $F
echo "#-hugin  cropFactor=1" >> $F
echo "i w"$WIDTH" h"$HEIGHT" f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y90 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\""$1"\"" >> $F
echo "#-hugin  cropFactor=1" >> $F
echo "i w"$WIDTH" h"$HEIGHT" f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p-90 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\""$1"\"" >> $F
echo "#-hugin  cropFactor=1" >> $F
echo "i w"$WIDTH" h"$HEIGHT" f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p90 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\""$1"\"" >> $F
echo "" >> $F
echo "" >> $F
echo "# specify variables that should be optimized" >> $F
echo "v" >> $F
echo "" >> $F
echo "" >> $F
echo "# control points" >> $F
echo "" >> $F
echo "#hugin_optimizeReferenceImage 0" >> $F
echo "#hugin_blender enblend" >> $F
echo "#hugin_remapper nona" >> $F
echo "#hugin_enblendOptions " >> $F
echo "#hugin_enfuseOptions " >> $F
echo "#hugin_hdrmergeOptions " >> $F
echo "#hugin_verdandiOptions " >> $F
echo "#hugin_outputLDRBlended true" >> $F
echo "#hugin_outputLDRLayers false" >> $F
echo "#hugin_outputLDRExposureRemapped false" >> $F
echo "#hugin_outputLDRExposureLayers false" >> $F
echo "#hugin_outputLDRExposureBlended false" >> $F
echo "#hugin_outputLDRStacks false" >> $F
echo "#hugin_outputLDRExposureLayersFused false" >> $F
echo "#hugin_outputHDRBlended false" >> $F
echo "#hugin_outputHDRLayers false" >> $F
echo "#hugin_outputHDRStacks false" >> $F
echo "#hugin_outputLayersCompression PACKBITS" >> $F
echo "#hugin_outputImageType tif" >> $F
echo "#hugin_outputImageTypeCompression NONE" >> $F
echo "#hugin_outputJPEGQuality 100" >> $F
echo "#hugin_outputImageTypeHDR exr" >> $F
echo "#hugin_outputImageTypeHDRCompression LZW" >> $F
echo "#hugin_outputStacksMinOverlap 0.7" >> $F
echo "#hugin_outputLayersExposureDiff 0.5" >> $F
echo "#hugin_outputRangeCompression 0" >> $F
echo "#hugin_optimizerMasterSwitch 0" >> $F
echo "#hugin_optimizerPhotoMasterSwitch 0" >> $F

echo "Done creating the cubic.pto file."
nona -v -o cubic cubic.pto;
echo "Renaming Images"
mv -vf "cubic0000.tif" "negative z.tif";
mv -vf "cubic0001.tif" "positive x.tif";
mv -vf "cubic0002.tif" "positive z.tif";
mv -vf "cubic0003.tif" "negative x.tif";
mv -vf "cubic0004.tif" "positive y.tif";
mv -vf "cubic0005.tif" "negative y.tif";

echo "Flipping images"
magick "positive x.tif" -flop "positive x.tif";
magick "negative x.tif" -flop "negative x.tif";
magick "positive z.tif" -flop "positive z.tif";
magick "negative z.tif" -flop "negative z.tif";
magick "positive y.tif" -flip "positive y.tif";
magick "negative y.tif" -flip "negative y.tif";
