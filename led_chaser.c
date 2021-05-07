#define FAST 100
#define SLOW 600
#define MEDIUN 300
int count = 1;

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
   if (PORTD.F7 == 0){
     Delay_ms(1);  // delay for bouncing
     count++;
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
      count = 1;
   }



}while(1);


}