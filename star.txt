# Create a simulator object
set ns [new Simulator]

# Create trace and NAM files
set tracefile [open star.tr w]
set nf [open star.nam w]
$ns trace-all $tracefile
$ns namtrace-all $nf

# Procedure to close the simulation
proc finish {} {
    global ns tracefile nf
    $ns flush-trace
    close $tracefile
    close $nf
    exec nam star.nam &
    exit 0
}

# Create central hub node
set hub [$ns node]

# Create peripheral nodes
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# Connect peripheral nodes to the central hub
$ns duplex-link $hub $n1 10Mb 10ms DropTail
$ns duplex-link $hub $n2 10Mb 10ms DropTail
$ns duplex-link $hub $n3 10Mb 10ms DropTail
$ns duplex-link $hub $n4 10Mb 10ms DropTail
$ns duplex-link $hub $n5 10Mb 10ms DropTail

# Setup routing protocol
$ns rtproto DV

# Setup TCP traffic from n1 to n5
set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Start traffic
$ns at 1.0 "$ftp start"

# Finish simulation
$ns at 5.0 "finish"

# Run the simulation
$ns run

