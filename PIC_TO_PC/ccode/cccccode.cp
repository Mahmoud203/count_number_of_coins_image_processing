#line 1 "C:/Users/Mahmoud/Desktop/DSL/dsi course project/final my course project/ccode/cccccode.c"
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
}
void StartSignal()
{
 TRISD.B0 = 0;
 PORTD.B0 = 0;
 delay_ms(18);
 PORTD.B0 = 1;
 delay_us(30);
 TRISD.B0 = 1;
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
 while(!PORTD.B0);
 delay_us(30);
 if(PORTD.B0 == 0)
 i&= ~(1<<(7 - j));
 else {i|= (1 << (7 - j));
 while(PORTD.B0);}
 }
 return i;
 }

void main ()
{
TRISA = 0xff;
TRISC = 0b10000000;
ADCON1 = 0x80;
Uart1_Init (9600);




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

 RH = RH_byte1;

 floatToStr (RH, txt3);





 strcat(txt3, " %");
 Uart1_write_text (txt3);
 newline();








Temp_in = adc_read(0);
Dis_temp = (Temp_in * 500.0)/ 1023.0;
floatToStr (Dis_temp, txt);

strcat(txt, " C");
Uart1_write_text (txt);

newline();


 PORTB.F1=0;
 TRISB.F1=1;
 PORTD.F1=0;
 TRISD.F1=0;
{

if( PORTB.F1==1)
{
 PORTD.F1=1;
 Uart1_write_Text("Motion Detected" );

 newline();

}
else
{
 PORTD.F1=0;
 Uart1_write_Text("Motion not Detected" );

newline();

}
}
}
}
}
}
}
