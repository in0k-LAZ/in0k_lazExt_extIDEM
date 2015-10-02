unit extIDEM_McrPRM_NotDEF;

{$mode objfpc}{$H+}

interface

uses StdCtrls,  Classes,
    Laz2_XMLCfg,Laz2_DOM, laz2_XMLWrite,
    extIDEM_coreObject, ExtIDEM_frm_sub_NotDEF, extIDEM_McrPRM_Intf;

type

 { tExtIDEM_McrPRM_NotDEF_edit }

 tExtIDEM_McrPRM_NotDEF_edit=class(tExtIDEM_McrPRM_edit_custom)
    sub_NotDEF: TExtIDEM_sub_NotDEF_frm;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
  end;

 tExtIDEM_McrPRM_NotDEF_node=class(tExtIDEM_McrPRM_node_custom)
  private
   _value_:string; //< это что именно написано в *LPI файле
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  public
    class function PUBLISED:boolean; override;
  public
    procedure node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
    procedure node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
  protected
    procedure SetUP; override;
  end;

implementation

{$R *.lfm}

procedure tExtIDEM_McrPRM_NotDEF_edit.Settings_Read (const node:tExtIDEM_core_objNODE);
begin
    if Assigned(node) and (node is tExtIDEM_McrPRM_NotDEF_node) then begin
        sub_NotDEF.xmlNode_Text:=tExtIDEM_McrPRM_NotDEF_node(node)._value_;
    end
    else begin
        sub_NotDEF.xmlNode_Text:='';
    end;
    inherited;
end;

procedure tExtIDEM_McrPRM_NotDEF_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin {DO NOTHING}
    inherited;
end;

//==============================================================================

procedure tExtIDEM_McrPRM_NotDEF_node.SetUP;
begin
   _value_:='';
end;

procedure tExtIDEM_McrPRM_NotDEF_node.node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin {DO NOTHING}
    inherited;
end;

procedure tExtIDEM_McrPRM_NotDEF_node.node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin {todo: как быть с одинаковыми именами (TXMLConfig это нет, но в XML есть),
             стоит ли заморачиваться с соствлением списков xmlУзлов и работы
             с ними, или ограничиться все в одном как счас???}
    if _value_<>'' then _value_:=_value_+LineEnding;
   _value_:=_value_+LoadNodeXML_TextSource(AConfig,Path);
    inherited;
end;

//------------------------------------------------------------------------------

class function tExtIDEM_McrPRM_NotDEF_node.PUBLISED:boolean;
begin // его НЕЛЬЗЯ публиковать, это "аварийный" объект
    result:=FALSE;
end;

//------------------------------------------------------------------------------

class function tExtIDEM_McrPRM_NotDEF_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_McrPRM_NotDEF_edit;
end;

class function tExtIDEM_McrPRM_NotDEF_node.Obj_IDNT:string;
begin
    result:='ndf';
end;

class function tExtIDEM_McrPRM_NotDEF_node.Obj_Name:string;
begin
    result:='Not Define';
end;

class function tExtIDEM_McrPRM_NotDEF_node.Obj_Desc:string;
begin
    result:='not found node type in definition';
end;

end.

