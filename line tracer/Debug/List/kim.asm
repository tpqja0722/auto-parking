
;CodeVisionAVR C Compiler V3.37 Evaluation
;(C) Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _bt_flag=R5
	.DEF _cnt=R4
	.DEF _left=R7
	.DEF _right=R6
	.DEF _rx0_cnt=R9
	.DEF _rx1_cnt=R8
	.DEF _gg=R11
	.DEF _sensor=R10
	.DEF _cnt_back=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_int
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart1_rx_int
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x0:
	.DB  0x41,0x54,0xD,0xA,0x0,0x41,0x54,0x2B
	.DB  0x52,0x53,0x54,0xD,0xA,0x0,0x41,0x54
	.DB  0x2B,0x43,0x57,0x4D,0x4F,0x44,0x45,0x3F
	.DB  0xD,0xA,0x0,0x41,0x54,0x2B,0x43,0x57
	.DB  0x4A,0x41,0x50,0x3D,0x0,0x44,0x44,0x44
	.DB  0x44,0x0,0x31,0x31,0x31,0x31,0x31,0x31
	.DB  0x31,0x31,0x0,0x41,0x54,0x2B,0x43,0x57
	.DB  0x4A,0x41,0x50,0x3F,0xD,0xA,0x0,0x41
	.DB  0x54,0x2B,0x43,0x49,0x46,0x53,0x52,0xD
	.DB  0xA,0x0,0x41,0x54,0x2B,0x43,0x49,0x50
	.DB  0x53,0x54,0x41,0x52,0x54,0x3D,0x0,0x54
	.DB  0x43,0x50,0x0,0x31,0x39,0x32,0x2E,0x31
	.DB  0x36,0x38,0x2E,0x34,0x33,0x2E,0x31,0x35
	.DB  0x0,0x38,0x30,0x30,0x31,0xD,0xA,0x0
	.DB  0x41,0x54,0x2B,0x43,0x49,0x50,0x53,0x45
	.DB  0x4E,0x44,0x3D,0x36,0xD,0xA,0x0,0x4D
	.DB  0x79,0x6F,0x75,0x6E,0x67,0xD,0xA,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x500

	.CSEG
;/*******************************************************
;This program was created by the CodeWizardAVR V3.37
;Automatic Program Generator
;© Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 2019-11-03
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega128
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 1024
;*******************************************************/
;
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <delay.h>
;
;unsigned char rx_bt[20];
;char bt_flag=0;
;char cnt=0,left=0,right=0;
;
;
;// motor 1   //left motor
;#define mt1_cw  PORTB.5 // oc1a
;#define mt1_ccw PORTB.6 // oc1b
;
;// motor 2   //rithgt motor
;#define mt2_cw PORTE.4 // oc3b
;#define mt2_ccw  PORTE.3 // oc3a
;
;
;#define m_all_stop (mt1_cw = 0, mt2_ccw = 0, mt2_cw = 0, mt2_ccw = 0);
;//#define m1_stop    (mt1_cw = 0, mt1_ccw = 0)
;//#define m2_stop    (mt2_cw = 0,mt2_ccw = 0)
;
;#define m1_cw     (mt1_cw = 1, mt1_ccw = 0)
;#define m1_ccw    (mt1_cw = 0, mt1_ccw = 1)   //Á¤
;#define m2_cw     (mt2_cw = 1, mt2_ccw = 0)
;#define m2_ccw    (mt2_cw = 0, mt2_ccw = 1)   //Á¤
;#define m1_st     (mt1_cw = 0, mt1_ccw = 0)
;#define m2_st     (mt2_cw = 0, mt2_ccw = 0)
;
;#define gogo (m1_ccw,m2_ccw)
;#define back (m1_cw,  m2_cw)
;
;#include "uart_lib.h"

	.CSEG
_uart0_init:
; .FSTART _uart0_init
	LDI  R30,LOW(0)
	OUT  0xB,R30
	LDI  R30,LOW(152)
	OUT  0xA,R30
	LDI  R30,LOW(6)
	STS  149,R30
	LDI  R30,LOW(0)
	STS  144,R30
	LDI  R30,LOW(103)
	OUT  0x9,R30
	RET
; .FEND
_uart1_init:
; .FSTART _uart1_init
	LDI  R30,LOW(0)
	STS  155,R30
	LDI  R30,LOW(152)
	STS  154,R30
	LDI  R30,LOW(6)
	STS  157,R30
	LDI  R30,LOW(0)
	STS  152,R30
	LDI  R30,LOW(103)
	STS  153,R30
	RET
; .FEND
_tx_chk:
; .FSTART _tx_chk
	ST   -Y,R17
	MOV  R17,R26
;	ch -> R17
	CPI  R17,0
	BRNE _0x3
	SBIS 0xB,5
	RJMP _0x4
	LDI  R30,LOW(1)
	RJMP _0x2060001
_0x4:
	LDI  R30,LOW(0)
	RJMP _0x2060001
_0x3:
	LDS  R30,155
	ANDI R30,LOW(0x20)
	BREQ _0x7
	LDI  R30,LOW(1)
	RJMP _0x2060001
_0x7:
	LDI  R30,LOW(0)
_0x2060001:
	LD   R17,Y+
	RET
; .FEND
_tx_send:
; .FSTART _tx_send
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
;	tx_data -> R16
;	ch -> R17
_0x9:
	MOV  R26,R17
	RCALL _tx_chk
	CPI  R30,0
	BREQ _0x9
	MOV  R26,R17
	RCALL _tx_chk
	CPI  R30,LOW(0x1)
	BRNE _0xC
	CPI  R17,0
	BRNE _0xD
	OUT  0xC,R16
	RJMP _0xE
_0xD:
	STS  156,R16
_0xE:
_0xC:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
;	*tx_d -> R18,R19
;	ch -> R17
_usart0_rx_int:
; .FSTART _usart0_rx_int
	RCALL SUBOPT_0x0
;	buf -> R17
	IN   R17,12
	ST   -Y,R17
	LDI  R26,LOW(1)
	RCALL _tx_send
	ST   -Y,R17
	LDI  R26,LOW(0)
	RCALL _tx_send
	RJMP _0x3AD
; .FEND
_usart1_rx_int:
; .FSTART _usart1_rx_int
	RCALL SUBOPT_0x0
;	buf -> R17
	LDS  R17,156
	__PUTBMRN _rx_bt,1,17
	CLR  R4
	ST   -Y,R17
	LDI  R26,LOW(0)
	RCALL _tx_send
	__GETB2MN _rx_bt,1
	CPI  R26,LOW(0xD)
	BRNE _0x12
	RCALL SUBOPT_0x1
	LDI  R26,LOW(250)
	LDI  R27,0
	RCALL _delay_ms
_0x12:
_0x3AD:
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;#include "my_Esp8266.h"
;
;char gg;
;unsigned char sensor;
;bit chk_flag = 0;
;char cnt_back = 0;
;
;
;void gogo_gogo(void)
; 0000 0041 {
; 0000 0042     gogo;
; 0000 0043     delay_ms(10);
; 0000 0044     m_all_stop;
; 0000 0045     delay_ms(10);
; 0000 0046     gogo;
; 0000 0047     delay_ms(10);
; 0000 0048     m_all_stop;
; 0000 0049     delay_ms(10);
; 0000 004A }
;
;void gogo_left(void)
; 0000 004D {
_gogo_left:
; .FSTART _gogo_left
; 0000 004E     do
_0x3C:
; 0000 004F     {
; 0000 0050       sensor = (~(PINF & 0x0f));
	RCALL SUBOPT_0x2
; 0000 0051       sensor &= 0x0f;
; 0000 0052       // m_all_stop;
; 0000 0053       //delay_ms(10);
; 0000 0054 
; 0000 0055       //gogo;
; 0000 0056       //delay_ms(200);
; 0000 0057       //m_all_stop;
; 0000 0058       m2_ccw;
	RCALL SUBOPT_0x3
; 0000 0059       m1_st;
; 0000 005A       //delay_ms(250);
; 0000 005B       left=1;
	LDI  R30,LOW(1)
	MOV  R7,R30
; 0000 005C 
; 0000 005D     }
; 0000 005E     while(sensor != 0x02);
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x3C
; 0000 005F     //PORTE.3 = 1;
; 0000 0060     //mt2_ccw = 1;
; 0000 0061    //PORTB.5 = 1;
; 0000 0062     //mt1_cw  = 0;
; 0000 0063     //delay_ms(1000);
; 0000 0064 
; 0000 0065     //m_all_stop;
; 0000 0066     //gogo;
; 0000 0067     //delay_ms(50);
; 0000 0068 }
	RET
; .FEND
;
;void gogo_right(void)
; 0000 006B {
_gogo_right:
; .FSTART _gogo_right
; 0000 006C     //m_all_stop;
; 0000 006D     //delay_ms(10);
; 0000 006E 
; 0000 006F      do
_0x47:
; 0000 0070     {
; 0000 0071       sensor = (~(PINF & 0x0f));
	RCALL SUBOPT_0x2
; 0000 0072       sensor &= 0x0f;
; 0000 0073 
; 0000 0074       // m_all_stop;
; 0000 0075       //delay_ms(10);
; 0000 0076 
; 0000 0077       //gogo;
; 0000 0078       //delay_ms(200);
; 0000 0079       //m_all_stop;
; 0000 007A      m1_ccw;
	RCALL SUBOPT_0x4
; 0000 007B      m2_st;
; 0000 007C      /*
; 0000 007D      delay_ms(150);
; 0000 007E       sensor = (~(PINF & 0x0f));
; 0000 007F       sensor &= 0x0f;
; 0000 0080       */
; 0000 0081       right=1;
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0000 0082      //printf("%d",sensor);
; 0000 0083      }
; 0000 0084     while(sensor != 0x04);
	LDI  R30,LOW(4)
	CP   R30,R10
	BRNE _0x47
; 0000 0085     //gogo;
; 0000 0086     //delay_ms(200);
; 0000 0087     //m_all_stop;
; 0000 0088      //m1_ccw;
; 0000 0089      //m2_st;
; 0000 008A     //mt1_ccw = 1;
; 0000 008B     // mt2_cw  = 0;
; 0000 008C     //delay_ms(1200);
; 0000 008D 
; 0000 008E     //m_all_stop;
; 0000 008F     //gogo;
; 0000 0090     //delay_ms(50);
; 0000 0091 
; 0000 0092 }
	RET
; .FEND
;
;
;void station_1(void)
; 0000 0096 {
_station_1:
; .FSTART _station_1
; 0000 0097 
; 0000 0098     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 0099     {
; 0000 009A         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x54
	RCALL SUBOPT_0x5
	RJMP _0x53
; 0000 009B         case 0x02:  //sensor2();
_0x54:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x5D
; 0000 009C         m2_ccw; m1_st;              break;
	RCALL SUBOPT_0x3
	RJMP _0x53
; 0000 009D         case 0x04:  //sensor3();
_0x5D:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A2
; 0000 009E         m1_ccw; m2_st;              break;
; 0000 009F         case 0x0f:  gogo_left();    break;
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x6F
	RCALL _gogo_left
	RJMP _0x53
; 0000 00A0         case 0x09:  back;
_0x6F:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x70
	RCALL SUBOPT_0x1
; 0000 00A1                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 00A2                     m_all_stop;
; 0000 00A3                     rx_bt[1] = 0;
; 0000 00A4 
; 0000 00A5                                    break;
	RJMP _0x53
; 0000 00A6         case 0x01:  m2_ccw; m1_st; break;
_0x70:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x81
	RCALL SUBOPT_0x3
	RJMP _0x53
; 0000 00A7         case 0x08:  m1_ccw; m2_st; break;
_0x81:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x53
_0x3A2:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 00A8     }
_0x53:
; 0000 00A9 }
	RET
; .FEND
;
;void station_2(void)
; 0000 00AC {
_station_2:
; .FSTART _station_2
; 0000 00AD 
; 0000 00AE 
; 0000 00AF     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 00B0     {
; 0000 00B1 
; 0000 00B2         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x96
	RCALL SUBOPT_0x5
	RJMP _0x95
; 0000 00B3         case 0x02:  m2_ccw; m1_st;  break;
_0x96:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x9F
	RCALL SUBOPT_0x3
	RJMP _0x95
; 0000 00B4         case 0x04:  m1_ccw; m2_st;  break;
_0x9F:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A3
; 0000 00B5         case 0x0f:  gogo_right();
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0xB1
	RCALL _gogo_right
; 0000 00B6                     break;
	RJMP _0x95
; 0000 00B7         case 0x09:  back;
_0xB1:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0xB2
	RCALL SUBOPT_0x1
; 0000 00B8                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 00B9                     m_all_stop;
; 0000 00BA                     rx_bt[1] = 0;
; 0000 00BB 
; 0000 00BC                                    break;
	RJMP _0x95
; 0000 00BD         case 0x01:  m2_ccw; m1_st; break;
_0xB2:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xC3
	RCALL SUBOPT_0x3
	RJMP _0x95
; 0000 00BE         case 0x08:  m1_ccw; m2_st; break;
_0xC3:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x95
_0x3A3:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 00BF     }
_0x95:
; 0000 00C0 }
	RET
; .FEND
;
;void station_3(void)
; 0000 00C3 {
_station_3:
; .FSTART _station_3
; 0000 00C4 
; 0000 00C5     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 00C6     {
; 0000 00C7         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0xD8
	RCALL SUBOPT_0x5
	RJMP _0xD7
; 0000 00C8         case 0x02:  m2_ccw; m1_st;  break;
_0xD8:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xE1
	RCALL SUBOPT_0x3
	RJMP _0xD7
; 0000 00C9         case 0x04:  m1_ccw; m2_st;  break;
_0xE1:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A4
; 0000 00CA         case 0x0f:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0xF3
; 0000 00CB                     if(cnt == 1)
	LDI  R30,LOW(1)
	CP   R30,R4
	BRNE _0xF4
; 0000 00CC                     {
; 0000 00CD                         gogo_left();
	RCALL _gogo_left
; 0000 00CE                         cnt = 0;
	CLR  R4
; 0000 00CF                     }
; 0000 00D0                     if(cnt == 0)
_0xF4:
	TST  R4
	BRNE _0xF5
; 0000 00D1                     {
; 0000 00D2                         gogo;
	RCALL SUBOPT_0x5
; 0000 00D3                         delay_ms(250);
	RCALL SUBOPT_0x7
; 0000 00D4                         cnt += 1;
; 0000 00D5                     }
; 0000 00D6                     break;
_0xF5:
	RJMP _0xD7
; 0000 00D7         case 0x09:  back;
_0xF3:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0xFE
	RCALL SUBOPT_0x1
; 0000 00D8                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 00D9                     m_all_stop;
; 0000 00DA                     rx_bt[1] = 0;
; 0000 00DB 
; 0000 00DC                                     break;
	RJMP _0xD7
; 0000 00DD         case 0x01:  m2_ccw; m1_st;  break;
_0xFE:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x10F
	RCALL SUBOPT_0x3
	RJMP _0xD7
; 0000 00DE         case 0x08:  m1_ccw; m2_st;  break;
_0x10F:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0xD7
_0x3A4:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 00DF     }
_0xD7:
; 0000 00E0 }
	RET
; .FEND
;
;void station_4(void)
; 0000 00E3 {
_station_4:
; .FSTART _station_4
; 0000 00E4 
; 0000 00E5 
; 0000 00E6     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 00E7     {
; 0000 00E8         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x124
	RCALL SUBOPT_0x5
	RJMP _0x123
; 0000 00E9         case 0x02:  m2_ccw; m1_st;  break;
_0x124:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x12D
	RCALL SUBOPT_0x3
	RJMP _0x123
; 0000 00EA         case 0x04:  m1_ccw; m2_st;  break;
_0x12D:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A5
; 0000 00EB         case 0x0f:  if(cnt == 1)
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x13F
	LDI  R30,LOW(1)
	CP   R30,R4
	BRNE _0x140
; 0000 00EC                     {
; 0000 00ED                         gogo_right();
	RCALL _gogo_right
; 0000 00EE                         cnt = 0;
	CLR  R4
; 0000 00EF                     }
; 0000 00F0                     else if(cnt == 0)
	RJMP _0x141
_0x140:
	TST  R4
	BRNE _0x142
; 0000 00F1                     {
; 0000 00F2                         gogo;
	RCALL SUBOPT_0x5
; 0000 00F3                         delay_ms(250);
	RCALL SUBOPT_0x7
; 0000 00F4                         cnt += 1;
; 0000 00F5                     }
; 0000 00F6                     break;
_0x142:
_0x141:
	RJMP _0x123
; 0000 00F7         case 0x09:  back;
_0x13F:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x14B
	RCALL SUBOPT_0x1
; 0000 00F8                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 00F9                     m_all_stop;
; 0000 00FA                     rx_bt[1] = 0;
; 0000 00FB 
; 0000 00FC                                     break;
	RJMP _0x123
; 0000 00FD         case 0x01:  m2_ccw; m1_st;  break;
_0x14B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x15C
	RCALL SUBOPT_0x3
	RJMP _0x123
; 0000 00FE         case 0x08:  m1_ccw; m2_st;  break;
_0x15C:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x123
_0x3A5:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 00FF 
; 0000 0100 
; 0000 0101     }
_0x123:
; 0000 0102 }
	RET
; .FEND
;
;void station_5(void)
; 0000 0105 {
_station_5:
; .FSTART _station_5
; 0000 0106     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 0107     {
; 0000 0108         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x171
	RCALL SUBOPT_0x5
	RJMP _0x170
; 0000 0109         case 0x02:  m2_ccw; m1_st;  break;
_0x171:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x17A
	RCALL SUBOPT_0x3
	RJMP _0x170
; 0000 010A         case 0x04:  m1_ccw; m2_st;  break;
_0x17A:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A6
; 0000 010B         case 0x0f:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x18C
; 0000 010C                     if(cnt == 2)
	LDI  R30,LOW(2)
	CP   R30,R4
	BRNE _0x18D
; 0000 010D                     {
; 0000 010E                         gogo_left();
	RCALL _gogo_left
; 0000 010F                         cnt = 0;
	CLR  R4
; 0000 0110                     }
; 0000 0111                     else if(((cnt == 1) || (cnt == 0)) == 1)
	RJMP _0x18E
_0x18D:
	LDI  R30,LOW(1)
	CP   R30,R4
	BREQ _0x190
	TST  R4
	BREQ _0x190
	LDI  R30,0
	RJMP _0x191
_0x190:
	LDI  R30,1
_0x191:
	CPI  R30,LOW(0x1)
	BRNE _0x18F
; 0000 0112                     {
; 0000 0113                         gogo;
	RCALL SUBOPT_0x5
; 0000 0114                         delay_ms(250);
	RCALL SUBOPT_0x7
; 0000 0115                         cnt += 1;
; 0000 0116                     }
; 0000 0117                     break;
_0x18F:
_0x18E:
	RJMP _0x170
; 0000 0118         case 0x09:  back;
_0x18C:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x19A
	RCALL SUBOPT_0x1
; 0000 0119                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 011A                     m_all_stop;
; 0000 011B                     rx_bt[1] = 0;
; 0000 011C 
; 0000 011D                                     break;
	RJMP _0x170
; 0000 011E         case 0x01:  m2_ccw; m1_st;  break;
_0x19A:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1AB
	RCALL SUBOPT_0x3
	RJMP _0x170
; 0000 011F         case 0x08:  m1_ccw; m2_st;  break;
_0x1AB:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x170
_0x3A6:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 0120 
; 0000 0121 
; 0000 0122     }
_0x170:
; 0000 0123 }
	RET
; .FEND
;
;void station_6(void)
; 0000 0126 {
_station_6:
; .FSTART _station_6
; 0000 0127     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 0128     {
; 0000 0129         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x1C0
	RCALL SUBOPT_0x5
	RJMP _0x1BF
; 0000 012A         case 0x02:  m2_ccw; m1_st;  break;
_0x1C0:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1C9
	RCALL SUBOPT_0x3
	RJMP _0x1BF
; 0000 012B         case 0x04:  m1_ccw; m2_st;  break;
_0x1C9:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A7
; 0000 012C         case 0x0f:  if(cnt == 2)
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x1DB
	LDI  R30,LOW(2)
	CP   R30,R4
	BRNE _0x1DC
; 0000 012D                     {
; 0000 012E                         gogo_right();
	RCALL _gogo_right
; 0000 012F                         cnt = 0;
	CLR  R4
; 0000 0130                     }
; 0000 0131                     else if((cnt == 1 || cnt == 0) == 1)
	RJMP _0x1DD
_0x1DC:
	LDI  R30,LOW(1)
	CP   R30,R4
	BREQ _0x1DF
	TST  R4
	BREQ _0x1DF
	LDI  R30,0
	RJMP _0x1E0
_0x1DF:
	LDI  R30,1
_0x1E0:
	CPI  R30,LOW(0x1)
	BRNE _0x1DE
; 0000 0132                     {
; 0000 0133                         gogo;
	RCALL SUBOPT_0x5
; 0000 0134                         delay_ms(250);
	RCALL SUBOPT_0x7
; 0000 0135                         cnt += 1;
; 0000 0136                     }
; 0000 0137                     break;
_0x1DE:
_0x1DD:
	RJMP _0x1BF
; 0000 0138         case 0x09:  back;
_0x1DB:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x1E9
	RCALL SUBOPT_0x1
; 0000 0139                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 013A                     m_all_stop;
; 0000 013B                     rx_bt[1] = 0;
; 0000 013C 
; 0000 013D                                     break;
	RJMP _0x1BF
; 0000 013E         case 0x01:  m2_ccw; m1_st;  break;
_0x1E9:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1FA
	RCALL SUBOPT_0x3
	RJMP _0x1BF
; 0000 013F         case 0x08:  m1_ccw; m2_st;  break;
_0x1FA:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x1BF
_0x3A7:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 0140 
; 0000 0141 
; 0000 0142     }
_0x1BF:
; 0000 0143 }
	RET
; .FEND
;
;void station_7(void)
; 0000 0146 {
_station_7:
; .FSTART _station_7
; 0000 0147     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 0148     {
; 0000 0149         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x20F
	RCALL SUBOPT_0x5
	RJMP _0x20E
; 0000 014A         case 0x02:  m2_ccw; m1_st;  break;
_0x20F:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x218
	RCALL SUBOPT_0x3
	RJMP _0x20E
; 0000 014B         case 0x04:  m1_ccw; m2_st;  break;
_0x218:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A8
; 0000 014C         case 0x0f:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x22A
; 0000 014D                     if(cnt == 3)
	LDI  R30,LOW(3)
	CP   R30,R4
	BRNE _0x22B
; 0000 014E                     {
; 0000 014F                         gogo_left();
	RCALL _gogo_left
; 0000 0150                         cnt = 0;
	CLR  R4
; 0000 0151                     }
; 0000 0152                     if((cnt == 1 || cnt == 0 || cnt == 2) == 1)
_0x22B:
	LDI  R30,LOW(1)
	CP   R30,R4
	BREQ _0x22D
	TST  R4
	BREQ _0x22D
	LDI  R30,LOW(2)
	CP   R30,R4
	BREQ _0x22D
	LDI  R30,0
	RJMP _0x22E
_0x22D:
	LDI  R30,1
_0x22E:
	CPI  R30,LOW(0x1)
	BRNE _0x22C
; 0000 0153                     {
; 0000 0154                         gogo;
	RCALL SUBOPT_0x5
; 0000 0155                         delay_ms(250);
	RCALL SUBOPT_0x7
; 0000 0156                         cnt += 1;
; 0000 0157                     }
; 0000 0158                     break;
_0x22C:
	RJMP _0x20E
; 0000 0159         case 0x09:  back;
_0x22A:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x237
	RCALL SUBOPT_0x1
; 0000 015A                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 015B                     m_all_stop;
; 0000 015C                     rx_bt[1] = 0;
; 0000 015D 
; 0000 015E                                     break;
	RJMP _0x20E
; 0000 015F         case 0x01:  m2_ccw; m1_st;  break;
_0x237:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x248
	RCALL SUBOPT_0x3
	RJMP _0x20E
; 0000 0160         case 0x08:  m1_ccw; m2_st;  break;
_0x248:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x20E
_0x3A8:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 0161 
; 0000 0162 
; 0000 0163     }
_0x20E:
; 0000 0164 }
	RET
; .FEND
;
;void station_8(void)
; 0000 0167 {
_station_8:
; .FSTART _station_8
; 0000 0168     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 0169     {
; 0000 016A         case 0x00:  gogo;           break;
	SBIW R30,0
	BRNE _0x25D
	RCALL SUBOPT_0x5
	RJMP _0x25C
; 0000 016B         case 0x02:  m2_ccw; m1_st;  break;
_0x25D:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x266
	RCALL SUBOPT_0x3
	RJMP _0x25C
; 0000 016C         case 0x04:  m1_ccw; m2_st;  break;
_0x266:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x3A9
; 0000 016D         case 0x0f:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x278
; 0000 016E                     if(cnt == 3)
	LDI  R30,LOW(3)
	CP   R30,R4
	BRNE _0x279
; 0000 016F                     {
; 0000 0170                         gogo_right();
	RCALL _gogo_right
; 0000 0171                          cnt = 0;
	CLR  R4
; 0000 0172                     }
; 0000 0173                     if((cnt == 1 || cnt == 0 || cnt == 2) == 1)
_0x279:
	LDI  R30,LOW(1)
	CP   R30,R4
	BREQ _0x27B
	TST  R4
	BREQ _0x27B
	LDI  R30,LOW(2)
	CP   R30,R4
	BREQ _0x27B
	LDI  R30,0
	RJMP _0x27C
_0x27B:
	LDI  R30,1
_0x27C:
	CPI  R30,LOW(0x1)
	BRNE _0x27A
; 0000 0174                     {
; 0000 0175                         gogo;
	RCALL SUBOPT_0x5
; 0000 0176                         delay_ms(250);
	RCALL SUBOPT_0x7
; 0000 0177                         cnt += 1;
; 0000 0178                     }
; 0000 0179                     break;
_0x27A:
	RJMP _0x25C
; 0000 017A         case 0x09:  back;
_0x278:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x285
	RCALL SUBOPT_0x1
; 0000 017B                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 017C                     m_all_stop;
; 0000 017D                     rx_bt[1] = 0;
; 0000 017E 
; 0000 017F                                     break;
	RJMP _0x25C
; 0000 0180         case 0x01:  m2_ccw; m1_st;  break;
_0x285:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x296
	RCALL SUBOPT_0x3
	RJMP _0x25C
; 0000 0181         case 0x08:  m1_ccw; m2_st;  break;
_0x296:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x25C
_0x3A9:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
; 0000 0182     }
_0x25C:
; 0000 0183 }
	RET
; .FEND
;
;
;void go_home_odd(void)
; 0000 0187 {
_go_home_odd:
; .FSTART _go_home_odd
; 0000 0188     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 0189     {
; 0000 018A         case 0x00:  if(cnt_back == 0)
	SBIW R30,0
	BRNE _0x2AB
	TST  R13
	BRNE _0x2AC
; 0000 018B                     {
; 0000 018C                        while(((~PINF.1) && (~PINF.2)) == 0)
_0x2AD:
	SBIC 0x0,1
	RJMP _0x2B0
	SBIS 0x0,2
	RJMP _0x2AF
_0x2B0:
; 0000 018D                        {
; 0000 018E                          back;
	RCALL SUBOPT_0x1
; 0000 018F                        }
	RJMP _0x2AD
_0x2AF:
; 0000 0190 
; 0000 0191                        gogo;
	RCALL SUBOPT_0x5
; 0000 0192                        delay_ms(20);
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0193                        m_all_stop;
	CBI  0x18,5
	CBI  0x3,3
	CBI  0x3,4
	CBI  0x3,3
; 0000 0194                        delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0195                        gogo_left();
	RCALL _gogo_left
; 0000 0196                        cnt_back=1;
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0000 0197                        tx_send('1',1);
	LDI  R30,LOW(49)
	RJMP _0x3AA
; 0000 0198 
; 0000 0199                     }
; 0000 019A                     else if(cnt_back == 1)
_0x2AC:
	LDI  R30,LOW(1)
	CP   R30,R13
	BRNE _0x2CB
; 0000 019B                     {
; 0000 019C                      gogo;
	RCALL SUBOPT_0x5
; 0000 019D                         tx_send('2',1);
	LDI  R30,LOW(50)
_0x3AA:
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _tx_send
; 0000 019E                     }
; 0000 019F                     break;
_0x2CB:
	RJMP _0x2AA
; 0000 01A0     /*    case 0x0f:  gogo;
; 0000 01A1                        delay_ms(20);
; 0000 01A2                        m_all_stop;
; 0000 01A3                        delay_ms(1000);
; 0000 01A4                        gogo_left();
; 0000 01A5                        cnt_back=1;
; 0000 01A6                        tx_send('1',1);
; 0000 01A7 
; 0000 01A8                           break;  */
; 0000 01A9         case 0x02:  m2_ccw; m1_st;    tx_send('3',1);  break;
_0x2AB:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2D4
	RCALL SUBOPT_0x3
	LDI  R30,LOW(51)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _tx_send
	RJMP _0x2AA
; 0000 01AA         case 0x04:  m1_ccw; m2_st;   tx_send('4',1);   break;
_0x2D4:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x2DD
	RCALL SUBOPT_0x4
	LDI  R30,LOW(52)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _tx_send
	RJMP _0x2AA
; 0000 01AB 
; 0000 01AC         case 0x09:
_0x2DD:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x2E6
; 0000 01AD                     back;
	RCALL SUBOPT_0x1
; 0000 01AE                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 01AF                     m_all_stop;
; 0000 01B0                     rx_bt[1] = 0;
; 0000 01B1                     cnt = 0;
	CLR  R4
; 0000 01B2                     left=0;
	CLR  R7
; 0000 01B3                     cnt_back = 0;
	CLR  R13
; 0000 01B4                        tx_send('5',1);
	LDI  R30,LOW(53)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _tx_send
; 0000 01B5 
; 0000 01B6                     break;
	RJMP _0x2AA
; 0000 01B7         case 0x01:  m2_ccw; m1_st; delay_ms(20);  break;
_0x2E6:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x2F7
	RCALL SUBOPT_0x3
	RJMP _0x3AB
; 0000 01B8         case 0x08:  m1_ccw; m2_st; delay_ms(20); break;
_0x2F7:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x2AA
	RCALL SUBOPT_0x4
_0x3AB:
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01B9     }
_0x2AA:
; 0000 01BA }
	RET
; .FEND
;
;void go_home_even(void)
; 0000 01BD {
_go_home_even:
; .FSTART _go_home_even
; 0000 01BE     switch(sensor)
	MOV  R30,R10
	LDI  R31,0
; 0000 01BF     {
; 0000 01C0         case 0x00:  gogo;          break;
	SBIW R30,0
	BRNE _0x30C
	RCALL SUBOPT_0x5
	RJMP _0x30B
; 0000 01C1         case 0x02:  m2_ccw; m1_st;  break;
_0x30C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x315
	RCALL SUBOPT_0x3
	RJMP _0x30B
; 0000 01C2         case 0x04:  m1_ccw; m2_st;  break;
_0x315:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x31E
	RCALL SUBOPT_0x4
	RJMP _0x30B
; 0000 01C3         case 0x0f:
_0x31E:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x327
; 0000 01C4                     if(cnt == 0)
	TST  R4
	BRNE _0x328
; 0000 01C5                     {
; 0000 01C6                         gogo;
	RCALL SUBOPT_0x5
; 0000 01C7                         delay_ms(30);
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01C8                         gogo_right();
	RCALL _gogo_right
; 0000 01C9                         cnt_back++;
	INC  R13
; 0000 01CA                         cnt++;
	INC  R4
; 0000 01CB                     }
; 0000 01CC                     break;
_0x328:
	RJMP _0x30B
; 0000 01CD         case 0x09:  if(cnt_back == 0)
_0x327:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x331
	TST  R13
	BRNE _0x332
; 0000 01CE                     {
; 0000 01CF                        while(sensor != 0x0f)
_0x333:
	LDI  R30,LOW(15)
	CP   R30,R10
	BREQ _0x335
; 0000 01D0                        {
; 0000 01D1                          back;
	RCALL SUBOPT_0x1
; 0000 01D2                          sensor = (~(PINF & 0x0f));
	RCALL SUBOPT_0x2
; 0000 01D3                          sensor &= 0x0f;
; 0000 01D4                        }
	RJMP _0x333
_0x335:
; 0000 01D5                     }
; 0000 01D6                     else if(cnt_back == 1)
	RJMP _0x33E
_0x332:
	LDI  R30,LOW(1)
	CP   R30,R13
	BRNE _0x33F
; 0000 01D7                     {
; 0000 01D8                     back;
	RCALL SUBOPT_0x1
; 0000 01D9                     delay_ms(20);
	RCALL SUBOPT_0x6
; 0000 01DA                     m_all_stop;
; 0000 01DB                     rx_bt[1] = 0;
; 0000 01DC                     cnt = 0;
	CLR  R4
; 0000 01DD                     right=0;
	CLR  R6
; 0000 01DE                     cnt_back = 0;
	CLR  R13
; 0000 01DF                     }
; 0000 01E0                     break;
_0x33F:
_0x33E:
	RJMP _0x30B
; 0000 01E1         case 0x01:  m2_ccw; m1_st; delay_ms(20); break;
_0x331:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x350
	RCALL SUBOPT_0x3
	RJMP _0x3AC
; 0000 01E2         case 0x08:  m1_ccw; m2_st; delay_ms(20); break;
_0x350:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x30B
	RCALL SUBOPT_0x4
_0x3AC:
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01E3     }
_0x30B:
; 0000 01E4 }
	RET
; .FEND
;
;
;void main(void)
; 0000 01E8 {
_main:
; .FSTART _main
; 0000 01E9     DDRF = 0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 01EA     DDRB = 0xff;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 01EB     DDRE = 0xff;
	OUT  0x2,R30
; 0000 01EC 
; 0000 01ED 
; 0000 01EE 
; 0000 01EF 
; 0000 01F0     #asm("sei");
	SEI
; 0000 01F1 
; 0000 01F2 
; 0000 01F3 
; 0000 01F4     uart0_init();
	RCALL _uart0_init
; 0000 01F5     uart1_init();
	RCALL _uart1_init
; 0000 01F6 
; 0000 01F7     cnt = 0;
	CLR  R4
; 0000 01F8 
; 0000 01F9 
; 0000 01FA while (1)
_0x362:
; 0000 01FB       {
; 0000 01FC 
; 0000 01FD 
; 0000 01FE          sensor = (~(PINF & 0x0f));
	RCALL SUBOPT_0x2
; 0000 01FF          sensor &= 0x0f;
; 0000 0200 
; 0000 0201          switch(rx_bt[1])
	__GETB1MN _rx_bt,1
	LDI  R31,0
; 0000 0202          {
; 0000 0203             case 0x00:  m1_st; m2_st;     break;
	SBIW R30,0
	BRNE _0x368
	CBI  0x18,5
	CBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
	RJMP _0x367
; 0000 0204             case 0x01:  station_1();      break;
_0x368:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x371
	RCALL _station_1
	RJMP _0x367
; 0000 0205             case 0x02:  station_2();      break;
_0x371:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x372
	RCALL _station_2
	RJMP _0x367
; 0000 0206             case 0x03:  station_3();      break;
_0x372:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x373
	RCALL _station_3
	RJMP _0x367
; 0000 0207             case 0x04:  station_4();      break;
_0x373:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x374
	RCALL _station_4
	RJMP _0x367
; 0000 0208             case 0x05:  station_5();      break;
_0x374:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x375
	RCALL _station_5
	RJMP _0x367
; 0000 0209             case 0x06:  station_6();      break;
_0x375:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x376
	RCALL _station_6
	RJMP _0x367
; 0000 020A             case 0x07:  station_7();      break;
_0x376:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x377
	RCALL _station_7
	RJMP _0x367
; 0000 020B             case 0x08:  station_8();      break;
_0x377:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x378
	RCALL _station_8
	RJMP _0x367
; 0000 020C             case 0x09:  m2_ccw; m1_st;    break;
_0x378:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x379
	RCALL SUBOPT_0x3
	RJMP _0x367
; 0000 020D             case 0x0a:  m1_ccw; m2_st;    break;
_0x379:
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x382
	RCALL SUBOPT_0x4
	RJMP _0x367
; 0000 020E             case 0x0b:  gogo;             break;  //0b
_0x382:
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x38B
	RCALL SUBOPT_0x5
	RJMP _0x367
; 0000 020F             case 0x0c:  back;             break;
_0x38B:
	CPI  R30,LOW(0xC)
	LDI  R26,HIGH(0xC)
	CPC  R31,R26
	BRNE _0x394
	RCALL SUBOPT_0x1
	RJMP _0x367
; 0000 0210             case 0x0d: if(left==1)
_0x394:
	CPI  R30,LOW(0xD)
	LDI  R26,HIGH(0xD)
	CPC  R31,R26
	BRNE _0x367
	LDI  R30,LOW(1)
	CP   R30,R7
	BRNE _0x39E
; 0000 0211                           {
; 0000 0212                            go_home_odd();
	RCALL _go_home_odd
; 0000 0213                           }
; 0000 0214 
; 0000 0215                        else if(right==1)
	RJMP _0x39F
_0x39E:
	LDI  R30,LOW(1)
	CP   R30,R6
	BRNE _0x3A0
; 0000 0216                           {
; 0000 0217 
; 0000 0218                             go_home_even();
	RCALL _go_home_even
; 0000 0219                           }
; 0000 021A 
; 0000 021B                        break;
_0x3A0:
_0x39F:
; 0000 021C 
; 0000 021D 
; 0000 021E          }
_0x367:
; 0000 021F 
; 0000 0220       }
	RJMP _0x362
; 0000 0221 }
_0x3A1:
	RJMP _0x3A1
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_rx_bt:
	.BYTE 0x14

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x0:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x1:
	SBI  0x18,5
	CBI  0x18,6
	SBI  0x3,4
	CBI  0x3,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x2:
	IN   R30,0x0
	ANDI R30,LOW(0xF)
	COM  R30
	MOV  R10,R30
	LDI  R30,LOW(15)
	AND  R10,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES, CODE SIZE REDUCTION:61 WORDS
SUBOPT_0x3:
	CBI  0x3,4
	SBI  0x3,3
	CBI  0x18,5
	CBI  0x18,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x4:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	CBI  0x3,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:52 WORDS
SUBOPT_0x5:
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x3,4
	SBI  0x3,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:79 WORDS
SUBOPT_0x6:
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x18,5
	CBI  0x3,3
	CBI  0x3,4
	CBI  0x3,3
	LDI  R30,LOW(0)
	__PUTB1MN _rx_bt,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x7:
	LDI  R26,LOW(250)
	LDI  R27,0
	RCALL _delay_ms
	INC  R4
	RET

;RUNTIME LIBRARY

	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
