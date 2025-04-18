# Create a simulator object
set ns [new Simulator]

# Open trace and NAM files
set tracefile [open ring.tr w]
set nf [open ring.nam w]

$ns trace-all $tracefile
$ns namtrace-all $nf

# Define finish procedure
proc finish {} {
    global ns tracefile nf
    $ns flush-trace
    close $tracefile
    close $nf
    exec nam ring.nam &
    exit 0
}

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

# Create ring connections
$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns duplex-link $n2 $n3 10Mb 10ms DropTail
$ns duplex-link $n3 $n4 10Mb 10ms DropTail
$ns duplex-link $n4 $n0 10Mb 10ms DropTail ;# closes the ring

# Setup routing
$ns rtproto DV

# TCP agent and application
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Start and finish the simulation
$ns at 1.0 "$ftp start"
$ns at 5.0 "finish"

# Run the simulation
$ns run

