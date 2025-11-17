MODULE CommunicateModule
    
    VAR socketdev laser_socket;
    VAR bool socket_connected:=FALSE;
    
    CONST string LASER_IP:="192.168.125.201"; !"127.0.0.1";
    CONST num LASER_PORT:=12345;
    
    VAR string laser_request;
    VAR string laser_response;
    PERS num laser_x;
    PERS num laser_y;
    PERS num laser_z;
    PERS num laser_t;
    PERS string laser_response_out;
    
    PROC ConnectToLaser()
        IF socket_connected=FALSE THEN
            SocketCreate laser_socket;
            SocketConnect laser_socket,LASER_IP,LASER_PORT;
            socket_connected:=TRUE;
        ENDIF
    ENDPROC
    PROC SendMeasurementToLaser()
        laser_request:="[Measure] x:"+ValToStr(laser_x)+" y:"+ValToStr(laser_y)+" z:"+ValToStr(laser_z)+" t:"+ValToStr(laser_t)+" ms";
        SocketSend laser_socket,\Str:=laser_request;
        SocketReceive laser_socket,\Str:=laser_response;
        
        laser_response_out:=laser_response;
    ENDPROC
    
    PROC DisconnectFromLaser()
        IF socket_connected THEN
            SocketClose laser_socket;
            socket_connected:=FALSE;
        ENDIF
    ENDPROC
    
    PROC ExecuteMeasurementToLaser()
        
        ConnectToLaser;
        SendMeasurementToLaser;
        
    ENDPROC
    
ENDMODULE