  char txt [20];
char txt2 [20];
char txt3 [20];
float Temp_in , Dis_temp;
unsigned char Check, T_byte1, T_byte2,
 RH_byte1, RH_byte2, Ch ;
 unsigned Temp, RH, Sum ;

void newline ( )
{
Uart1_Write (0x0D);
Uart1_write (0x0A);
} // end of newline function
void StartSignal()
{
 TRISD.B0 = 0; //Configure RD0 as output
 PORTD.B0 = 0; //RD0 sends 0 to the sensor
 delay_ms(18);
 PORTD.B0 = 1; //RD0 sends 1 to the sensor
 delay_us(30);
 TRISD.B0 = 1; //Configure RD0 as input
 }

 void CheckResponse()
 {
 Check = 0;
 delay_us(40);
 if (PORTD.B0 == 0)
 {
 delay_us(80);
 if (PORTD.B0 == 1) Check = 1; delay_us(40);
 }
 }
 char ReadData()
 {
 char i, j;
 for(j = 0; j < 8; j++)
 {
 while(!PORTD.B0); //Wait until PORTD.F0 goes HIGH
 delay_us(30);
 if(PORTD.B0 == 0)
 i&= ~(1<<(7 - j)); //Clear bit (7-b)
 else {i|= (1 << (7 - j)); //Set bit (7-b)
 while(PORTD.B0);} //Wait until PORTD.F0 goes LOW
 }
 return i;
 }

void main ()
{
TRISA = 0xff;
TRISC = 0b10000000;
ADCON1 = 0x80;
Uart1_Init (9600);
//newline();
//newline();
//newline();
//newline();
for ( ; ; )
{
 TRISD.F1 = 0;
 while(1)
 {
 Delay_ms(300);
 StartSignal();
 CheckResponse();
 if(Check == 1)
 {
 RH_byte1 = ReadData();
 RH_byte2 = ReadData();
 T_byte1 = ReadData();
 T_byte2 = ReadData();
 Sum = ReadData();
 if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF))
 {
 //Temp = T_byte1;
 RH = RH_byte1;
 //floatToStr (Temp, txt2);
 floatToStr (RH, txt3);

 //Uart1_write_Text("Temp: C");
 //Uart1_write_text (txt2);
 //newline();
 //Uart1_write_Text("Humidity: %");
 strcat(txt3, " %");
 Uart1_write_text (txt3);
 newline();
 //newline();



 //Uart1_Write(48 + ((Temp / 10) % 10));
 //Uart1_Write(48 + (Temp % 10));
 //Uart1_Write(48 + ((RH / 10) % 10));
 //Uart1_Write(48 + (RH % 10));
Temp_in = adc_read(0);
Dis_temp = (Temp_in * 500.0)/ 1023.0;
floatToStr (Dis_temp, txt);
//Uart1_write_Text ("Temp = ");
strcat(txt, " C");
Uart1_write_text (txt);
//delay_ms(200);
newline();
//newline();

 PORTB.F1=0;  // initially declare it as zero
 TRISB.F1=1; // PIN NUMBER 1 IS DECLARED AS A INPUT
 PORTD.F1=0;  // initially declare it as zero
 TRISD.F1=0; // PIN NUMBER 1 IS DECLARED AS A OUTPUT
{ // Endless loop

if( PORTB.F1==1)
{
 PORTD.F1=1;
 Uart1_write_Text("Motion Detected" );
 //delay_ms(200);
 newline();
 //newline();
}
else
{
 PORTD.F1=0;
 Uart1_write_Text("Motion not Detected" );
 //delay_ms(200);
newline();
//newline();
}
}
}
}
}
}
}