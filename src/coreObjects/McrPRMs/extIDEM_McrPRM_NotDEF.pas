unit extIDEM_McrPRM_NotDEF;

{$mode objfpc}{$H+}

interface

uses StdCtrls,  Classes,
    Laz2_XMLCfg,Laz2_DOM, laz2_XMLWrite,
    extIDEM_coreObject, extIDEM_McrPRM_Intf;

type

 tExtIDEM_McrPRM_NotDEF_edit=class(tExtIDEM_McrPRM_edit_custom)
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
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
  public
    constructor Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); override;
  end;

implementation

{$R *.lfm}

procedure tExtIDEM_McrPRM_NotDEF_edit.Settings_Read (const node:tExtIDEM_core_objNODE);
begin
    if Assigned(node) and (node is tExtIDEM_McrPRM_NotDEF_node) then begin
        memo1.Text:=tExtIDEM_McrPRM_NotDEF_node(node)._value_;
    end
    else begin
        memo1.Text:='';
    end;
    inherited;
end;

procedure tExtIDEM_McrPRM_NotDEF_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    inherited; //< ничего не делаем
end;

//==============================================================================

constructor tExtIDEM_McrPRM_NotDEF_node.Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    inherited Create(prmNAME,EDITor);
   _value_:='';
end;

procedure tExtIDEM_McrPRM_NotDEF_node.node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin
    inherited;// тут НИЧЕГО не далем
end;

procedure tExtIDEM_McrPRM_NotDEF_node.node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
var dom_Node:TDOMNode;
  asd:TStringStream;
begin
    dom_Node:=AConfig.FindNode(Path,false);
    if Assigned(dom_Node) then begin
        asd:=TStringStream.Create('');
        WriteXML(dom_Node,asd,[]);
        asd.Position:=0;
       _value_:=asd.DataString;
        asd.Free;
    end
    else _value_:='XML node NOT FOUND:';
    inherited;
end;

//------------------------------------------------------------------------------

class function tExtIDEM_McrPRM_NotDEF_node.PUBLISED:boolean;
begin //< его НЕЛЬЗЯ публикаовать, это "аварийный" объект
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

