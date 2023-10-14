
_newline:

;cccccode.c,9 :: 		void newline ( )
;cccccode.c,11 :: 		Uart1_Write (0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;cccccode.c,12 :: 		Uart1_write (0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;cccccode.c,13 :: 		} // end of newline function
L_end_newline:
	RETURN      0
; end of _newline

_StartSignal:

;cccccode.c,14 :: 		void StartSignal()
;cccccode.c,16 :: 		TRISD.B0 = 0; //Configure RD0 as output
	BCF         TRISD+0, 0 
;cccccode.c,17 :: 		PORTD.B0 = 0; //RD0 sends 0 to the sensor
	BCF         PORTD+0, 0 
;cccccode.c,18 :: 		delay_ms(18);
	MOVLW       47
	MOVWF       R12, 0
	MOVLW       191
	MOVWF       R13, 0
L_StartSignal0:
	DECFSZ      R13, 1, 1
	BRA         L_StartSignal0
	DECFSZ      R12, 1, 1
	BRA         L_StartSignal0
	NOP
	NOP
;cccccode.c,19 :: 		PORTD.B0 = 1; //RD0 sends 1 to the sensor
	BSF         PORTD+0, 0 
;cccccode.c,20 :: 		delay_us(30);
	MOVLW       19
	MOVWF       R13, 0
L_StartSignal1:
	DECFSZ      R13, 1, 1
	BRA         L_StartSignal1
	NOP
	NOP
;cccccode.c,21 :: 		TRISD.B0 = 1; //Configure RD0 as input
	BSF         TRISD+0, 0 
;cccccode.c,22 :: 		}
L_end_StartSignal:
	RETURN      0
; end of _StartSignal

_CheckResponse:

;cccccode.c,24 :: 		void CheckResponse()
;cccccode.c,26 :: 		Check = 0;
	CLRF        _Check+0 
;cccccode.c,27 :: 		delay_us(40);
	MOVLW       26
	MOVWF       R13, 0
L_CheckResponse2:
	DECFSZ      R13, 1, 1
	BRA         L_CheckResponse2
	NOP
;cccccode.c,28 :: 		if (PORTD.B0 == 0)
	BTFSC       PORTD+0, 0 
	GOTO        L_CheckResponse3
;cccccode.c,30 :: 		delay_us(80);
	MOVLW       53
	MOVWF       R13, 0
L_CheckResponse4:
	DECFSZ      R13, 1, 1
	BRA         L_CheckResponse4
;cccccode.c,31 :: 		if (PORTD.B0 == 1) Check = 1; delay_us(40);
	BTFSS       PORTD+0, 0 
	GOTO        L_CheckResponse5
	MOVLW       1
	MOVWF       _Check+0 
L_CheckResponse5:
	MOVLW       26
	MOVWF       R13, 0
L_CheckResponse6:
	DECFSZ      R13, 1, 1
	BRA         L_CheckResponse6
	NOP
;cccccode.c,32 :: 		}
L_CheckResponse3:
;cccccode.c,33 :: 		}
L_end_CheckResponse:
	RETURN      0
; end of _CheckResponse

_ReadData:

;cccccode.c,34 :: 		char ReadData()
;cccccode.c,37 :: 		for(j = 0; j < 8; j++)
	CLRF        R3 
L_ReadData7:
	MOVLW       8
	SUBWF       R3, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ReadData8
;cccccode.c,39 :: 		while(!PORTD.B0); //Wait until PORTD.F0 goes HIGH
L_ReadData10:
	BTFSC       PORTD+0, 0 
	GOTO        L_ReadData11
	GOTO        L_ReadData10
L_ReadData11:
;cccccode.c,40 :: 		delay_us(30);
	MOVLW       19
	MOVWF       R13, 0
L_ReadData12:
	DECFSZ      R13, 1, 1
	BRA         L_ReadData12
	NOP
	NOP
;cccccode.c,41 :: 		if(PORTD.B0 == 0)
	BTFSC       PORTD+0, 0 
	GOTO        L_ReadData13
;cccccode.c,42 :: 		i&= ~(1<<(7 - j)); //Clear bit (7-b)
	MOVF        R3, 0 
	SUBLW       7
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__ReadData31:
	BZ          L__ReadData32
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__ReadData31
L__ReadData32:
	COMF        R0, 1 
	MOVF        R0, 0 
	ANDWF       R2, 1 
	GOTO        L_ReadData14
L_ReadData13:
;cccccode.c,43 :: 		else {i|= (1 << (7 - j)); //Set bit (7-b)
	MOVF        R3, 0 
	SUBLW       7
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__ReadData33:
	BZ          L__ReadData34
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__ReadData33
L__ReadData34:
	MOVF        R0, 0 
	IORWF       R2, 1 
;cccccode.c,44 :: 		while(PORTD.B0);} //Wait until PORTD.F0 goes LOW
L_ReadData15:
	BTFSS       PORTD+0, 0 
	GOTO        L_ReadData16
	GOTO        L_ReadData15
L_ReadData16:
L_ReadData14:
;cccccode.c,37 :: 		for(j = 0; j < 8; j++)
	INCF        R3, 1 
;cccccode.c,45 :: 		}
	GOTO        L_ReadData7
L_ReadData8:
;cccccode.c,46 :: 		return i;
	MOVF        R2, 0 
	MOVWF       R0 
;cccccode.c,47 :: 		}
L_end_ReadData:
	RETURN      0
; end of _ReadData

_main:

;cccccode.c,49 :: 		void main ()
;cccccode.c,51 :: 		TRISA = 0xff;
	MOVLW       255
	MOVWF       TRISA+0 
;cccccode.c,52 :: 		TRISC = 0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;cccccode.c,53 :: 		ADCON1 = 0x80;
	MOVLW       128
	MOVWF       ADCON1+0 
;cccccode.c,54 :: 		Uart1_Init (9600);
	MOVLW       51
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;cccccode.c,61 :: 		TRISD.F1 = 0;
	BCF         TRISD+0, 1 
;cccccode.c,62 :: 		while(1)
L_main20:
;cccccode.c,64 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
	NOP
	NOP
;cccccode.c,65 :: 		StartSignal();
	CALL        _StartSignal+0, 0
;cccccode.c,66 :: 		CheckResponse();
	CALL        _CheckResponse+0, 0
;cccccode.c,67 :: 		if(Check == 1)
	MOVF        _Check+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
;cccccode.c,69 :: 		RH_byte1 = ReadData();
	CALL        _ReadData+0, 0
	MOVF        R0, 0 
	MOVWF       _RH_byte1+0 
;cccccode.c,70 :: 		RH_byte2 = ReadData();
	CALL        _ReadData+0, 0
	MOVF        R0, 0 
	MOVWF       _RH_byte2+0 
;cccccode.c,71 :: 		T_byte1 = ReadData();
	CALL        _ReadData+0, 0
	MOVF        R0, 0 
	MOVWF       _T_byte1+0 
;cccccode.c,72 :: 		T_byte2 = ReadData();
	CALL        _ReadData+0, 0
	MOVF        R0, 0 
	MOVWF       _T_byte2+0 
;cccccode.c,73 :: 		Sum = ReadData();
	CALL        _ReadData+0, 0
	MOVF        R0, 0 
	MOVWF       _Sum+0 
	MOVLW       0
	MOVWF       _Sum+1 
;cccccode.c,74 :: 		if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF))
	MOVF        _RH_byte2+0, 0 
	ADDWF       _RH_byte1+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        _T_byte1+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        _T_byte2+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVF        _Sum+1, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVF        R2, 0 
	XORWF       _Sum+0, 0 
L__main36:
	BTFSS       STATUS+0, 2 
	GOTO        L_main24
;cccccode.c,77 :: 		RH = RH_byte1;
	MOVF        _RH_byte1+0, 0 
	MOVWF       _RH+0 
	MOVLW       0
	MOVWF       _RH+1 
;cccccode.c,79 :: 		floatToStr (RH, txt3);
	MOVF        _RH+0, 0 
	MOVWF       R0 
	MOVF        _RH+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt3+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;cccccode.c,85 :: 		strcat(txt3, " %");
	MOVLW       _txt3+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_cccccode+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_cccccode+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;cccccode.c,86 :: 		Uart1_write_text (txt3);
	MOVLW       _txt3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;cccccode.c,87 :: 		newline();
	CALL        _newline+0, 0
;cccccode.c,96 :: 		Temp_in = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _Temp_in+0 
	MOVF        R1, 0 
	MOVWF       _Temp_in+1 
	MOVF        R2, 0 
	MOVWF       _Temp_in+2 
	MOVF        R3, 0 
	MOVWF       _Temp_in+3 
;cccccode.c,97 :: 		Dis_temp = (Temp_in * 500.0)/ 1023.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _Dis_temp+0 
	MOVF        R1, 0 
	MOVWF       _Dis_temp+1 
	MOVF        R2, 0 
	MOVWF       _Dis_temp+2 
	MOVF        R3, 0 
	MOVWF       _Dis_temp+3 
;cccccode.c,98 :: 		floatToStr (Dis_temp, txt);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;cccccode.c,100 :: 		strcat(txt, " C");
	MOVLW       _txt+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_cccccode+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_cccccode+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;cccccode.c,101 :: 		Uart1_write_text (txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;cccccode.c,103 :: 		newline();
	CALL        _newline+0, 0
;cccccode.c,106 :: 		PORTB.F1=0;  // initially declare it as zero
	BCF         PORTB+0, 1 
;cccccode.c,107 :: 		TRISB.F1=1; // PIN NUMBER 1 IS DECLARED AS A INPUT
	BSF         TRISB+0, 1 
;cccccode.c,108 :: 		PORTD.F1=0;  // initially declare it as zero
	BCF         PORTD+0, 1 
;cccccode.c,109 :: 		TRISD.F1=0; // PIN NUMBER 1 IS DECLARED AS A OUTPUT
	BCF         TRISD+0, 1 
;cccccode.c,112 :: 		if( PORTB.F1==1)
	BTFSS       PORTB+0, 1 
	GOTO        L_main25
;cccccode.c,114 :: 		PORTD.F1=1;
	BSF         PORTD+0, 1 
;cccccode.c,115 :: 		Uart1_write_Text("Motion Detected" );
	MOVLW       ?lstr3_cccccode+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_cccccode+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;cccccode.c,117 :: 		newline();
	CALL        _newline+0, 0
;cccccode.c,119 :: 		}
	GOTO        L_main26
L_main25:
;cccccode.c,122 :: 		PORTD.F1=0;
	BCF         PORTD+0, 1 
;cccccode.c,123 :: 		Uart1_write_Text("Motion not Detected" );
	MOVLW       ?lstr4_cccccode+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_cccccode+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;cccccode.c,125 :: 		newline();
	CALL        _newline+0, 0
;cccccode.c,127 :: 		}
L_main26:
;cccccode.c,129 :: 		}
L_main24:
;cccccode.c,130 :: 		}
L_main23:
;cccccode.c,131 :: 		}
	GOTO        L_main20
;cccccode.c,133 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
