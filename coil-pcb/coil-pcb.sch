EESchema Schematic File Version 4
LIBS:coil-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L pspice:INDUCTOR L1
U 1 1 5BB90D0E
P 2200 4400
F 0 "L1" H 2200 4615 50  0000 C CNN
F 1 "INDUCTOR" H 2200 4524 50  0000 C CNN
F 2 "Blisplay:coil" H 2200 4400 50  0001 C CNN
F 3 "" H 2200 4400 50  0001 C CNN
	1    2200 4400
	1    0    0    -1  
$EndComp
Text GLabel 1800 4400 0    50   Input ~ 0
A
Text GLabel 2550 4400 2    50   Input ~ 0
B
$Comp
L Connector:Conn_01x01 J1
U 1 1 5BB93740
P 1900 4700
F 0 "J1" V 1773 4780 50  0000 L CNN
F 1 "Conn_01x01" V 2000 4500 50  0000 L CNN
F 2 "Connectors:Pin_d0.7mm_L6.5mm_W1.8mm_FlatFork" H 1900 4700 50  0001 C CNN
F 3 "~" H 1900 4700 50  0001 C CNN
	1    1900 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	1900 4500 1900 4400
Wire Wire Line
	1900 4400 1950 4400
Wire Wire Line
	1800 4400 1900 4400
Connection ~ 1900 4400
$Comp
L Connector:Conn_01x01 J2
U 1 1 5BB9378B
P 2450 4700
F 0 "J2" V 2323 4780 50  0000 L CNN
F 1 "Conn_01x01" V 2414 4780 50  0000 L CNN
F 2 "Connectors:Pin_d0.7mm_L6.5mm_W1.8mm_FlatFork" H 2450 4700 50  0001 C CNN
F 3 "~" H 2450 4700 50  0001 C CNN
	1    2450 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	2450 4400 2450 4500
Wire Wire Line
	2450 4400 2550 4400
Connection ~ 2450 4400
$EndSCHEMATC
