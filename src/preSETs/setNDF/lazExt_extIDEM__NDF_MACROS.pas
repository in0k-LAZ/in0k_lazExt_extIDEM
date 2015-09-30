unit lazExt_extIDEM__NDF_MACROS;

{$mode objfpc}{$H+}

interface

uses Laz2_XMLCfg, Classes, Controls,
  extIDEM_coreObject, ExtIDEM_frm_sub_NotDEF, extIDEM_MACROS_Intf;

type

 { tExtIDEM_NDF_MACROS_edit }

 tExtIDEM_NDF_MACROS_edit=class(TExtIDEM_MACROS_edit_custom)
    sub_NotDEF: TExtIDEM_sub_NotDEF_frm;
  public
   procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
   procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
  public
    constructor Create(TheOwner:TComponent); override;
  end;

 tExtIDEM_NDF_MACROS_node=class(tExtIDEM_MACROS_node_custom)
  private
   _IDNTF_:string; //< название "неудачного" узла
   _value_:string; //< это что именно написано в *LPI файле
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function obj_IDNT:string; override;
    class function obj_Name:string; override;
    class function obj_Desc:string; override;
  public
    //class function PUBLISED:boolean; override;
    constructor Create; override;
    constructor Create(const IDENTIFICATOR:string);
    function  node_IDNT:string; override;
    function  node_Name:string; override;
  public
    procedure node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
    procedure node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
  end;



implementation

{$R *.lfm}

constructor tExtIDEM_NDF_MACROS_edit.Create(TheOwner:TComponent);
begin
    inherited;
    //---
    self      .AutoSize:=false;
    self.Align:=alClient;
    sub_NotDEF.AutoSize:=false;
    sub_NotDEF.Align:=alClient;
    sub_NotDEF.frm_Data.AutoSize:=false;
    sub_NotDEF.frm_Data.Anchors :=sub_NotDEF.frm_Data.Anchors+[akBottom];
    sub_NotDEF.Memo1.Align:=alClient;
end;

procedure tExtIDEM_NDF_MACROS_edit.Settings_Read(const node:tExtIDEM_core_objNODE);
begin
    if Assigned(node) and (node is tExtIDEM_NDF_MACROS_node) then begin
        sub_NotDEF.xmlNode_Text:=tExtIDEM_NDF_MACROS_node(node)._value_;
    end
    else begin
        sub_NotDEF.xmlNode_Text:='';
    end;
    inherited;
end;

procedure tExtIDEM_NDF_MACROS_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin {DO NOTHING}
    inherited;
end;

//==============================================================================

constructor tExtIDEM_NDF_MACROS_node.Create;
begin
    Create(self.obj_IDNT);
end;

constructor tExtIDEM_NDF_MACROS_node.Create(const IDENTIFICATOR:string);
begin
    inherited Create;
   _IDNTF_:=IDENTIFICATOR;
end;

//------------------------------------------------------------------------------

function tExtIDEM_NDF_MACROS_node.node_IDNT:string;
begin
    result:=_IDNTF_;
end;

function tExtIDEM_NDF_MACROS_node.node_Name:string;
begin
    result:=_IDNTF_;
end;


procedure tExtIDEM_NDF_MACROS_node.node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin {DO NOTHING}
    inherited;
end;

procedure tExtIDEM_NDF_MACROS_node.node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin {todo: как быть с одинаковыми именами (TXMLConfig это нет, но в XML есть),
             стоит ли заморачиваться с соствлением списков xmlУзлов и работы
             с ними, или ограничиться все в одном как счас???}
    if _value_<>'' then _value_:=_value_+LineEnding;
   _value_:=_value_+LoadNodeXML_TextSource(AConfig,Path);
    inherited;
end;

//------------------------------------------------------------------------------

{class function tExtIDEM_NDF_MACROS_node.PUBLISED:boolean;
begin // его НЕЛЬЗЯ публиковать, это "аварийный" объект
    result:=FALSE;
end;}

//------------------------------------------------------------------------------

class function tExtIDEM_NDF_MACROS_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_NDF_MACROS_edit;
end;

class function tExtIDEM_NDF_MACROS_node.Obj_IDNT:string;
begin
    result:='ndf';
end;

class function tExtIDEM_NDF_MACROS_node.Obj_Name:string;
begin
    result:='Not Define';
end;

class function tExtIDEM_NDF_MACROS_node.Obj_Desc:string;
begin
    result:='not found node type in definition';
end;


end.

