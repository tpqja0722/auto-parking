/*******************************************************
This program was created by the CodeWizardAVR V3.37 
Automatic Program Generator
© Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2019-11-03
Author  : 
Company : 
Comments: 


Chip type               : ATmega128
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 1024
*******************************************************/

#include <mega128.h>
#include <stdio.h>
#include <delay.h>

unsigned char rx_bt[20];
char bt_flag=0;
char cnt=0,left=0,right=0;


// motor 1   //left motor
#define mt1_cw  PORTB.5 // oc1a
#define mt1_ccw PORTB.6 // oc1b

// motor 2   //rithgt motor
#define mt2_cw PORTE.4 // oc3b
#define mt2_ccw  PORTE.3 // oc3a


#define m_all_stop (mt1_cw = 0, mt2_ccw = 0, mt2_cw = 0, mt2_ccw = 0); 
//#define m1_stop    (mt1_cw = 0, mt1_ccw = 0)
//#define m2_stop    (mt2_cw = 0,mt2_ccw = 0)

#define m1_cw     (mt1_cw = 1, mt1_ccw = 0)
#define m1_ccw    (mt1_cw = 0, mt1_ccw = 1)   //Á¤
#define m2_cw     (mt2_cw = 1, mt2_ccw = 0)
#define m2_ccw    (mt2_cw = 0, mt2_ccw = 1)   //Á¤
#define m1_st     (mt1_cw = 0, mt1_ccw = 0)
#define m2_st     (mt2_cw = 0, mt2_ccw = 0)

#define gogo (m1_ccw,m2_ccw)
#define back (m1_cw,  m2_cw)

#include "uart_lib.h"
#include "my_Esp8266.h"

char gg;
unsigned char sensor;
bit chk_flag = 0;
char cnt_back = 0;


void gogo_gogo(void)
{   
    gogo;      
    delay_ms(10);
    m_all_stop;
    delay_ms(10); 
    gogo;      
    delay_ms(10);
    m_all_stop;
    delay_ms(10);
}

void gogo_left(void)
{
    do
    { 
      sensor = (~(PINF & 0x0f));      
      sensor &= 0x0f;
      // m_all_stop; 
      //delay_ms(10);
    
      //gogo;
      //delay_ms(200);
      //m_all_stop;
      m2_ccw;
      m1_st;
      //delay_ms(250);   
      left=1;
     
    }
    while(sensor != 0x02);
    //PORTE.3 = 1;
    //mt2_ccw = 1;
   //PORTB.5 = 1;
    //mt1_cw  = 0;
    //delay_ms(1000);
    
    //m_all_stop;
    //gogo;
    //delay_ms(50);
}

void gogo_right(void)
{
    //m_all_stop; 
    //delay_ms(10); 

     do
    {  
      sensor = (~(PINF & 0x0f));      
      sensor &= 0x0f;

      // m_all_stop; 
      //delay_ms(10);
    
      //gogo;
      //delay_ms(200);
      //m_all_stop;
     m1_ccw;
     m2_st;
     /*
     delay_ms(150);
      sensor = (~(PINF & 0x0f));      
      sensor &= 0x0f; 
      */
      right=1;
     //printf("%d",sensor);
     }
    while(sensor != 0x04);
    //gogo;
    //delay_ms(200);
    //m_all_stop; 
     //m1_ccw;
     //m2_st;
    //mt1_ccw = 1;
    // mt2_cw  = 0;
    //delay_ms(1200);
    
    //m_all_stop; 
    //gogo;
    //delay_ms(50);
   
}


void station_1(void)
{
 
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  //sensor2();
        m2_ccw; m1_st;              break; 
        case 0x04:  //sensor3();
        m1_ccw; m2_st;              break;
        case 0x0f:  gogo_left();    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;  
                    
                                   break; 
        case 0x01:  m2_ccw; m1_st; break;
        case 0x08:  m1_ccw; m2_st; break;
    }
}

void station_2(void)
{
  
         
    switch(sensor)                                      
    {    
        
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:  gogo_right();
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;  
                   
                                   break; 
        case 0x01:  m2_ccw; m1_st; break;
        case 0x08:  m1_ccw; m2_st; break;
    }
}

void station_3(void)
{
   
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:  
                    if(cnt == 1) 
                    {
                        gogo_left();
                        cnt = 0;
                    }
                    if(cnt == 0) 
                    {
                        gogo;
                        delay_ms(250);
                        cnt += 1;
                    }    
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;
                   
                                    break; 
        case 0x01:  m2_ccw; m1_st;  break;
        case 0x08:  m1_ccw; m2_st;  break;
    }
}

void station_4(void)
{
  
         
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:  if(cnt == 1) 
                    {
                        gogo_right();
                        cnt = 0; 
                    }
                    else if(cnt == 0) 
                    {
                        gogo;
                        delay_ms(250);
                        cnt += 1;
                    }    
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0; 
                   
                                    break; 
        case 0x01:  m2_ccw; m1_st;  break;
        case 0x08:  m1_ccw; m2_st;  break;
                    
                    
    }
}

void station_5(void)
{
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:  
                    if(cnt == 2) 
                    {
                        gogo_left();
                        cnt = 0;
                    }
                    else if(((cnt == 1) || (cnt == 0)) == 1) 
                    {
                        gogo;
                        delay_ms(250);
                        cnt += 1;
                    }    
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0; 
                   
                                    break;  
        case 0x01:  m2_ccw; m1_st;  break;
        case 0x08:  m1_ccw; m2_st;  break;
                    
                    
    }
}

void station_6(void)
{
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:  if(cnt == 2) 
                    {
                        gogo_right();
                        cnt = 0;
                    }
                    else if((cnt == 1 || cnt == 0) == 1) 
                    {
                        gogo;
                        delay_ms(250);
                        cnt += 1;
                    }    
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0; 
                   
                                    break;  
        case 0x01:  m2_ccw; m1_st;  break;
        case 0x08:  m1_ccw; m2_st;  break;
                   
                   
    }
}

void station_7(void)
{
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:  
                    if(cnt == 3) 
                    {
                        gogo_left();
                        cnt = 0;
                    }
                    if((cnt == 1 || cnt == 0 || cnt == 2) == 1) 
                    {
                        gogo;
                        delay_ms(250);
                        cnt += 1;
                    }    
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;
                   
                                    break; 
        case 0x01:  m2_ccw; m1_st;  break;
        case 0x08:  m1_ccw; m2_st;  break;
                   
                    
    }
}

void station_8(void)
{
    switch(sensor)                                      
    {
        case 0x00:  gogo;           break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:    
                    if(cnt == 3) 
                    {
                        gogo_right();
                         cnt = 0;
                    }
                    if((cnt == 1 || cnt == 0 || cnt == 2) == 1) 
                    {
                        gogo;
                        delay_ms(250);
                        cnt += 1;
                    }    
                    break;   
        case 0x09:  back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;
                    
                                    break; 
        case 0x01:  m2_ccw; m1_st;  break;
        case 0x08:  m1_ccw; m2_st;  break;
    }
}


void go_home_odd(void)
{
    switch(sensor)                                      
    {
        case 0x00:  if(cnt_back == 0) 
                    {
                       while(((~PINF.1) && (~PINF.2)) == 0)
                       {
                         back;
                       }
                     
                       gogo;
                       delay_ms(20);
                       m_all_stop;
                       delay_ms(1000); 
                       gogo_left();
                       cnt_back=1;
                       tx_send('1',1);  
                       
                    }
                    else if(cnt_back == 1)
                    {
                     gogo;  
                        tx_send('2',1); 
                    }               
                    break; 
    /*    case 0x0f:  gogo;
                       delay_ms(20);
                       m_all_stop;
                       delay_ms(1000); 
                       gogo_left();
                       cnt_back=1;
                       tx_send('1',1); 

                          break;  */
        case 0x02:  m2_ccw; m1_st;    tx_send('3',1);  break; 
        case 0x04:  m1_ccw; m2_st;   tx_send('4',1);   break;
         
        case 0x09:
                    back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;
                    cnt = 0;
                    left=0;
                    cnt_back = 0;
                       tx_send('5',1); 
                    
                    break; 
        case 0x01:  m2_ccw; m1_st; delay_ms(20);  break;
        case 0x08:  m1_ccw; m2_st; delay_ms(20); break;
    }
}

void go_home_even(void)
{
    switch(sensor)                                      
    {
        case 0x00:  gogo;          break;
        case 0x02:  m2_ccw; m1_st;  break; 
        case 0x04:  m1_ccw; m2_st;  break;
        case 0x0f:    
                    if(cnt == 0) 
                    {   
                        gogo;
                        delay_ms(30);
                        gogo_right(); 
                        cnt_back++;
                        cnt++;
                    }
                    break;  
        case 0x09:  if(cnt_back == 0) 
                    {
                       while(sensor != 0x0f)
                       {
                         back;
                         sensor = (~(PINF & 0x0f));      
                         sensor &= 0x0f;
                       }
                    }
                    else if(cnt_back == 1)
                    {
                    back;
                    delay_ms(20);
                    m_all_stop;
                    rx_bt[1] = 0;
                    cnt = 0;
                    right=0;
                    cnt_back = 0;
                    }
                    break; 
        case 0x01:  m2_ccw; m1_st; delay_ms(20); break;
        case 0x08:  m1_ccw; m2_st; delay_ms(20); break;
    }
}


void main(void)
{
    DDRF = 0x00;
    DDRB = 0xff;
    DDRE = 0xff;
   
               
    
    
    #asm("sei"); 
    
    
    
    uart0_init();
    uart1_init();
    
    cnt = 0;
    

while (1)
      {  
      
      
         sensor = (~(PINF & 0x0f));      
         sensor &= 0x0f; 
              
         switch(rx_bt[1])
         {   
            case 0x00:  m1_st; m2_st;     break;
            case 0x01:  station_1();      break;
            case 0x02:  station_2();      break;
            case 0x03:  station_3();      break;
            case 0x04:  station_4();      break;
            case 0x05:  station_5();      break;
            case 0x06:  station_6();      break;
            case 0x07:  station_7();      break;    
            case 0x08:  station_8();      break;
            case 0x09:  m2_ccw; m1_st;    break;
            case 0x0a:  m1_ccw; m2_st;    break;
            case 0x0b:  gogo;             break;  //0b
            case 0x0c:  back;             break;
            case 0x0d: if(left==1)
                          {
                           go_home_odd();
                          }         
                      
                       else if(right==1)
                          {

                            go_home_even();    
                          }
                         
                       break;
          
            
         }    
             
      }
}
