MODULE MainModule
    PROC main()
        !testManualMove;
        TPWrite"[Main] Started";
        LiveGenerateAndScanGrid;
        TPWrite"[Main] Ended";    
        testManualMove;
    ENDPROC
ENDMODULE