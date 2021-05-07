#line 1 "C:/Users/Muand/OneDrive/Documentos/mikro c/led_chaser.c"



int count = 0;

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

 if (Button(&PORTD,7,2,0)){
 if (Button(&PORTD,7,2,0)){
 count++;
 Delay_us(50);
 }

 }

 switch(count){
 case 1:
 delayChanger( 800 );
 break;
 case 2 :
 delayChanger( 300 );
 break;
 case 3 :
 delayChanger( 100 );
 break;
 default :
 count = 0;
 }



}while(1);


}
