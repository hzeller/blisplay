EESchema Schematic File Version 4
LIBS:blisplay-driver-cache
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
L blisplay-driver-rescue:ULN2803A-interface U21
U 1 1 5BCA4A44
P 4050 4750
F 0 "U21" H 4050 5317 50  0000 C CNN
F 1 "ULN2803A" H 4050 5226 50  0000 C CNN
F 2 "Housings_SOIC:SOIC-18W_7.5x11.6mm_Pitch1.27mm" H 4100 4100 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/uln2803a.pdf" H 4150 4650 50  0001 C CNN
	1    4050 4750
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:ULN2803A-interface U11
U 1 1 5BCA59BE
P 4000 2550
F 0 "U11" H 4000 3117 50  0000 C CNN
F 1 "ULN2803A" H 4000 3026 50  0000 C CNN
F 2 "Housings_SOIC:SOIC-18W_7.5x11.6mm_Pitch1.27mm" H 4050 1900 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/uln2803a.pdf" H 4100 2450 50  0001 C CNN
	1    4000 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5BCA80EA
P 4000 3250
F 0 "#PWR08" H 4000 3000 50  0001 C CNN
F 1 "GND" H 4005 3077 50  0000 C CNN
F 2 "" H 4000 3250 50  0001 C CNN
F 3 "" H 4000 3250 50  0001 C CNN
	1    4000 3250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5BCA8520
P 4050 5450
F 0 "#PWR07" H 4050 5200 50  0001 C CNN
F 1 "GND" H 4055 5277 50  0000 C CNN
F 2 "" H 4050 5450 50  0001 C CNN
F 3 "" H 4050 5450 50  0001 C CNN
	1    4050 5450
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:74HC595-Logic_74xx U2
U 1 1 5BCAB656
P 2800 4850
F 0 "U2" V 2850 5050 50  0000 C CNN
F 1 "74HC595" V 2800 4700 50  0000 C CNN
F 2 "Housings_SSOP:TSSOP-16_4.4x5mm_Pitch0.65mm" H 2800 4850 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/74HC_HCT595.pdf" H 2800 4850 50  0001 C CNN
	1    2800 4850
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:74HC595-Logic_74xx U1
U 1 1 5BCABF0D
P 2750 2650
F 0 "U1" V 2800 2850 50  0000 C CNN
F 1 "74HC595" V 2750 2500 50  0000 C CNN
F 2 "Housings_SSOP:TSSOP-16_4.4x5mm_Pitch0.65mm" H 2750 2650 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/74HC_HCT595.pdf" H 2750 2650 50  0001 C CNN
	1    2750 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5BCAF88F
P 2750 3450
F 0 "#PWR06" H 2750 3200 50  0001 C CNN
F 1 "GND" H 2755 3277 50  0000 C CNN
F 2 "" H 2750 3450 50  0001 C CNN
F 3 "" H 2750 3450 50  0001 C CNN
	1    2750 3450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5BCAFD54
P 2800 5650
F 0 "#PWR04" H 2800 5400 50  0001 C CNN
F 1 "GND" H 2950 5550 50  0000 C CNN
F 2 "" H 2800 5650 50  0001 C CNN
F 3 "" H 2800 5650 50  0001 C CNN
	1    2800 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 4550 3300 4550
Wire Wire Line
	3300 4650 3650 4650
Wire Wire Line
	3650 4750 3300 4750
Wire Wire Line
	3300 4850 3650 4850
Wire Wire Line
	3650 4950 3300 4950
Wire Wire Line
	3300 5050 3650 5050
Wire Wire Line
	3650 5150 3300 5150
Wire Wire Line
	3250 2350 3600 2350
Wire Wire Line
	3250 2450 3600 2450
Wire Wire Line
	3250 2550 3600 2550
Wire Wire Line
	3600 2650 3250 2650
Wire Wire Line
	3250 2750 3600 2750
Wire Wire Line
	3600 2850 3250 2850
Wire Wire Line
	3250 2950 3600 2950
$Comp
L power:+5V #PWR01
U 1 1 5BCB7863
P 1600 3550
F 0 "#PWR01" H 1600 3400 50  0001 C CNN
F 1 "+5V" H 1615 3723 50  0000 C CNN
F 2 "" H 1600 3550 50  0001 C CNN
F 3 "" H 1600 3550 50  0001 C CNN
	1    1600 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5BCB88FE
P 1600 4050
F 0 "#PWR02" H 1600 3800 50  0001 C CNN
F 1 "GND" V 1605 3922 50  0000 R CNN
F 2 "" H 1600 4050 50  0001 C CNN
F 3 "" H 1600 4050 50  0001 C CNN
	1    1600 4050
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:Conn_01x06-Connector J1
U 1 1 5BCBBB09
P 1250 3750
F 0 "J1" H 1168 3225 50  0000 C CNN
F 1 "Conn_01x06" H 1168 3316 50  0000 C CNN
F 2 "Connectors_JST:JST_EH_S06B-EH_06x2.50mm_Angled" H 1250 3750 50  0001 C CNN
F 3 "~" H 1250 3750 50  0001 C CNN
	1    1250 3750
	-1   0    0    -1  
$EndComp
Text Label 1600 3650 0    50   ~ 0
MISO
Text Label 1600 3750 0    50   ~ 0
SCK
Wire Wire Line
	2750 3450 2250 3450
Wire Wire Line
	2250 3450 2250 2850
Connection ~ 2750 3450
Wire Wire Line
	2300 4750 2250 4750
Wire Wire Line
	2250 4750 2250 4150
Wire Wire Line
	2250 4150 2800 4150
$Comp
L power:+5V #PWR05
U 1 1 5BCCEEC3
P 2750 1950
F 0 "#PWR05" H 2750 1800 50  0001 C CNN
F 1 "+5V" H 2900 2000 50  0000 C CNN
F 2 "" H 2750 1950 50  0001 C CNN
F 3 "" H 2750 1950 50  0001 C CNN
	1    2750 1950
	1    0    0    -1  
$EndComp
Connection ~ 2750 1950
$Comp
L power:+5V #PWR03
U 1 1 5BCD2FC7
P 2800 4150
F 0 "#PWR03" H 2800 4000 50  0001 C CNN
F 1 "+5V" H 2950 4200 50  0000 C CNN
F 2 "" H 2800 4150 50  0001 C CNN
F 3 "" H 2800 4150 50  0001 C CNN
	1    2800 4150
	1    0    0    -1  
$EndComp
Connection ~ 2800 4150
Text Label 1600 3850 0    50   ~ 0
CS
Wire Wire Line
	2050 2750 2250 2750
Wire Wire Line
	2250 2550 2150 2550
Wire Wire Line
	2150 2550 2150 1950
Wire Wire Line
	2150 1950 2750 1950
Wire Wire Line
	2100 2450 2250 2450
Text Label 3250 3250 0    50   ~ 0
carry
$Comp
L blisplay-driver-rescue:C-device C1
U 1 1 5BCF7DDB
P 6300 2800
F 0 "C1" H 6350 2900 50  0000 L CNN
F 1 "C" H 6415 2755 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6338 2650 50  0001 C CNN
F 3 "" H 6300 2800 50  0001 C CNN
	1    6300 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5BCFA267
P 6300 2950
F 0 "#PWR0101" H 6300 2700 50  0001 C CNN
F 1 "GND" H 6450 2850 50  0000 C CNN
F 2 "" H 6300 2950 50  0001 C CNN
F 3 "" H 6300 2950 50  0001 C CNN
	1    6300 2950
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 5BCFB005
P 6300 2650
F 0 "#PWR0102" H 6300 2500 50  0001 C CNN
F 1 "+5V" H 6315 2823 50  0000 C CNN
F 2 "" H 6300 2650 50  0001 C CNN
F 3 "" H 6300 2650 50  0001 C CNN
	1    6300 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5BD01A68
P 2300 5100
F 0 "#PWR0103" H 2300 4850 50  0001 C CNN
F 1 "GND" H 2450 5000 50  0000 C CNN
F 2 "" H 2300 5100 50  0001 C CNN
F 3 "" H 2300 5100 50  0001 C CNN
	1    2300 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 5050 2300 5100
$Comp
L blisplay-driver-rescue:C-device C2
U 1 1 5BD64E2D
P 6050 2800
F 0 "C2" H 6100 2900 50  0000 L CNN
F 1 "C" H 6165 2755 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6088 2650 50  0001 C CNN
F 3 "" H 6050 2800 50  0001 C CNN
	1    6050 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 2650 6300 2650
Connection ~ 6300 2650
Wire Wire Line
	6050 2950 6300 2950
Connection ~ 6300 2950
Wire Wire Line
	3250 4300 2300 4300
Wire Wire Line
	2300 4300 2300 4450
Wire Wire Line
	3250 3150 3250 4300
Wire Wire Line
	2100 4650 2300 4650
Wire Wire Line
	2050 4950 2300 4950
Wire Wire Line
	2250 2250 1950 2250
Wire Wire Line
	1900 5500 3300 5500
Wire Wire Line
	3300 5500 3300 5350
Wire Wire Line
	3300 4450 3650 4450
Text Label 1600 3950 0    50   ~ 0
MOSI
Wire Wire Line
	1950 3950 1450 3950
Wire Wire Line
	1950 2250 1950 3950
Wire Wire Line
	2050 2750 2050 3850
Wire Wire Line
	1450 3850 2050 3850
Connection ~ 2050 3850
Wire Wire Line
	2050 3850 2050 4950
Wire Wire Line
	2100 2450 2100 3750
Wire Wire Line
	1450 3750 2100 3750
Connection ~ 2100 3750
Wire Wire Line
	2100 3750 2100 4650
Wire Wire Line
	1450 3650 1900 3650
Wire Wire Line
	1900 3650 1900 5500
Wire Wire Line
	1450 4050 1600 4050
$Comp
L blisplay-driver-rescue:Conn_01x03-Connector J2
U 1 1 5BCCEB4F
P 5450 4950
F 0 "J2" H 5530 4992 50  0000 L CNN
F 1 "Conn_01x03" H 5530 4901 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5450 4950 50  0001 C CNN
F 3 "~" H 5450 4950 50  0001 C CNN
	1    5450 4950
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:Conn_01x03-Connector J3
U 1 1 5BCD02A1
P 5450 4350
F 0 "J3" H 5530 4392 50  0000 L CNN
F 1 "Conn_01x03" H 5530 4301 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5450 4350 50  0001 C CNN
F 3 "~" H 5450 4350 50  0001 C CNN
	1    5450 4350
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:Conn_01x03-Connector J4
U 1 1 5BCD08F2
P 5350 3200
F 0 "J4" H 5430 3242 50  0000 L CNN
F 1 "Conn_01x03" H 5430 3151 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5350 3200 50  0001 C CNN
F 3 "~" H 5350 3200 50  0001 C CNN
	1    5350 3200
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:Conn_01x03-Connector J5
U 1 1 5BCD15D5
P 5350 2750
F 0 "J5" H 5268 2425 50  0000 C CNN
F 1 "Conn_01x03" V 5500 2800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5350 2750 50  0001 C CNN
F 3 "~" H 5350 2750 50  0001 C CNN
	1    5350 2750
	1    0    0    1   
$EndComp
$Comp
L blisplay-driver-rescue:Conn_01x03-Connector J6
U 1 1 5BCD1FA6
P 5350 2350
F 0 "J6" H 5268 2025 50  0000 C CNN
F 1 "Conn_01x03" H 5268 2116 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5350 2350 50  0001 C CNN
F 3 "~" H 5350 2350 50  0001 C CNN
	1    5350 2350
	1    0    0    1   
$EndComp
Wire Wire Line
	5150 3300 5150 5150
Wire Wire Line
	5150 5150 4450 5150
Wire Wire Line
	4450 5050 5250 5050
Wire Wire Line
	4450 4950 5100 4950
Wire Wire Line
	5100 4950 5100 4450
Wire Wire Line
	5100 4450 5250 4450
Wire Wire Line
	5250 4950 5200 4950
Wire Wire Line
	5200 4950 5200 4850
Wire Wire Line
	5200 4850 4450 4850
Wire Wire Line
	5250 4350 4950 4350
Wire Wire Line
	4950 4350 4950 4750
Wire Wire Line
	4950 4750 4450 4750
Wire Wire Line
	4450 4650 5250 4650
Wire Wire Line
	5250 4650 5250 4850
NoConn ~ 4400 2250
Wire Wire Line
	4400 2350 4700 2350
Wire Wire Line
	4700 2350 4700 2250
Wire Wire Line
	4700 2250 5150 2250
Wire Wire Line
	4400 2450 4700 2450
Wire Wire Line
	4700 2450 4700 2650
Wire Wire Line
	4700 2650 5150 2650
Wire Wire Line
	4400 2550 4850 2550
Wire Wire Line
	4850 2550 4850 2350
Wire Wire Line
	4850 2350 5150 2350
Wire Wire Line
	4400 2650 4600 2650
Wire Wire Line
	4600 2650 4600 2750
Wire Wire Line
	4600 2750 5150 2750
Wire Wire Line
	4400 2750 4550 2750
Wire Wire Line
	4550 2750 4550 2500
Wire Wire Line
	4550 2500 5150 2500
Wire Wire Line
	5150 2500 5150 2450
Wire Wire Line
	4400 2850 5150 2850
Wire Wire Line
	4400 2950 4750 2950
Wire Wire Line
	4750 2950 4750 3200
Wire Wire Line
	4750 3200 5150 3200
Wire Wire Line
	4450 4550 4900 4550
Wire Wire Line
	4900 4550 4900 4250
Wire Wire Line
	4900 4250 5250 4250
Wire Wire Line
	4450 4450 4650 4450
Wire Wire Line
	4650 4450 4650 3100
Wire Wire Line
	4650 3100 5150 3100
$Comp
L blisplay-driver-rescue:LED-device D1
U 1 1 5BD39E39
P 3500 1950
F 0 "D1" H 3493 1695 50  0000 C CNN
F 1 "LED" H 3493 1786 50  0000 C CNN
F 2 "LEDs:LED_0603" H 3500 1950 50  0001 C CNN
F 3 "~" H 3500 1950 50  0001 C CNN
	1    3500 1950
	-1   0    0    1   
$EndComp
$Comp
L blisplay-driver-rescue:R-device R1
U 1 1 5BD3C356
P 3250 2100
F 0 "R1" H 3180 2054 50  0000 R CNN
F 1 "1k" H 3180 2145 50  0000 R CNN
F 2 "Resistors_SMD:R_0603" V 3180 2100 50  0001 C CNN
F 3 "" H 3250 2100 50  0001 C CNN
	1    3250 2100
	-1   0    0    1   
$EndComp
Wire Wire Line
	3250 1950 3350 1950
$Comp
L power:GND #PWR0104
U 1 1 5BD441BC
P 3650 2000
F 0 "#PWR0104" H 3650 1750 50  0001 C CNN
F 1 "GND" H 3750 2000 50  0000 C CNN
F 2 "" H 3650 2000 50  0001 C CNN
F 3 "" H 3650 2000 50  0001 C CNN
	1    3650 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 1950 3650 2000
$Comp
L blisplay-driver-rescue:Conn_01x01-Connector J7
U 1 1 5BD4C259
P 6050 3600
F 0 "J7" H 6130 3642 50  0000 L CNN
F 1 "Conn_01x01" H 6130 3551 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 6050 3600 50  0001 C CNN
F 3 "~" H 6050 3600 50  0001 C CNN
	1    6050 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5BD4DA9E
P 5850 3600
F 0 "#PWR0105" H 5850 3350 50  0001 C CNN
F 1 "GND" H 5855 3427 50  0000 C CNN
F 2 "" H 5850 3600 50  0001 C CNN
F 3 "" H 5850 3600 50  0001 C CNN
	1    5850 3600
	1    0    0    -1  
$EndComp
$Comp
L blisplay-driver-rescue:Conn_01x01-Connector J8
U 1 1 5BD5496C
P 6050 3900
F 0 "J8" H 6130 3942 50  0000 L CNN
F 1 "Conn_01x01" H 6130 3851 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 6050 3900 50  0001 C CNN
F 3 "~" H 6050 3900 50  0001 C CNN
	1    6050 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5BD54972
P 5850 3900
F 0 "#PWR0106" H 5850 3650 50  0001 C CNN
F 1 "GND" H 5855 3727 50  0000 C CNN
F 2 "" H 5850 3900 50  0001 C CNN
F 3 "" H 5850 3900 50  0001 C CNN
	1    5850 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 3550 1600 3550
Wire Wire Line
	3250 2250 3600 2250
Connection ~ 3250 2250
Text Notes 4400 2150 0    50   ~ 0
NC, but usable\nif needed.
Text Label 3350 2250 0    50   ~ 0
Bit0
$EndSCHEMATC
