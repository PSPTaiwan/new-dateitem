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

<div class="col-xd-12 col-sm-10  main-page-show">
<div class="col-sm-10 col-sm-offset-1">

<span >
 <select class="w3-select selectpicker " name="option">
    <option value="" disabled selected>�п�ܦa�I</option>
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
  </select>
  <select class="w3-select selectpicker" name="option">
    <option value="" disabled selected>�п�ܥD�H</option>
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
  </select>
  <select class="w3-select selectpicker" name="option">
    <option value="" disabled selected>�п���d��</option>
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option></select>
	
  <button class="btn btn-lg btn-warning glyphicon glyphicon-search"> </button>
  <button class="btn btn-default" id="button1" value="showppl" >�H�D�H��ܬ��|</button>

 </span> 

 </div>
 

  <c:forEach var="dateitem" items="${list}">
          <div class="col-sm-4 ">
            <div class="bg-color">
            <div class="card hovercard">
                <div class="cardheader" style="background-image:url('ImgReader?dateItemNo=${dateitem.dateItemNo}&action=dateImg');">

                <input  type="hidden" value="${dateitem.sellerNo}">
                <input class="no1" type="hidden" value="${dateitem.dateItemNo}">

                </div>
                <div class="avatar">
                	 <input  type="hidden" value="${dateitem.sellerNo}">
                    <img class="img1" src="ImgReader?sellerNo=${dateitem.sellerNo}&action=memImg">
                    <input  type="hidden" value="${dateitem.dateItemNo}">
  
                </div>
                <div class="info">
                    <div class="title dateDes">
                        <a class="dateDes" target="_blank" href="">${dateitem.dateItemTitle}</a>
                    </div>
                    <div class="desc">${memSvc.getOneMember(dateitem.sellerNo).getMemSname()}</div>
                    <div class="desc">${dSvc.getTimeForItem(dateitem.dateMeetingTime)}</div>
                    <div class="desc">${dateitem.dateItemLocate}</div>
                </div>
                <div class="bottom">
                    <a class="btn btn-info"  data-toggle="modal" data-target="#modal-detail${dateitem.dateItemNo}" href="">
                        �Ա�
                    </a>
                </div>
                </div>
            </div>

        </div>
 
<!--  �ӫ~���Ӫ����� -->

<div id="modal-detail${dateitem.dateItemNo}" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
    
    
      <div class="modal-header">
  
  <div class ="main-container">

<div class=" highlight">
<h1><b>${dateitem.dateItemTitle}</b></h1>
	<div class="row">
  
  
  
		<div id="cc">
        <img id="memphoto-detail${dateitem.dateItemNo}"src ="ImgReader?sellerNo=${dateitem.sellerNo}&action=memImg" />
      
        </div>
        <ul>
        
        
            <li> <h2><a href="" style="color:white;">
            ${memSvc.getOneMember(dateitem.sellerNo).getMemSname()} && ${pSvc.getOnePet(dateitem.petNo).getPetName()}
            </a></h2></li>
            <li>�\�U:${restSvc.getOneRest(dateitem.restListNo).getRestName()} - �Ҧb�a:<a href="" class="btn btn-xs btn-basic">�ݦa��</a></li>
            <li>${dSvc.getTimeForItem(dateitem.dateMeetingTime)}</li>
            <li>�ѥ[�H�ƤW��:${dateitem.dateItemPeople}�H  - 
            	�d���D�H���:
            	<c:if test="${dateitem.hasMate==true}">��</c:if>
            	<c:if test="${dateitem.hasMate==false}">�S��</c:if>           	
            	</li>
            <li><h3 class="cost"><span class="glyphicon glyphicon-usd"></span> ${dateitem.dateItemPrice} </h3></li>
           
        </ul>
        
        <div class="row">
        <blockquote >
		<p >${dateitem.dateItemText}</p>
<!-- 		<footer> -->
<%-- 		 <cite>�H��:${dateitem.dateItemViewer}</cite> --%>
<!-- 		</footer> -->
		</blockquote>
        
        </div>
        </div>
        <button class = "btn btn-warning" data-dismiss="modal">�^�W�@��</button>
        
<!--         //����ۤv����R�ۤv�����| -->
       <c:if test="${dateitem.sellerNo!=member.getMemNo()}"> <a href="<%=request.getContextPath() %>/front_end/dateitem/dateitem.do?action=buy_date&dateItemNo=${dateitem.dateItemNo}" 
       type="button" class="check btn btn-primary">�w�w���|</a> </c:if>
        
    </div>
    
    <BR>
	</div>
</div>
</div>
      </div>
    </div>

 
 
 
 
 
 
 </c:forEach>       
  
  
  

<%@ include file="footer.file"%>

<script>

$(document).ready(function(){
		var but1 = $('#button1');
		but1.click(function() {
			if(this.value == 'showppl'){
			but1.val('showpet');
			but1.html('�H�d����ܬ��|')

			
		
			$.ajax({
				url : 'dateitem.do',
				data : {
					action : this.value,
				},
				type : 'POST',
				error : function(xhr) {
					alert('Ajax request �o�Ϳ��~');
				},
				success : function(result) {
// 					alert('sucess1');
					$('.cardheader').each(function(index){
// 						$(this).attr('style', "background-image: url("'ImgReader?sellerNo='+$(this).next('input').val()+'&action=memImg'")");
						$(this).css('background-image','url("ImgReader?sellerNo='+$(this).find('input').val()+'&action=memImg")');
					});
					$('.img1').each(function(index){
						$(this).attr('src','ImgReader?dateItemNo='+$(this).next('input').val()+'&action=dateImg');
					});
// 					$('.avatar').find('img').attr('src','ImgReader?dateItemNo=${dateitem.dateItemNo}&action=dateImg');
				}
			});
			this.value = "showpet";
			
			}else if(this.value == 'showpet'){
				but1.val('showppl');
				but1.html('�H�D�H��ܬ��|')
				$.ajax({
					url : 'dateitem.do',
					data : {
						action : this.value,
					},
					type : 'POST',
					error : function(xhr) {
						alert('Ajax request �o�Ϳ��~');
					},
					success : function(result) {
// 						alert('sucess2');
						$('.cardheader').each(function(index){
//	 						$(this).attr('style', "background-image: url("'ImgReader?sellerNo='+$(this).next('input').val()+'&action=memImg'")");
							$(this).css('background-image','url("ImgReader?dateItemNo='+$(this).find('.no1').val()+'&action=dateImg")');
						});
						$('.img1').each(function(index){
							$(this).attr('src','ImgReader?sellerNo='+$(this).prev('input').val()+'&action=memImg');
						});
//	 					$('.avatar').find('img').attr('src','ImgReader?dateItemNo=${dateitem.dateItemNo}&action=dateImg');
					}
				});
				this.value = "showppl";
			} 
			
			
		});
});

</script>



