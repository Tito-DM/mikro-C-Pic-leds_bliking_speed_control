
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
;led_chaser.c,27 :: 		if (Button(&PORTD,7,2,0)){
	MOVLW      PORTD+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      2
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;led_chaser.c,28 :: 		if (Button(&PORTD,7,2,0)){
	MOVLW      PORTD+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      2
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;led_chaser.c,29 :: 		count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;led_chaser.c,30 :: 		Delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
;led_chaser.c,31 :: 		}
L_main5:
;led_chaser.c,33 :: 		}
L_main4:
;led_chaser.c,35 :: 		switch(count){
	GOTO       L_main7
;led_chaser.c,36 :: 		case 1:
L_main9:
;led_chaser.c,37 :: 		delayChanger(SLOW);
	MOVLW      32
	MOVWF      FARG_delayChanger_delay+0
	MOVLW      3
	MOVWF      FARG_delayChanger_delay+1
	CALL       _delayChanger+0
;led_chaser.c,38 :: 		break;
	GOTO       L_main8
;led_chaser.c,39 :: 		case 2 :
L_main10:
;led_chaser.c,40 :: 		delayChanger(MEDIUN);
	MOVLW      44
	MOVWF      FARG_delayChanger_delay+0
	MOVLW      1
	MOVWF      FARG_delayChanger_delay+1
	CALL       _delayChanger+0
;led_chaser.c,41 :: 		break;
	GOTO       L_main8
;led_chaser.c,42 :: 		case 3 :
L_main11:
;led_chaser.c,43 :: 		delayChanger(FAST);
	MOVLW      100
	MOVWF      FARG_delayChanger_delay+0
	MOVLW      0
	MOVWF      FARG_delayChanger_delay+1
	CALL       _delayChanger+0
;led_chaser.c,44 :: 		break;
	GOTO       L_main8
;led_chaser.c,45 :: 		default :
L_main12:
;led_chaser.c,46 :: 		count = 0;
	CLRF       _count+0
	CLRF       _count+1
;led_chaser.c,47 :: 		}
	GOTO       L_main8
L_main7:
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      1
	XORWF      _count+0, 0
L__main15:
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      2
	XORWF      _count+0, 0
L__main16:
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      3
	XORWF      _count+0, 0
L__main17:
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	GOTO       L_main12
L_main8:
;led_chaser.c,51 :: 		}while(1);
	GOTO       L_main1
;led_chaser.c,54 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
