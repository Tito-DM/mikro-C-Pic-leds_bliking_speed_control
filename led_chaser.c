#define FAST 100
#define SLOW 800
#define MEDIUN 300
int count = 0;

void delayChanger(unsigned delay ){
   VDelay_ms(delay); // 300 mili sec delay
   PORTB = PORTB << 1; //Shifting right by one bit
   if(PORTB >= 0b10000000)
   {
    VDelay_ms(delay);
    PORTB =1 ;
   }
}

void main()
{
  CMCON = 0X07; // to turn off comparators
  ADCON1 = 0X06; // turn off adc
  TRISB = 0X00; // set portb pins as output
  TRISD.F7 = 1 ; // set port d bit 7 to input
  PORTB = 1; // set RB= to high 00000001
//start infinit loop

do {
// check if speed controller button have been pressed
   if (Button(&PORTD,7,2,0)){
     if (Button(&PORTD,7,2,0)){
         count++;
         Delay_us(50);
     }

   }

   switch(count){
     case 1:
         delayChanger(SLOW);
         break;
     case 2 :
         delayChanger(MEDIUN);
         break;
     case 3 :
         delayChanger(FAST);
         break;
     default :
      count = 0;
   }



}while(1);


}