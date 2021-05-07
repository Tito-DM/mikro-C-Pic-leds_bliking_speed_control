#line 1 "C:/Users/Muand/OneDrive/Documentos/mikro c/led_chaser.c"



int count = 1;

void delayChanger(unsigned delay ){
 VDelay_ms(delay);
 PORTB = PORTB << 1;
 if(PORTB >= 0b10000000)
 {
 VDelay_ms(delay);
 PORTB =1 ;
 }
}

void main()
{
 CMCON = 0X07;
 ADCON1 = 0X06;
 TRISB = 0X00;
 TRISD.F7 = 1 ;
 PORTB = 1;


do {

 if (PORTD.F7 == 0){
 Delay_ms(1);
 count++;
 }
 switch(count){
 case 1:
 delayChanger( 600 );
 break;
 case 2 :
 delayChanger( 300 );
 break;
 case 3 :
 delayChanger( 100 );
 break;
 default :
 count = 1;
 }



}while(1);


}
