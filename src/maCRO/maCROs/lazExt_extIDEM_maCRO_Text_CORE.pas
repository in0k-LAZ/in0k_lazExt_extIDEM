unit lazExt_extIDEM_maCRO_Text_CORE;

{$mode objfpc}{$H+}
interface
{$I in0k_lazExt_extIDEM_INI.inc}
{$ifDef lazExt_extIDEM_DEBUG_mode}
    {$define _DEBUG_}
    {$define _TSTPRM_}
    {$define _TSTABS_}
{$else}
    {$define _INLINE_}
{$endIf}


uses lazExt_extIDEM_maCRO_node, lazExt_extIDEM_maCRO_edit, extIDEM_coreObject,
  lazExt_extIDEM_frm_sub_RESULT, lazExt_extIDEM_frm_sub_valTEXT, Classes,
  SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, EditBtn, Buttons;

type

 { TlazExt_extIDEM_maCRO_Text_CORE_edit }

 TlazExt_extIDEM_maCRO_Text_CORE_edit=class(tExtIDEM_core_objEDIT)
    sub_valTEXT: TextIDEM_sub_valTEXT_frm;
    sub_RESULT: TextIDEM_sub_RESULT_frm;
  public
    class function Value_label_TEXT:string; virtual;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
  public
    constructor Create(TheOwner:TComponent); override;
  end;

 tLazExt_extIDEM_maCRO_Text_CORE_node=class(tLazExt_extIDEM_node)
  private
   _value_:string;
    procedure _value_SET_(const newValue:string);
  public
    property Value:string read _value_ write _value_SET_;
  public
    constructor Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); override;
  public
    class function PUBLISED:boolean; override;
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  end;


implementation

{$R *.lfm}

constructor TlazExt_extIDEM_maCRO_Text_CORE_edit.Create(TheOwner:TComponent);
begin
    inherited;
    {Value_Label.Caption:=Value_label_TEXT;
    if Value_Label.Caption='' then begin
        Value_Label.Hide;
        Value_Shape.Hide;
    end;}
end;

//------------------------------------------------------------------------------

procedure TlazExt_extIDEM_maCRO_Text_CORE_edit.Settings_Read(const node:tExtIDEM_core_objNODE);
begin
    //Value_Memo.Text:=tLazExt_extIDEM_maCRO_Text_CORE_node(node).value;
end;

procedure TlazExt_extIDEM_maCRO_Text_CORE_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    //tLazExt_extIDEM_maCRO_Text_CORE_node(node).value:=Value_Memo.Text;
end;

//------------------------------------------------------------------------------

class function TlazExt_extIDEM_maCRO_Text_CORE_edit.Value_label_TEXT:string;
begin
    result:='';
    {$ifDef _DEBUG_}
        result:='Описание для редактора';
    {$endIf}
end;

//==============================================================================

constructor tLazExt_extIDEM_maCRO_Text_CORE_node.Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    inherited Create(prmNAME,EDITor);
   _value_:='';
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.PUBLISED:boolean;
begin
    result:=FALSE;
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TlazExt_extIDEM_maCRO_Text_CORE_edit;
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.Obj_IDNT:string;
begin
    result:='Text';
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.Obj_Name:string;
begin
    result:='Текстовое Значение';
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.Obj_Desc:string;
begin
    result:='Любое указанное текстовое значение.';
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_maCRO_Text_CORE_node._value_SET_(const newValue:string);
begin
    if _value_<>newValue then begin
       _value_:=newValue;
        isChanged;
    end;
end;

end.

