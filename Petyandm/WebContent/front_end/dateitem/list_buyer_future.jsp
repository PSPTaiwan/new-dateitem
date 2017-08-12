<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dateitem.model.*"%>
<%@ page import="com.restaurant.model.*" %>
<%@ page import="com.member.model.*" %>
<%@ page import="java.util.*"%>

<%@ include file="header.file"%>

<jsp:useBean id = "dSvc" scope="page" class="com.dateitem.model.DateItemService" />
<jsp:useBean id = "memSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id = "restSvc" scope="page" class="com.restaurant.model.RestaurantService"/>

<%
Member member = (Member) session.getAttribute("member");
List<DateItemVO> list = dSvc.findByBuyer_future(member.getMemNo());
pageContext.setAttribute("list",list);
%>



<head><title>�ʶR����</title></head>
<body bgcolor='white'>

<%@ include file="nav.file"%>
<%@ include file="sidelist.file"%>

<!-- JSP�H�@�ӥ]�t��u��div�}�l, ���O������</div>�g�bfooter�̭� -->

<div class="col-xd-12 col-sm-8 col-sm-offset-1 main-page-show">

					<ul class="list-inline amos">
					<li class="text-sucess"><b><a href="<%=request.getContextPath() %>/front_end/dateitem/dateitem.do?action=list_buyer_future">�i�椤�����|</a></b></li>
					<li class="text-sucess"><b><a href="<%=request.getContextPath() %>/front_end/dateitem/dateitem.do?action=list_buyer_history">�L�h�����|���</a></b></li>
					</ul>
  
  <c:if test="${not empty itemPurchased}">
  <h1>�z�w�ʶR���\�A�s�W�@�����|!</h1>
   <c:remove var="itemPurchased" scope="request"/>
  </c:if>
  
    <c:if test="${not empty itemNotFound}">
  <h1>�ܩ�p!���|�w�g�m���@�B�Q�H�w��, �п�ܨ�L���|!</h1>
   <c:remove var="itemPurchased" scope="request"/>
  </c:if>
	
	

    <div class="row">
        <div class="col-sm-12">
            <table class="table table-hover">
                <thead>
                    <tr>
                    	
                        <th>���|</th>
                        <th></th>
                        <th>�ɶ�</th>
                        <th class="text-center">�\�U</th>
                        <th class="text-center"></th>
                        <th></th>
                    </tr>
                </thead>
				<tobdy>
	
<c:forEach var="dateitem" items="${list}" >

<tr>
                        <td class="col-sm-6">
                        <div class="media">
                            <a class="thumbnail pull-left" > <img class="media-object" src="ImgReader?dateItemNo=${dateitem.dateItemNo}&action=dateImg" style="width: 100px; height: 100px;"> </a>
                            <div class="media-body">
                                <h4 class="media-heading"><strong>${dateitem.dateItemTitle}</strong></h4>
                                <h6 class="media-heading"><small> by </small> <a href="#"><small>${memSvc.getOneMember(dateitem.sellerNo).getMemSname()}</small></a></h6>
                                <span> &nbsp;���A: </span><span class="text-success"><strong>�Y�N�i��</strong></span>
                            </div>
                        </div></td>
                        <td class="col-sm-1 "></td>
                        <td class="col-sm-1 " style="text-align: center">
                        ${dSvc.getTimeForItem(dateitem.dateMeetingTime)}
                        </td>
                       	
                        <td class="col-sm-3  text-center"><strong>${restSvc.getOneRest(dateitem.restListNo).getRestName()}</strong></td>
                        <td class="col-sm-1 ">
			<td><a class="btn btn-warning btn-xs" data-toggle="modal" data-target="#modal-cancel" href="#">�ڭn����</a></td>
			<td><a class="btn btn-default btn-xs" data-toggle="modal" data-target="#modal-app" href="#">�ڭn�ӶD</a></td>
                        </td>
                    </tr>


		<div id="modal-cancel" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">�������|�w�w</h4>
      </div>
      <div class="modal-body">
        <p></p>
        <p>�T�w�w����?</p>
      </div>
      <div class="modal-footer">
        <a type="button" class="btn btn-primary" href="<%=request.getContextPath() %>/front_end/dateitem/dateitem.do?action=cancel_date&dateItemNo=${dateitem.dateItemNo}&fromwho=buyer">�T�{����</a>
        <button type="button" class="btn btn-warning" data-dismiss="modal">�^�W�@��</button>
      </div>
    </div>

  </div>
  </div>
<!-- ================================================�������s��modal,�����bforeach��=====		 -->		
  </c:forEach>
  
  
  
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-center">�@�����|</td>
                        <td class="text-left"><%=list.size()%>��</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<%@ include file="footer.file"%>





