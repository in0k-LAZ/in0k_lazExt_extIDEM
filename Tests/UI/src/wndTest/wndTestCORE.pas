unit wndTestCORE;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type
 TTestCOREwnd = class(TForm)
  protected
   FRM:TCustomFrame;
  public
   constructor Create(const TheOwner:TComponent; const tFrm:TCustomFrameClass);
  end;

implementation

{$R *.lfm}

constructor TTestCOREwnd.Create(const TheOwner:TComponent; const tFrm:TCustomFrameClass);
begin
    frm:=nil;
    inherited Create(TheOwner);
    if Assigned(tFrm) then begin
        frm:=tFrm.Create(self);
        frm.Parent:=self;
        frm.Align:=alTop;
        frm.Show;
        //frm.BorderSpacing.;
    end;
    self.BorderSpacing.Top:=8;
end;

end.

