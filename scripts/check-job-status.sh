if [ $1 = "success" ]; then
    anybadge -l pipeline -v `make kernelversion` -f badge.svg -c green
else
    anybadge -l pipeline -v `make kernelversion` -f badge.svg --color=#FF0000
fi
