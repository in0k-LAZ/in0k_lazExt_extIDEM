unit lazExt_extIDEM_maCRO_Text;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_maCRO_node,lazExt_extIDEM_maCRO_edit,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls;

type

 { TlazExt_extIDEM_maCRO_Text_edit }

 TlazExt_extIDEM_maCRO_Text_edit=class(tLazExt_extIDEM_frmEdit)
    Memo1: TMemo;

  public
    procedure Settings_Read (const node:tlazExt_extIDEM_edtNode);  override;
    procedure Settings_Write(const node:tlazExt_extIDEM_edtNode);  override;
  end;

 tLazExt_extIDEM_maCRO_Text_node=class(tLazExt_extIDEM_node)
  private
   _value_:string;
    procedure _value_SET_(const newValue:string);
  public
    property Value:string read _value_ write _value_SET_;
  public
    constructor Create(const prmNAME:string; const EDITor:tLazExt_extIDEM_frmEditTYPE=nil); override;
  public
    class function defEditor    :tLazExt_extIDEM_frmEditTYPE; override;
    //class function NodeTYPE_Name:string; override;
    //class function NodeTYPE_Desc:string; override;
  end;


implementation

{$R *.lfm}

procedure TlazExt_extIDEM_maCRO_Text_edit.Settings_Read (const node:tlazExt_extIDEM_edtNode);
begin
    memo1.Text:=tLazExt_extIDEM_maCRO_Text_node(node).value;
end;

procedure TlazExt_extIDEM_maCRO_Text_edit.Settings_Write(const node:tlazExt_extIDEM_edtNode);
begin
    tLazExt_extIDEM_maCRO_Text_node(node).value:=memo1.Text;
end;

//==============================================================================

constructor tLazExt_extIDEM_maCRO_Text_node.Create(const prmNAME:string; const EDITor:tLazExt_extIDEM_frmEditTYPE=nil);
begin
    inherited Create(prmNAME,EDITor);
   _value_:='';
end;

class function tLazExt_extIDEM_maCRO_Text_node.defEditor:tLazExt_extIDEM_frmEditTYPE;
begin
    result:=TlazExt_extIDEM_maCRO_Text_edit;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_maCRO_Text_node._value_SET_(const newValue:string);
begin
    if _value_<>newValue then begin
       _value_:=newValue;
        isChange_SET;
    end;
end;

end.

