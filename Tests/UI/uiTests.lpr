program uiTests;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, wndMain, lazExt_extIDEM_frm_sub_valTEXT, lazExt_extIDEM_frm_sub_RESULT,
  lazExt_extIDEM_frm_sub_COMMENTs, wndTestCORE, SetUpListTests
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TmainWnd, mainWnd);
  Application.Run;
end.

