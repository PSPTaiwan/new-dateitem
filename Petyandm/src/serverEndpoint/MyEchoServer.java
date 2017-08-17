package serverEndpoint;
import java.io.*;
import java.util.*;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;
import com.google.gson.JsonObject;
import com.dateitem.model.DateItemService;
import com.google.gson.Gson;
import org.json.JSONException;
import org.json.JSONObject;
import java.sql.Date;
import java.sql.Timestamp;
import com.msg.model.*;
import org.json.*;



@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
public class MyEchoServer {

	
private final static HashMap<String, Set<Session>> roomMapping = new HashMap<>();


	
	@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") Integer room, Session userSession) throws IOException{ 
//		Sessions.add(userSession);
		String myRoom = room.toString();
		//�p�G�쥻�S�ж�, �N�Ф@���M���ϥΪ̪�session�[�J
		
		String text = String.format("Session ID = %s, connected; myName = %s; room = %s", 
		userSession.getId(), myName, room);
		System.out.println(text);
		
		MsgService msgSvc=new MsgService();
		List<MsgVO> getAllForThisRoom=msgSvc.findByDateItemNo(room);
		for(MsgVO msgVO:getAllForThisRoom){
			userSession.getBasicRemote().sendText(msgVO.getMsgContent());
			if(msgVO.getMsgStatus()==1){
				userSession.getBasicRemote().sendText("�����wŪ");
			}
		}
		
		if (!roomMapping.containsKey(myRoom)){
			Set<Session> sessions = Collections.synchronizedSet(new HashSet<Session>());
			sessions.add(userSession);
			(roomMapping).put(myRoom,sessions);
			}else{
		//�p�G���Ӧ��ж����ϥΪ̨S�b�̭�, �N�����[�L�i�h
				if (!(roomMapping.get(myRoom)).contains(userSession)){
				roomMapping.get(myRoom).add(userSession);
				}
			}
		if (roomMapping.get(myRoom).size()>1){
		for (Session session : roomMapping.get(myRoom)) {
			session.getAsyncRemote().sendText("�����wŪ");
			}
		}
		}
						

//		userSession.getBasicRemote().sendText("WebSocket �s�u���\");


	
	@OnMessage
	public void onMessage(@PathParam("myName") String myName ,Session userSession, String message, @PathParam("myRoom") Integer room) throws JSONException {
		String myRoom=room.toString();
		System.out.println(roomMapping.get(myRoom).size());
		for (Session session : roomMapping.get(myRoom)) {
			if (session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		int sendNo = Integer.parseInt(myName);
		int dateItemNo = room;
		DateItemService dSvc = new DateItemService();
		int recNo = dSvc.findTheOtherMem(sendNo, dateItemNo);
		Timestamp msgTime= new Timestamp(System.currentTimeMillis());
		System.out.println(message);
		MsgService msgSvc=new MsgService();
		msgSvc.addMsg(sendNo, recNo, dateItemNo, message, msgTime, 0);
		if (roomMapping.get(myRoom).size()>1){
			List<MsgVO> getAllForThisRoom=msgSvc.findByDateItemNo(dateItemNo);
			for(MsgVO msgVO:getAllForThisRoom){
				msgVO.setMsgStatus(1);
				msgSvc.updateMsgByVO(msgVO);
				}
			for (Session session : roomMapping.get(myRoom)) {
				session.getAsyncRemote().sendText("�����wŪ");
			}
		}
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason,@PathParam("myRoom") Integer room) {
		String myRoom=room.toString();
		roomMapping.get(myRoom).remove(userSession);
	}

 
}
