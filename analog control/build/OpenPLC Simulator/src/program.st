PROGRAM main
  VAR
    Speed_Setpoint : REAL;
    Analog_Output : REAL;
    start : BOOL;
    stop : BOOL;
    system_run : BOOL;
    emergency_stop : BOOL;
  END_VAR

  if stop OR emergency_stop then
      system_run:= false;
  elsif start then
      system_run:= true;
  end_if
  if emergency_stop AND not system_run then
      Analog_Output:= 0.0;
      Speed_Setpoint:= 0.0;
  else
      if Speed_Setpoint <=0.0 then
          Analog_Output:= 0.0;
      elsif Speed_Setpoint>= 100.0 then
          Analog_Output:= 10.0;
      else 
          Analog_Output:= (Speed_Setpoint/ 100.0)* 10.0;
      end_if;

  end_if
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 1);
    PROGRAM instance0 WITH task0 : main;
  END_RESOURCE
END_CONFIGURATION
