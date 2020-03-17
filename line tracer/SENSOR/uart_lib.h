

#ifndef _uart_
#define _uart_

#define UART_CH0 0
#define UART_CH1 1
#define STX  'z'
#define ETX  '\r'


#define bit_set(ADDRESS, BIT) (ADDRESS |= (1<<BIT)) // bit hi 

#define bit_clr(ADDRESS, BIT) (ADDRESS &= ~(1<<BIT)) // bit low

#define bit_chk(ADDRESS, BIT) (ADDRESS & (1<<BIT))  // bit chak

#define tbi(PORT, BIT) (PORT ^= (1<<BIT))  //bit 토글

bit rx0_end_flag = 0; // ch 0
bit rx1_end_flag = 0; // ch 1
char rx0_cnt = 0;
char rx1_cnt = 0;
unsigned char rx0_buf[20];
unsigned char rx1_buf[20];


void uart0_init(void)
{
  UCSR0A = 0x00;  // flag  clr, 멀티프로세싱 모드
  UCSR0B = 0x98; //rx,tx en, rx int on
  UCSR0C = 0x06; //n-p,1-stop
  UBRR0H = 0x00;
  UBRR0L = 8; //8mhz, 9600, 103 - 16mhz, 47 = 7.2738mhz, 8 = 115200mhz 
}  

 
void uart1_init(void)
{
  UCSR1A = 0x00;  // flag  clr, 멀티프로세싱 모드
  UCSR1B = 0x98; //rx,tx en, rx int on
  UCSR1C = 0x06; //n-p,1-stop
  UBRR1H = 0x00;
  UBRR1L = 8; //8mhz, 9600, 103 - 16mhz, 47 = 7.2738mhz, 8 = 115200mhz
}  

// tx redy chk
char tx_chk(char ch)
{                
  if(ch == UART_CH0) //1
   {     
    // uart 0
    if(bit_chk(UCSR0A, 5)) return 1; // UCSR0A, UDRE0 bit chk ==>> 송신준비됨 OK
    else return 0; // NO REDY
   }
  else
   {         
    // uart 1
    if(bit_chk(UCSR1A, 5)) return 1; // UCSR1A, UDRE1 bit chk ==>> 송신준비됨 OK
    else return 0; // NO REDY
   }  
}
                  
// 1 byte char tx
void tx_send(unsigned char tx_data, char ch)
{
  while(tx_chk(ch) == 0);
  // while(!(UCSRA & 0x20));
  
  
  if(tx_chk(ch) == 1)  
   {
     if(ch == UART_CH0) UDR0 = tx_data;  // uart 0
     else UDR1 = tx_data;  // uart 1
   } 
}

void tx(unsigned char flash *tx_d, char ch) 
{   
  //unsigned char buf;         
  // uart 로 문자열 전송시 
  while(*tx_d != '\0')
  {
    tx_send(*tx_d, ch);
    tx_d++;
  }
} 
      






// Atmega m64, m162, m128
interrupt [USART0_RXC] void usart0_rx_int(void)
{
    unsigned char buf;
    buf = UDR0;
    tx_send(buf, 1);
    //tx_send(buf, 0);
    
    
    /*          
    if(buf == '\n')
    {
        rx0_end_flag = 1;
        rx0_cnt = 0;
    }
    else
    {    
        rx0_buf[rx0_cnt++] = buf;
    }
   */   
  
}

interrupt [USART1_RXC] void usart1_rx_int(void)
{
    unsigned char buf;
    buf = UDR1;
    //rx_bt[1] = buf;   
    
    tx_send(buf, 0); // song 추가
    
    //tx_send(buf,0);
    
    //printf("okk");
}

#endif
