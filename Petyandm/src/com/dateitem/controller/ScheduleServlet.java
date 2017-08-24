package com.dateitem.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

import com.dateitem.model.DateItemService;
import com.dateitem.model.DateItemVO;

import java.util.*;

public class ScheduleServlet extends HttpServlet {
   
    
    Timer timer;
    int i=0;      
   
    public void init() throws ServletException {
      TimerTask task = new TimerTask(){ 
	        public void run() {
//	        	======================把六小時內的約會下架======================
	        	DateItemService dSvc=new DateItemService();
	        	List<DateItemVO> list = dSvc.getAllItems();
	        	
	        	//即時約會過時間下架, 一般商品四小時前下架
				for(DateItemVO dateItemVO:list){
					Long dateItemMeetingTime = (dateItemVO.getDateMeetingTime()).getTime();
					Long now = System.currentTimeMillis();
					Long fourHour = 60*60*4*1000l ;
					//把每個商品跟目前要上架的時間都轉成long比較是否差距四小時
					if(dateItemVO.getIsInstantDate()==false){
						if (dateItemMeetingTime-now<fourHour){
							dateItemVO.setDateItemShow(1);
						}
					}else if(dateItemVO.getIsInstantDate()==true){
						if (dateItemMeetingTime<now){
							dateItemVO.setDateItemShow(1);
						}
					}
				}   
	        } 
      };
      timer = new Timer(); 
      Calendar cal = new GregorianCalendar(2017, Calendar.AUGUST, 12, 0, 0, 0);
      timer.scheduleAtFixedRate(task, cal.getTime(), 1*60*60*1000);
      System.out.println("已建立排程!");       
    }
    

    public void doGet(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {
    }                           	

    public void destroy() {
        timer.cancel();
        System.out.println("已移除排程!");
    }
    
}