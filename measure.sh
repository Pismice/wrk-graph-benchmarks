#! /usr/bin/env bash
THREADS=4
CONNECTIONS=400
DURATION_SECONDS=30

SUBJECT=$1


TSK_SRV="taskset -c 0,1,2,3"
TSK_LOAD="taskset -c 4,5,6,7"

if [ "$SUBJECT" = "" ] ; then
    echo "usage: $0 subject    # subject: zig or go"
    exit 1
fi

if [ "$SUBJECT" = "std-original" ] ; then
    cd std-original && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "std-monothread-sans-accept" ] ; then
    cd ./std-monothread-sans-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "std-monothread-accept" ] ; then
    cd ./std-monothread-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "std-multi-12-accept" ] ; then
    cd ./std-multi-12-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "std-multi-12-sans-accept" ] ; then
    cd ./std-multi-12-sans-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "std-multi-6-accept" ] ; then
    cd ./std-multi-6-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "std-multi-6-sans-accept" ] ; then
    cd ./std-multi-6-sans-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "facilio" ] ; then
    cd ./facilio
    $TSK_SRV make run /dev/null &
    PID=$!
    URL=http://127.0.0.1:3000
fi

if [ "$SUBJECT" = "jetzig" ] ; then
    cd ./jetzig && zig build -Doptimize=ReleaseFast
    $TSK_SRV ./zig-out/bin/jetzig --log-level FATAL &
    PID=$!
    URL=http://127.0.0.1:8080
fi

if [ "$SUBJECT" = "http.zig" ] ; then
    cd ./http.zig && zig build -Doptimize=ReleaseFast
    $TSK_SRV ./zig-out/bin/httpo &
    PID=$!
    URL=http://127.0.0.1:5882
fi

if [ "$SUBJECT" = "httpz-db" ] ; then
    cd ./httpz-db && zig build -Doptimize=ReleaseFast
    $TSK_SRV ./zig-out/bin/te &
    PID=$!
    URL=http://127.0.0.1:1950
fi

if [ "$SUBJECT" = "std-db" ] ; then
    cd ./std-db && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./std &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "tokamak" ] ; then
    cd ./tokamak && zig build -Doptimize=ReleaseFast
    $TSK_SRV ./zig-out/bin/toka> /dev/null &
    PID=$!
    URL=http://127.0.0.1:8080
fi

if [ "$SUBJECT" = "tokamak-old" ] ; then
    cd ./tokamak-old && zig build -Doptimize=ReleaseFast
    $TSK_SRV ./zig-out/bin/tokamak> /dev/null &
    PID=$!
    URL=http://127.0.0.1:8080
fi

if [ "$SUBJECT" = "zap" ] ; then
    cd ./zap && zig build -Doptimize=ReleaseFast
    $TSK_SRV ./zig-out/bin/zapo> /dev/null &
    PID=$!
    URL=http://127.0.0.1:3000
fi

if [ "$SUBJECT" = "zigstd" ] ; then
    cd ./std-multi-12-sans-accept && zig build -Doptimize=ReleaseFast
    cd zig-out/bin
    $TSK_SRV ./stdhttp &
    PID=$!
    URL=http://127.0.0.1:4242
fi

if [ "$SUBJECT" = "go" ] ; then
    cd ./go && go build main.go 
    $TSK_SRV ./main &
    PID=$!
    URL=http://127.0.0.1:8090/hello
fi

if [ "$SUBJECT" = "python" ] ; then
    $TSK_SRV python3 ./python/main.py &
    PID=$!
    URL=http://127.0.0.1:8080
fi

if [ "$SUBJECT" = "python-sanic" ] ; then
    $TSK_SRV python3 ./sanic/sanic-app.py &
    PID=$!
    URL=http://127.0.0.1:8000
fi

if [ "$SUBJECT" = "rust-bythebook" ] ; then
    cd ./rust/bythebook && cargo build --release
    $TSK_SRV ./target/release/hello &
    PID=$!
    URL=http://127.0.0.1:7878
fi

if [ "$SUBJECT" = "rust-bythebook-improved" ] ; then
    cd ./rust/bythebook-improved && cargo build --release
    $TSK_SRV ./target/release/hello &
    PID=$!
    URL=http://127.0.0.1:7878
fi


if [ "$SUBJECT" = "rust-clean" ] ; then
    cd ./rust/clean && cargo build --release
    $TSK_SRV ./target/release/hello &
    PID=$!
    URL=http://127.0.0.1:7878
fi

if [ "$SUBJECT" = "rust-axum" ] ; then
    cd ./axum/hello-axum && cargo build --release
    $TSK_SRV ./target/release/hello-axum &
    PID=$!
    URL=http://127.0.0.1:3000
fi

sleep 1
echo "========================================================================"
echo "                          $SUBJECT"
echo "========================================================================"
$TSK_LOAD wrk -c $CONNECTIONS -t $THREADS -d $DURATION_SECONDS --latency $URL 

kill $PID

