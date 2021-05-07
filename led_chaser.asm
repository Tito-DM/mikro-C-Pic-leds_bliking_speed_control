
_delayChanger:

;led_chaser.c,6 :: 		void delayChanger(unsigned delay ){
;led_chaser.c,7 :: 		VDelay_ms(delay); // 300 mili sec delay
	MOVF       FARG_delayChanger_delay+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVF       FARG_delayChanger_delay+1, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;led_chaser.c,8 :: 		PORTB = PORTB << 1; //Shifting right by one bit
	MOVF       PORTB+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;led_chaser.c,9 :: 		if(PORTB >= 0b10000000)
	MOVLW      128
	SUBWF      PORTB+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_delayChanger0
;led_chaser.c,11 :: 		VDelay_ms(delay);
	MOVF       FARG_delayChanger_delay+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVF       FARG_delayChanger_delay+1, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;led_chaser.c,12 :: 		PORTB =1 ;
	MOVLW      1
	MOVWF      PORTB+0
;led_chaser.c,13 :: 		}
L_delayChanger0:
;led_chaser.c,14 :: 		}
L_end_delayChanger:
	RETURN
; end of _delayChanger

_main:

;led_chaser.c,16 :: 		void main()
;led_chaser.c,18 :: 		CMCON = 0X07; // to turn off comparators
	MOVLW      7
	MOVWF      CMCON+0
;led_chaser.c,19 :: 		ADCON1 = 0X06; // turn off adc
	MOVLW      6
	MOVWF      ADCON1+0
;led_chaser.c,20 :: 		TRISB = 0X00; // set portb pins as output
	CLRF       TRISB+0
;led_chaser.c,21 :: 		TRISD.F7 = 1 ; // set port d bit 7 to input
	BSF        TRISD+0, 7
;led_chaser.c,22 :: 		PORTB = 1; // set RB= to high 00000001
	MOVLW      1
	MOVWF      PORTB+0
;led_chaser.c,25 :: 		do {
L_main1:
;led_chaser.c,27 :: 		if (PORTD.F7 == 0){
	BTFSC      PORTD+0, 7
	GOTO       L_main4
;led_chaser.c,28 :: 		Delay_ms(1);  // delay for bouncing
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
	NOP
;led_chaser.c,29 :: 		count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;led_chaser.c,30 :: 		}
L_main4:
;led_chaser.c,31 :: 		switch(count){
	GOTO       L_main6
;led_chaser.c,32 :: 		case 1:
L_main8:
;led_chaser.c,33 :: 		delayChanger(SLOW);
	MOVLW      88
	MOVWF      FARG_delayChanger_delay+0
	MOVLW      2
	MOVWF      FARG_delayChanger_delay+1
	CALL       _delayChanger+0
;led_chaser.c,34 :: 		break;
	GOTO       L_main7
;led_chaser.c,35 :: 		case 2 :
L_main9:
;led_chaser.c,36 :: 		delayChanger(MEDIUN);
	MOVLW      44
	MOVWF      FARG_delayChanger_delay+0
	MOVLW      1
	MOVWF      FARG_delayChanger_delay+1
	CALL       _delayChanger+0
;led_chaser.c,37 :: 		break;
	GOTO       L_main7
;led_chaser.c,38 :: 		case 3 :
L_main10:
;led_chaser.c,39 :: 		delayChanger(FAST);
	MOVLW      100
	MOVWF      FARG_delayChanger_delay+0
	MOVLW      0
	MOVWF      FARG_delayChanger_delay+1
	CALL       _delayChanger+0
;led_chaser.c,40 :: 		break;
	GOTO       L_main7
;led_chaser.c,41 :: 		default :
L_main11:
;led_chaser.c,42 :: 		count = 1;
	MOVLW      1
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
;led_chaser.c,43 :: 		}
	GOTO       L_main7
L_main6:
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      1
	XORWF      _count+0, 0
L__main14:
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      2
	XORWF      _count+0, 0
L__main15:
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      3
	XORWF      _count+0, 0
L__main16:
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	GOTO       L_main11
L_main7:
;led_chaser.c,47 :: 		}while(1);
	GOTO       L_main1
;led_chaser.c,50 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
