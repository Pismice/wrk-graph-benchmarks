#! /usr/bin/env bash
SUBJECTS="$1"

if [ "$SUBJECTS" = "std" ] ; then 
    rm -f ./*.perflog
    SUBJECTS="std-original std-monothread-accept std-monothread-sans-accept std-multi-12-accept std-multi-12-sans-accept std-multi-6-accept std-multi-6-sans-accept"
fi

if [ "$SUBJECTS" = "db" ] ; then 
    rm -f ./*.perflog
    SUBJECTS="std-db httpz-db std-monothread-sans-accept http.zig"
fi

if [ "$SUBJECTS" = "zig" ] ; then 
    rm -f ./*.perflog
    SUBJECTS="zap jetzig tokamak tokamak-old zigstd http.zig"
fi

if [ -z "$SUBJECTS" ] ; then
    rm -f ./*.perflog
    SUBJECTS="zap jetzig tokamak tokamak-old facilio zigstd go python-sanic rust-axum facilio http.zig"
fi

for S in $SUBJECTS; do
    L="$S.perflog"
    rm -f ./$L
    for R in 1 ; do
        ./measure.sh $S | tee -a ./$L
    done
done

echo "Finished"
