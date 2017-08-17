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

@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
public class MyEchoServer {

	
private final static HashMap<String, Set<Session>> roomMapping = new HashMap<>();


	
	@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") Integer room, Session userSession) throws IOException {
//		Sessions.add(userSession);
		String myRoom = room.toString();
		//�p�G�쥻�S�ж�, �N�Ф@���M���ϥΪ̪�session�[�J
		
		String text = String.format("Session ID = %s, connected; myName = %s; room = %s", 
		userSession.getId(), myName, room);
		System.out.println(text);
		
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
		}
						

//		userSession.getBasicRemote().sendText("WebSocket �s�u���\");


	
	@OnMessage
	public void onMessage(@PathParam("name") String name ,Session userSession, String message,@PathParam("myRoom") Integer room) {
		String myRoom=room.toString();
		System.out.println(roomMapping.get(myRoom).size());
		for (Session session : roomMapping.get(myRoom)) {
//			if (session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: " + message);
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
