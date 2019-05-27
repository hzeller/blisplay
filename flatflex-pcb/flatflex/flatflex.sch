EESchema Schematic File Version 4
LIBS:flatflex-cache
EELAYER 29 0
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
L Connector_Generic:Conn_01x12 J10
U 1 1 5CEC1AB9
P 1450 2600
F 0 "J10" H 1368 3317 50  0000 C CNN
F 1 "Conn_01x12" H 1368 3226 50  0000 C CNN
F 2 "blisplay:flex-12" H 1450 2600 50  0001 C CNN
F 3 "~" H 1450 2600 50  0001 C CNN
	1    1450 2600
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 5CEC3A7C
P 3000 2600
F 0 "J3" H 3150 2500 50  0000 C CNN
F 1 "Coil-3" H 3100 2600 50  0000 L CNN
F 2 "blisplay:flex-coil-connect" H 3000 2600 50  0001 C CNN
F 3 "~" H 3000 2600 50  0001 C CNN
	1    3000 2600
	1    0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 5CEC4CBC
P 3000 2400
F 0 "J2" H 3150 2300 50  0000 C CNN
F 1 "Coil-2" H 3100 2400 50  0000 L CNN
F 2 "blisplay:flex-coil-connect" H 3000 2400 50  0001 C CNN
F 3 "~" H 3000 2400 50  0001 C CNN
	1    3000 2400
	1    0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 5CEC5D4E
P 3000 2700
F 0 "J4" H 3100 2700 50  0000 L CNN
F 1 "Coil-4" H 3100 2600 50  0000 L CNN
F 2 "blisplay:flex-coil-connect" H 3000 2700 50  0001 C CNN
F 3 "~" H 3000 2700 50  0001 C CNN
	1    3000 2700
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J5
U 1 1 5CEC62F5
P 3000 2900
F 0 "J5" H 3100 2900 50  0000 L CNN
F 1 "Coil-5" H 3100 2800 50  0000 L CNN
F 2 "blisplay:flex-coil-connect" H 3000 2900 50  0001 C CNN
F 3 "~" H 3000 2900 50  0001 C CNN
	1    3000 2900
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J6
U 1 1 5CEC662F
P 3000 3100
F 0 "J6" H 3100 3100 50  0000 L CNN
F 1 "Coil-6" H 3100 3000 50  0000 L CNN
F 2 "blisplay:flex-coil-connect" H 3000 3100 50  0001 C CNN
F 3 "~" H 3000 3100 50  0001 C CNN
	1    3000 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 2100 2800 2100
Wire Wire Line
	1650 2200 2800 2200
Wire Wire Line
	1650 2300 2800 2300
Wire Wire Line
	2800 2400 1650 2400
Wire Wire Line
	1650 2500 2800 2500
Wire Wire Line
	2800 2600 1650 2600
Wire Wire Line
	1650 2700 2800 2700
Wire Wire Line
	2800 2800 1650 2800
Wire Wire Line
	1650 2900 2800 2900
Wire Wire Line
	2800 3000 1650 3000
Wire Wire Line
	1650 3100 2800 3100
Wire Wire Line
	2800 3200 1650 3200
Text Label 2000 2100 0    50   ~ 0
bottom-1
Text Label 2000 2200 0    50   ~ 0
top-1
Text Label 2000 2300 0    50   ~ 0
bottom-2
Text Label 2000 2400 0    50   ~ 0
top-2
Text Label 2000 2500 0    50   ~ 0
bottom-3
Text Label 2000 2600 0    50   ~ 0
top-3
Text Label 2000 2700 0    50   ~ 0
top-4
Text Label 2000 2800 0    50   ~ 0
bottom-4
Text Label 2000 2900 0    50   ~ 0
top-5
Text Label 2000 3000 0    50   ~ 0
bottom-5
Text Label 2000 3100 0    50   ~ 0
top-6
Text Label 2000 3200 0    50   ~ 0
bottom-6
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5CEC54DD
P 3000 2200
F 0 "J1" H 3150 2100 50  0000 C CNN
F 1 "Coil-1" H 3100 2200 50  0000 L CNN
F 2 "blisplay:flex-coil-connect" H 3000 2200 50  0001 C CNN
F 3 "~" H 3000 2200 50  0001 C CNN
	1    3000 2200
	1    0    0    1   
$EndComp
$EndSCHEMATC
