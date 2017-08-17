<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dateitem.model.*"%>
<%@ page import="com.restaurant.model.*" %>
<%@ page import="com.member.model.*" %>
<%@ page import="java.util.*"%>

<style>
blockquote>p {
position:relative;
left:1rem;
padding-right:4rem;
}

.fortest button{
margin-left:1%;
float:right;
}

.fortest .a{
margin-left:1%;
float:right;
}


</style>

<%@ include file="header.file"%>




<jsp:useBean id = "dSvc" scope="page" class="com.dateitem.model.DateItemService" />
<jsp:useBean id = "memSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id = "restSvc" scope="page" class="com.restaurant.model.RestaurantService"/>
<jsp:useBean id = "pSvc" scope="page" class="com.pet.model.PetService"/>
<%
 	Member member = (Member) session.getAttribute("member");
    List<DateItemVO> list = dSvc.getAllItems();
    pageContext.setAttribute("list",list);
%>





<head><title>���|����</title></head>
<body bgcolor='white'>



<%@ include file="nav.file"%>
<%@ include file="sidelist.file"%>

<%-- <%@ include file="page3.file"%>	 --%>

<!-- JSP�H�@�ӥ]�t��u��div�}�l, ���O������</div>�g�bfooter�̭� -->


<div class="popup-box chat-popup" id="qnimate">
              <div class="popup-head">
                <div id="chat-title" class="popup-head-left pull-left"><img id="otherpic" src=""></div>
                      <div class="popup-head-right pull-right">
                        <div class="btn-group dropdown">
                                      <button class="chat-header-button dropdown-toggle" data-toggle="dropdown" type="button">
                                       <i class="glyphicon glyphicon-cog"></i> </button>
                                      <ul role="menu" class="dropdown-menu pull-right">
                                        <li><a href="#">Media</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#">Block</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#">Clear Chat</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#">Email Chat</a></li>
                                      </ul>
                        </div>
                        
                        <button data-widget="remove" id="removeClass" class="chat-header-button pull-right" type="button"><i class="glyphicon glyphicon-arrow-left"></i></button>
                      </div>
              </div>


<!-- =============
============= -->

            <div id="scroll-area" class="popup-messages">
            
            
            
            <div id="append" class="direct-chat-messages">
 <!-- =============
============= -->                   
                    
                    <div class="direct-chat-msg doted-border">
                      <div class="direct-chat-info clearfix">
                        <span class="direct-chat-name-left ">��P�U���O��</span>
                      </div>
                     
                      <img src="http://bootsnipp.com/img/avatars/bcf1c0d13e5500875fdd5a7e8ad9752ee16e7462.jpg" class="direct-chat-img-left">
                      <div class="direct-chat-text direct-chat-text-left chat-right">
                        	�w�w�A�n�X������A�n��?
                      </div>
                      <div class="direct-chat-info clearfix">
                        <span class="direct-chat-timestamp ">14:20</span>
                      </div>
                      
                    </div>

                    <div class="direct-chat-msg doted-border">
                      <div class="direct-chat-info clearfix">
                        <span class="direct-chat-name-left ">�p�_��</span>
                      </div>
                     
                      <img alt="iamgurdeeposahan" src="http://bootsnipp.com/img/avatars/bcf1c0d13e5500875fdd5a7e8ad9752ee16e7462.jpg" class="direct-chat-img-left">
                      <div class="direct-chat-text direct-chat-text-left chat-right">
                       	 �A�n��w�w �A�A�o�˧ڭn�������|�o
                      </div>
                      <div class="direct-chat-info clearfix">
                        <span class="direct-chat-timestamp ">20:10</span>
                      </div>
                      
                    </div>

                        <div class="direct-chat-msg doted-border">

                        
                      <div class="direct-chat-info clearfix text-right">
                        <span class="direct-chat-name-right ">��P�U���O��</span>
                      </div>
                        <img alt="iamgurdeeposahan" src="http://bootsnipp.com/img/avatars/bcf1c0d13e5500875fdd5a7e8ad9752ee16e7462.jpg" class="float-right direct-chat-img-right">
                      
                      <div class="direct-chat-text direct-chat-text-right chat-left ">
                      	  �O���j�j
                      </div>
                      <div class="direct-chat-info clearfix">
                        <span class="direct-chat-timestamp ">20:40</span>
                      </div>
                      
                    </div>
                    </div>
 
 <!-- =============
============= -->                   
                    

                
             </div>

<!-- =============
============= -->

            <div class="popup-messages-footer" id="footer">
            <textarea id="status_message" placeholder="�п�J�T��" rows="10" cols="40" name="message"></textarea>
            <div class="btn-footer">
            <button class="bg_none"><i class="glyphicon glyphicon-film"></i> </button>
            <button class="bg_none"><i class="glyphicon glyphicon-camera"></i> </button>
            <button class="bg_none"><i class="glyphicon glyphicon-paperclip"></i> </button>
            <button class="bg_none pull-right"><i class="glyphicon glyphicon-thumbs-up"></i> </button>
            </div>
            </div>
      </div>
  
                    <div class="" id="fixedbutton-talk">
                        <button id="addClass" class="button btn-lg btn-primary active">
                            �}�Ҳ�ѫ�
                        </button>
          				</div>
<%--           <% int latestNo =dSvc.getLastestDateItem( --%>
<%--         		  dSvc.getAllForChats(((Member) session.getAttribute("member")).getMemNo())); %> --%>
        		  
        		
        		<input type="hidden" id="lastestItemNo" value="${dSvc.getLastestDateItemNo(
        		  dSvc.getAllForChats(member.memNo))}"/>

        		  
        		    
        		    
<!--         		�T�{�b��ܥ\�त�ۤv�O�R���٬O���, �����H�O��     -->
				<% Integer otherUserNo;				
					Integer me=member.getMemNo();
					Integer seller=(dSvc.getLastestDateItem(
			        		  dSvc.getAllForChats(member.getMemNo()))).getSellerNo();
					Integer buyer=(dSvc.getLastestDateItem(
			        		  dSvc.getAllForChats(member.getMemNo()))).getBuyerNo();
					if(me.equals(seller)){
						otherUserNo=buyer;
					}else{
						otherUserNo=seller;
					}
					String otherUserName = memSvc.getOneMember(otherUserNo).getMemSname();

				%>
				<input type="hidden" id="otherUserNo" value="<%=otherUserNo%>"/>
				<input type="hidden" id="otherUserName" value="<%=otherUserName%>"/>
				<input type="hidden" id="userNo" value="${member.memNo}"/>
        		<input type="hidden" id="userName" value="${member.memSname}"/>
                    


<script>

var MyPoint = "/MyEchoServer/"+$('#userNo').val()+"/"+$('#lastestItemNo').val();
var host = window.location.host;
var path = window.location.pathname;
var webCtx = path.substring(0, path.indexOf('/', 1));
var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

$(document).ready(function(){
	
	$('#status_message').on('keyup', function(e) {
	    if (e.which == 13) {	    	
	    	sendMessage();
	    }
	});
	
	
	
	$("#addClass").click(function () {
	          $('#qnimate').addClass('popup-box-on');
	          $("#addClass").css('visibility', 'hidden');
	          alert($('#lastestItemNo').val());
	          alert($('#userNo').val());
	          var userName=$('#userName').val();
	          var userNo=$('#userNo').val();
			  var dateItemNo=$('#lastestItemNo').val();
			  var otherUserNo=$('#otherUserNo').val();
			  var otherUserName=$('#otherUserName').val();
			  var towhom='<img id="otherpic">���b�� '+otherUserName+' �i����';
			  
			  $('#chat-title').html(towhom);
			  $("#otherpic").attr('src','ImgReader?sellerNo='+otherUserNo+'&action=memImg');
	          
	          
	      	var statusOutput = document.getElementById("statusOutput");
	      	var webSocket;
	      	connect();
	});

	
	function connect() {
		// �إ� websocket ����
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {

			//���J���v���
		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			//��
			if (jsonObj.userNo==userNo.value){
				//�걵����r��
				var contentString='<div class="direct-chat-msg doted-border"><div class="direct-chat-info clearfix"><span class="direct-chat-name-left ">'+jsonObj.userName+'</span></div><img src="ImgReader?sellerNo='+jsonObj.userNo+'&action=memImg" class="direct-chat-img-left"><div class="direct-chat-text direct-chat-text-left chat-right">'+jsonObj.message+'</div><div class="direct-chat-info clearfix"><span class="direct-chat-timestamp ">'+jsonObj.time+'</span></div></div>';
				//�N�r��append��e���W
				$('#append').append(contentString);
				//�V�U���ʨ�̩��U
				$("#scroll-area").animate({ scrollTop: $('#scroll-area')[0].scrollHeight }, 1000);
			}else{
				var contentStr='<div class="direct-chat-msg doted-border"><div class="direct-chat-info clearfix"><span class="direct-chat-name-right ">'+jsonObj.userName+'</span></div><img src="ImgReader?sellerNo='+jsonObj.userNo+'&action=memImg" class="direct-chat-img-right"><div class="direct-chat-text direct-chat-text-right chat-left">'+jsonObj.message+'</div><div class="direct-chat-info clearfix"><span class="direct-chat-timestamp ">'+jsonObj.time+'</span></div></div>';
				$('#append').append(contentStr);
				//�V�U���ʨ�̩��U
				$("#scroll-area").animate({ scrollTop: $('#scroll-area')[0].scrollHeight }, 1000);
			}
	        	       
//	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
// 	        messagesArea.value = messagesArea.value + message;
// 	        messagesArea.scrollTop = messagesArea.scrollHeight;
		};

		webSocket.onclose = function(event) {
			alert("�w���u");
		};
	}
		            
	          
	            $("#removeClass").click(function () {
	          $('#qnimate').removeClass('popup-box-on');
	          $("#addClass").css('visibility', 'visible');
	          webSocket.close();
	            });
	            

	            
	            
	        	function sendMessage() {
	        		var time= new Date().toLocaleString();
	        		var message=$("#status_message").val().trim();
	    	        var jsonObj = {"userNo" : $('#userNo').val() ,"userName" : $('#userName').val() , "message" : message , "time":time};
	    	        if (message.length>1){
	    	        webSocket.send(JSON.stringify(jsonObj));
	    	        $('#status_message').val('');
	        	    }
	        	}
	        	    
	            
	            }); 
  	           
</script>



