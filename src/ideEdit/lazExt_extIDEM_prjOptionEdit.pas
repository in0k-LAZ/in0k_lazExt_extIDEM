unit lazExt_extIDEM_prjOptionEdit;

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf, {in0k_lazExt_extIDEM_REG,} lazExt_extIDEM, lazExt_extIDEM_preSet_node,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

 tLazExt_extIDEM_IDEOptions = class(TAbstractIDEOptions)
 public
   class function GetGroupCaption:string; override;
   class function GetInstance: TAbstractIDEOptions; override;
 end;


 { tLazExt_extIDEM_frmPrjOptionEdit }

 tLazExt_extIDEM_frmPrjOptionEdit = class(TAbstractIDEOptionsEditor)
    CheckBox1: TCheckBox;
    lst_preSet: TListBox;
    Panel1: TPanel;
  public
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  public
    function GetTitle:string; override;
  public
    procedure Setup(ADialog:TAbstractOptionsEditorDialog);  override;
    procedure ReadSettings(AOptions:TAbstractIDEOptions);   override;
    procedure WriteSettings(AOptions:TAbstractIDEOptions);  override;
  end;

implementation

{$R *.lfm}


class function tLazExt_extIDEM_IDEOptions.GetGroupCaption:string;
begin
    result:='extIDEM';
end;

class function tLazExt_extIDEM_IDEOptions.GetInstance:TAbstractIDEOptions;
begin
    result:=nil;//TAbstractIDEOptions(self);
end;


procedure tLazExt_extIDEM_frmPrjOptionEdit.Setup(ADialog:TAbstractOptionsEditorDialog);
var tmp:tLazExt_extIDEM_preSet_Node;
begin
    lst_preSet.Clear;
    //---
    with extIDEM do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            lst_preSet.AddItem(tmp.preSet_Name,tmp);
            //-->
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ReadSettings(AOptions:TAbstractIDEOptions);
begin

end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.WriteSettings(AOptions:TAbstractIDEOptions);
begin

end;

//==============================================================================

function tLazExt_extIDEM_frmPrjOptionEdit.GetTitle:string;
begin
    result:='extIDEM';
end;

class function tLazExt_extIDEM_frmPrjOptionEdit.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=nil;
end;

end.

