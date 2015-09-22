unit lazExt_extIDEM_maCRO_Text;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_maCRO_node,lazExt_extIDEM_maCRO_edit, extIDEM_coreObject,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls;

type

 { TlazExt_extIDEM_maCRO_Text_edit }

 TlazExt_extIDEM_maCRO_Text_edit=class(tExtIDEM_core_objEDIT)
    Memo1: TMemo;

  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
  end;

 tLazExt_extIDEM_maCRO_Text_node=class(tLazExt_extIDEM_node)
  private
   _value_:string;
    procedure _value_SET_(const newValue:string);
  public
    property Value:string read _value_ write _value_SET_;
  public
    constructor Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); override;
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    //class function NodeTYPE_Name:string; override;
    //class function NodeTYPE_Desc:string; override;
  end;


implementation

{$R *.lfm}

procedure TlazExt_extIDEM_maCRO_Text_edit.Settings_Read (const node:tExtIDEM_core_objNODE);
begin
    memo1.Text:=tLazExt_extIDEM_maCRO_Text_node(node).value;
end;

procedure TlazExt_extIDEM_maCRO_Text_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    tLazExt_extIDEM_maCRO_Text_node(node).value:=memo1.Text;
end;

//==============================================================================

constructor tLazExt_extIDEM_maCRO_Text_node.Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    inherited Create(prmNAME,EDITor);
   _value_:='';
end;

class function tLazExt_extIDEM_maCRO_Text_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
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

