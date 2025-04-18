# Create simulator
set ns [new Simulator]

# Create trace and NAM output files
set tracefile [open bus.tr w]
set nf [open bus.nam w]

$ns trace-all $tracefile
$ns namtrace-all $nf

# Finish procedure
proc finish {} {
    global ns tracefile nf
    $ns flush-trace
    close $tracefile
    close $nf
    exec nam bus.nam &
    exit 0
}

# Create nodes
set bus [$ns node]  ;# central bus node
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# Connect all nodes to the bus node
$ns duplex-link $n1 $bus 10Mb 10ms DropTail
$ns duplex-link $n2 $bus 10Mb 10ms DropTail
$ns duplex-link $n3 $bus 10Mb 10ms DropTail
$ns duplex-link $n4 $bus 10Mb 10ms DropTail
$ns duplex-link $n5 $bus 10Mb 10ms DropTail

# Setup routing
$ns rtproto DV

# TCP traffic from n1 to n3
set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 1.0 "$ftp start"
$ns at 5.0 "finish"

$ns run

