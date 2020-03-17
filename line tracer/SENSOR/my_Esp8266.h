#ifndef _Esp8266_
#define _Esp8266_


 
void esp8266_init(void)
{  
  // at command tx 
  printf("AT\r\n");     
  delay_ms(2000);   
  
  // esp8266 ret                
  printf("AT+RST\r\n");
  delay_ms(2000); 
  
  // esp 현재 mode 확인    
  printf("AT+CWMODE?\r\n");
  delay_ms(2000);
  
  // MODE SET = 설정되었으면 안해도 됨         
  // printf("AT+CWMODE=1\r\n"); // esp8266 mode 1 설정 = 초기 했으면 안 해도 됨 
  //delay_ms(10);
  
  // ap 접속 연결                             
  printf("AT+CWJAP=");
  putchar('"');
  printf("iptime");
  putchar('"');
  putchar(',');
  putchar('"');
  printf("1q2w3e4r");
  putchar('"');
  printf("\r\n");
  delay_ms(5000); // ap 공유기 접속하는데 시간이 걸림 = 대략 3-4초 지연 발생 
  
  // ap 접속 확인
  printf("AT+CWJAP?\r\n");
  delay_ms(3000);
  // ip주소확인 = esp8266 클라이언트
  printf("AT+CIFSR\r\n"); 
  delay_ms(2000);
  
  //서버연결 = 서버ip주소, 포트지정해줘야
  printf("AT+CIPSTART=");
  putchar('"');
  printf("TCP"); // 프로토클 선택 = tx("TCP",0) 으로도 가 
  putchar('"');                     
  putchar(',');  // tx_send(',',0); 으로도 가능
  putchar('"');
  printf("220.66.144.97"); //ip 주소 = 서버쪽 ip
  putchar('"');
  putchar(',');
  printf("8001\r\n"); // 연결포트
  delay_ms(200);  
  
  
} 

void esp_tx_test(void)
{
  // esp8266 tx test
  printf("AT+CIPSEND=18\r\n");
  delay_ms(1);
  
}

#endif
