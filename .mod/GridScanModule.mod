MODULE GridScanModule
    
    CONST num x_min:=200;
    CONST num x_max:=800;
    CONST num y_min:=-300;
    CONST num y_max:=300;
    CONST num step_x:=10;
    CONST num step_y:=10;
    CONST num z_scan:=200+125;
    
    VAR num x_current;
    VAR num y_current;
    VAR num row:=0;
    VAR num col:=0;
    VAR num total_points:=0;
    
    PROC MeasurePoinnt(robtarget p)
        !   later here i'll might . . .
        MoveL p, v100, fine, tool0\WObj:=wobj0;
        !   SetDO doLaserTrigger,1;
        !   WaitTime 0.1;
        !   SetDo doLaserTrigger,0;
    ENDPROC
    
    PROC GenerateGrid()
        total_points:=Round((x_max-x_min)/step_x+1)*Round((y_max-y_min)/step_y+1);
        TPWrite "Grid size: "+ValToStr(total_points)+" points";
    ENDPROC
    
ENDMODULE