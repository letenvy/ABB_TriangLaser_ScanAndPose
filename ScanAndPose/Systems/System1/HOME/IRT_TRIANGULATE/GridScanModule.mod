MODULE GridScanModule
    
    CONST num x_min:=950;
    CONST num x_max:=1280;
    CONST num y_min:=-150;
    CONST num y_max:=100;
    CONST num step_x:=10;
    CONST num step_y:=10;
    CONST num z_scan:=600+125;
    
    VAR num x_current;
    VAR num y_current;
    VAR num row:=0;
    VAR num col:=0;
    VAR num total_points:=0;

    VAR robtarget point;
    VAR robtarget real_pos;
    VAR clock scan_timer;
    VAR num elapsed_ms;
    
    PROC LiveGenerateAndScanGrid()
        total_points := 0;
        row := 0;
        
        ClkReset scan_timer;
        ClkStart scan_timer;
        
        ConnectToLaser;
        
        y_current:=y_min;
        WHILE y_current<=y_max DO
            row:=row+1;
            IF (row MOD 2)=1 THEN
                x_current:=x_min;
                WHILE x_current<=x_max DO
                    total_points:=total_points+1;
                    point:=
                    [
                    [x_current,y_current,z_scan],
                    [0,0,1,0],
                    [0,0,0,0],
                    [9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]
                    ];
                    TPWrite "[Scan] Above point#"+ValToStr(total_points)+": {x:"+ValToStr(x_current)+" y:"+ValToStr(y_current)+"}";
                    MeasurePoint(point);
                    x_current:=x_current+step_x;
                ENDWHILE
            ELSE
                 x_current:=x_max;
                WHILE x_current>=x_min DO
                    total_points:=total_points+1;
                    point:=
                    [
                    [x_current,y_current,z_scan],
                    [0,0,1,0],
                    [0,0,0,0],
                    [9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]
                    ];
                    TPWrite "[Scan] Above point#"+ValToStr(total_points)+": {x:"+ValToStr(x_current)+" y:"+ValToStr(y_current)+"}";
                    MeasurePoint(point);
                    x_current:=x_current-step_x;
                ENDWHILE
            ENDIF
            y_current:=y_current+step_y;
        ENDWHILE
        DisconnectFromLaser;
    ENDPROC

    PROC MeasurePoint(robtarget p)
        MoveL p, v300, z1, tool0\WObj:=wobj0;
        !WaitTime 0.1;
        real_pos:=CRobT(\Tool:=tool0,\WObj:=wobj0);
        elapsed_ms:=ClkRead(scan_timer)*1000;
        
        TPWrite "[Measure] time:"+ValToStr(elapsed_ms)+" ms";
        TPWrite " pos: {x:"+ValToStr(real_pos.trans.x)+" y:"+ValToStr(real_pos.trans.y)+" z:"+ValToStr(real_pos.trans.z)+"}";
        
        laser_x:=real_pos.trans.x;
        laser_y:=real_pos.trans.y;
        laser_z:=real_pos.trans.z;
        laser_t:=elapsed_ms;
        
        ExecuteMeasurementToLaser;
        
        TPWrite"Laser response:"+laser_response_out;
    ENDPROC
ENDMODULE