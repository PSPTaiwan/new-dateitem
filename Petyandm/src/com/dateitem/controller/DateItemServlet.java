package com.dateitem.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.dateitem.model.*;
import com.dateitem.model.DateItemService;
import com.dateitem.model.DateItemVO;
import com.member.model.Member;
import com.member.model.MemberService;
import com.pet.model.Pet;
import com.restaurant.model.Restaurant;
import com.restaurant.model.RestaurantService;
@MultipartConfig(fileSizeThreshold =500* 1024 * 1024, maxFileSize = 500 * 1024 * 1024, maxRequestSize = 5 * 500 * 1024 * 1024)
public class DateItemServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=Big5");
		String action = req.getParameter("action");

		// �Ӧ�select_page.jsp�W�[���|�ӫ~
		if ("check_Seller".equals(action)) { 

			
			
			MemberService memSvc = new MemberService();
			List<Pet> myPetList = new ArrayList<Pet>();
			
			HttpSession session = req.getSession();
			Member member = (Member) session.getAttribute("member");

			myPetList = memSvc.getPetsByMemNo(member.getMemNo());
			System.out.println(myPetList.size());
			
			//�S�d�����ϥΪ̾ɨ��d�����U
			if(myPetList.size()==0){
				String url = "/front_end/pet/petRegister.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}else{//���d�����ϥΪ̨�W�[
			req.setAttribute("myPetList", myPetList);
			String url = "/front_end/dateitem/addDateItem.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}								
		}	
		
		//�R�a�˵��w�ʶR��������������ӫ~
		if ("list_buyer_future".equals(action)) { // �Ӧ�select_page.jsp�W�[���|�ӫ~
			
//			DateItemService dSvc = new DateItemService();
//			List<DateItemVO> futurelist = new ArrayList<DateItemVO>();
//			futurelist = dSvc.findByBuyer_future(5007);
//			
//			req.setAttribute("futurelist", futurelist);         
			String url = "/front_end/dateitem/list_buyer_future.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
			successView.forward(req, res);
										
		}
		
		//�R�a�˵��w������������v�ӫ~
		if ("list_buyer_history".equals(action)) { // �Ӧ�select_page.jsp�W�[���|�ӫ~
			        
			String url = "/front_end/dateitem/list_buyer_history.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
			successView.forward(req, res);
										
		}
		
		//�R�a�ʶR�@�Ӱӫ~
		if("buy_date".equals(action)){
		//�����L�ˬd�x�Ȫ�����
			HttpSession session = req.getSession();
			Member member = (Member) session.getAttribute("member");
			int buyerNo = member.getMemNo();
			
			System.out.println(req.getParameter("dateItemNo"));
						
			Integer dateItemNo = new Integer(req.getParameter("dateItemNo").trim());
			DateItemService dSvc = new DateItemService();
			DateItemVO dateItemVO = dSvc.findByPK(dateItemNo);
							
			dateItemVO.setBuyerNo(buyerNo);
			dateItemVO.setDateItemStatus(1);
			dateItemVO.setDateItemShow(1);
			dSvc.updateByVO(dateItemVO);
			System.out.println(dateItemVO.getBuyerNo());
			System.out.println(dateItemVO.getDateItemShow());
			
			//�����ʶR������setAttribute,�����ʶR�����˵�
			req.setAttribute("itemPurchased", dateItemVO);
			String url = "/front_end/dateitem/list_buyer_future.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}
		
		//�����@�Ӱӫ~
		if("cancel_date".equals(action)){
		//�����L�ˬd�x�Ȫ�����
			
			System.out.println(req.getParameter("dateItemNo"));
						
			Integer dateItemNo = new Integer(req.getParameter("dateItemNo").trim());
			DateItemService dSvc = new DateItemService();
			DateItemVO dateItemVO = dSvc.findByPK(dateItemNo);
							
			dateItemVO.setDateItemStatus(2);
			dateItemVO.setDateItemShow(1);
			dSvc.updateByVO(dateItemVO);
			
			//��������Ӧ۶R���٬O���,���O�ɦ^�R��誺���v����
			try {
				req.setAttribute("itemCanceled", dateItemVO);
				if (req.getParameter("fromwho").equals("buyer")){
					String url = "/front_end/dateitem/list_buyer_history.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					}
				if	(req.getParameter("fromwho").equals("seller")){
					String url = "/front_end/dateitem/list_seller_history.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					}
			} catch (Exception e) {
					String url = "/front_end/dateitem/select_page.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					}
			}			
		
		
		    if ("checkTime".equals(action)){
				String strNo = req.getParameter("dateItemNo");
				System.out.println(strNo);
				
//				
//				Integer dateItemNo = new Integer(req.getParameter("dateItemNo").trim());
//				DateItemService dSvc = new DateItemService();
//				DateItemVO dateItemVO = dSvc.findByPK(dateItemNo);
//				
//				List<DateItemVO> historyList = dSvc.findByBuyer_future(dateItemNo);
//				for (DateItemVO item: historyList){
//					int count=0;
//					SimpleDateFormat sdf = new SimpleDateFormat("MMdd");
//					if(sdf.format(item.getDateMeetingTime()).equals(sdf.format(dateItemVO.getDateMeetingTime()))){
//						count++;					
//					}
//					
//					if(count>0){
//						PrintWriter out = res.getWriter();
//				        out.print("data-toggle=\"modal\" data-target=\"#myModal\"");
//
//					}else{
//
//						String url = req.getContextPath()+"/front_end/dateitem/dateitem.do?action=buy_date";
//						RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
//						successView.forward(req, res);
//						
//					}
//				}
//		    	
		    }
		
		
            if ("insert".equals(action)) { // �Ӧ�addDateItem.jsp���ШD  
			
            	List<String> errorMsgs = new LinkedList<String>();
            	// Store this set in the request scope, in case we need to
            	// send the ErrorPage view.
            	req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				
				String htmltime = req.getParameter("time");
				System.out.println(htmltime);
				
				Timestamp dateMeetingTime = getTimestamp(htmltime);
				System.out.println(getTimestamp(htmltime));
				Timestamp dateItemTime = new Timestamp(System.currentTimeMillis());
				
				// Send the use back to the form, if there were errors
				
				String dateItemTitle = req.getParameter("dateItemTitle");
				if (dateItemTitle == null || (dateItemTitle.trim()).length() == 0) {
					errorMsgs.add("�п�J���D");
					dateItemTitle = "";
				}
				// Send the use back to the form, if there were errors
				
				String dateItemText = req.getParameter("dateItemText");
				if (dateItemText == null || (dateItemText.trim()).length() == 0) {
					errorMsgs.add("�п�J���e");
					dateItemText = "";
				}
				// Send the use back to the form, if there were errors
						
				//���ҹϤ�����=====================================================
				byte[] dateItemImg= null;
				String fileName=null;
				Part part = req.getPart("dateItemImg");
				
				
				
					if(part.getSize()!=0){
						fileName = getFileNameFromPart(part);
						System.out.println(part.equals(null));
						if(getServletContext().getMimeType(fileName).substring(0,5).equals("image")){
							dateItemImg = getByteArrayImg(part);
							System.out.println("�Ϥ��榡���T!");
						}
					}else {
					errorMsgs.add("�ФW�ǹϤ�");
				}
				
				
				

		        //============================================================================		
				
				//�p�G���~�^�Ǥ@��VO=====================================
				
				HttpSession session = req.getSession();
				Member member = (Member) session.getAttribute("member");
				DateItemVO dateItemVO = new DateItemVO();
				dateItemVO.setSellerNo(member.getMemNo());
				dateItemVO.setRestListNo(Integer.parseInt(req.getParameter("restListNo")));
				dateItemVO.setPetNo(Integer.parseInt(req.getParameter("petNo")));
				dateItemVO.setDateItemTitle(dateItemTitle);
				dateItemVO.setDateItemText(dateItemText);
				dateItemVO.setDateItemPrice(Integer.parseInt(req.getParameter("dateItemPrice")));
			
				
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					//���s���a�d����T
					MemberService memSvc = new MemberService();
					List<Pet> myPetList = new ArrayList<Pet>();
					myPetList = memSvc.getPetsByMemNo(member.getMemNo());
					
					req.setAttribute("myPetList", myPetList);
					
					req.setAttribute("dateItemVO", dateItemVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/dateitem/addDateItem.jsp");
					failureView.forward(req, res);
					return;
				}
				

				
				/***************************2.�}�l�s�W���***************************************/
				//sellerno�૬
				
				int sellerno = member.getMemNo();
				int restListNo = Integer.parseInt(req.getParameter("restListNo"));
				int petNo = Integer.parseInt(req.getParameter("petNo"));
				int dateItemPeople = Integer.parseInt(req.getParameter("dateItemPeople"));
				Boolean hasMate = Boolean.parseBoolean((req.getParameter("hasMate")));
				int dateItemPrice = Integer.parseInt(req.getParameter("dateItemPrice"));
				//���ܼƦb��Ʈw������l��
				int dateItemStatus = 0 ;
				int dateItemShow = 0;
				int dateItemViewer = 0;
				int buyerNo = 5010 ;
				boolean isQRCChecked = false;
				int buyerRep = 0 ;
				int sellerRep = 0 ;
				boolean isInstantDate = false;

				//�ˬd�O�_����
//				System.out.println(sellerno);
//				System.out.println(restListNo);
//				System.out.println(dateItemTitle);
//				System.out.println(dateItemText);
//				System.out.println(dateItemTime);
//				System.out.println(dateMeetingTime);
//				System.out.println(dateItemPeople);
//				System.out.println(hasMate);
//				System.out.println(dateItemPrice);
//				System.out.println(dateItemStatus);
//				System.out.println("===================");
//				System.out.println(dateItemShow);
//				System.out.println(dateItemViewer);
//				System.out.println(buyerNo);
//				System.out.println(isQRCChecked);
//				System.out.println(buyerRep);
//				System.out.println(sellerRep);
//				System.out.println(isInstantDate);
//				System.out.println(petNo);
				
				
				RestaurantService rSvc = new RestaurantService();
				Restaurant restaurant = rSvc.getOneRest(Integer.parseInt(req.getParameter("restListNo"))); 
				String dateItemLocate = (restaurant.getRestAdd()).substring(0, 3);
				System.out.println(dateItemLocate);
				
				
				DateItemService dateItemSvc = new DateItemService();
				System.out.println("�ǳƷs�W");
				dateItemVO = dateItemSvc.addDateItem(sellerno, restListNo, dateItemTitle, dateItemImg, dateItemText, dateItemTime, dateMeetingTime, dateItemLocate, dateItemPeople, hasMate, dateItemPrice, dateItemStatus, dateItemShow, dateItemViewer, buyerNo, isQRCChecked, buyerRep, sellerRep, isInstantDate, petNo);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				req.setAttribute("itemAdded", dateItemVO);
				String url = "/front_end/dateitem/list_seller_onsale.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/dateitem/addDateItem.jsp");
				failureView.forward(req, res);
			}
		}
	}
	
	public byte[] getByteArrayImg(Part part){
		
		ByteArrayOutputStream diaimg=null;
		try{
			java.io.InputStream in =part.getInputStream(); 
			diaimg = new ByteArrayOutputStream();
			byte[] buffer = new byte[8192];
			int i;
			while ((i = in.read(buffer)) != -1) {
				diaimg.write(buffer, 0, i);
			}
			diaimg.close();
			in.close();
			
			
		}catch(IOException e){
			e.printStackTrace();
		}
		
		return diaimg.toByteArray();
	}
	
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		String filename = header.substring(header.lastIndexOf("=") + 2, header.length() - 1);
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
	
	//�NHtml5 date�ରTimestamp��Method
	
	public Timestamp getTimestamp(String dateStr){	
		int yyyy= Integer.parseInt((dateStr.substring(0, 4)));
		int mm= Integer.parseInt((dateStr.substring(5, 7)));
		int dd= Integer.parseInt((dateStr.substring(8, 10)));
		int hh= Integer.parseInt((dateStr.substring(11, 13)));
		int minute= Integer.parseInt((dateStr.substring(14, 16)));
	GregorianCalendar cal = new GregorianCalendar(yyyy,mm-1,dd,hh,minute,0);
	java.util.Date ud = cal.getTime();
	Timestamp ts= new Timestamp(ud.getTime());
	return ts;	
	}
			
//  �վ�Ϥ��j�p	
//	private static BufferedImage resizeImage(BufferedImage originalImage,int type){
//		BufferedImage resizedImage = new BufferedImage(150,150,type);
//		Graphics2D g = resizedImage.createGraphics();
//		g.drawImage(originalImage, 0, 0, 150, 150, null);
//		g.dispose();
//		
//		return resizedImage;
//	}
//	
}
	
