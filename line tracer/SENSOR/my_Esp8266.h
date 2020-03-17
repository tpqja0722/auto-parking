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
  
  // esp ���� mode Ȯ��    
  printf("AT+CWMODE?\r\n");
  delay_ms(2000);
  
  // MODE SET = �����Ǿ����� ���ص� ��         
  // printf("AT+CWMODE=1\r\n"); // esp8266 mode 1 ���� = �ʱ� ������ �� �ص� �� 
  //delay_ms(10);
  
  // ap ���� ����                             
  printf("AT+CWJAP=");
  putchar('"');
  printf("iptime");
  putchar('"');
  putchar(',');
  putchar('"');
  printf("1q2w3e4r");
  putchar('"');
  printf("\r\n");
  delay_ms(5000); // ap ������ �����ϴµ� �ð��� �ɸ� = �뷫 3-4�� ���� �߻� 
  
  // ap ���� Ȯ��
  printf("AT+CWJAP?\r\n");
  delay_ms(3000);
  // ip�ּ�Ȯ�� = esp8266 Ŭ���̾�Ʈ
  printf("AT+CIFSR\r\n"); 
  delay_ms(2000);
  
  //�������� = ����ip�ּ�, ��Ʈ���������
  printf("AT+CIPSTART=");
  putchar('"');
  printf("TCP"); // ������Ŭ ���� = tx("TCP",0) ���ε� �� 
  putchar('"');                     
  putchar(',');  // tx_send(',',0); ���ε� ����
  putchar('"');
  printf("220.66.144.97"); //ip �ּ� = ������ ip
  putchar('"');
  putchar(',');
  printf("8001\r\n"); // ������Ʈ
  delay_ms(200);  
  
  
} 

void esp_tx_test(void)
{
  // esp8266 tx test
  printf("AT+CIPSEND=18\r\n");
  delay_ms(1);
  
}

#endif
