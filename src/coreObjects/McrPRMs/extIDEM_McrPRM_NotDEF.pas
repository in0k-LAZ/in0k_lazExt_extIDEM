unit extIDEM_McrPRM_NotDEF;

{$mode objfpc}{$H+}

interface

uses StdCtrls,
    extIDEM_coreObject, extIDEM_McrPRM_Intf;

type

 tExtIDEM_McrPRM_NotDEF_edit=class(tExtIDEM_McrPRM_edit_custom)
   Label1: TLabel;
   Label2: TLabel;
   Memo1: TMemo;
  end;

 tExtIDEM_McrPRM_NotDEF_node=class(tExtIDEM_McrPRM_node_custom)
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  public
    class function PUBLISED:boolean;                   override;
  end;

implementation

{$R *.lfm}

//==============================================================================

class function tExtIDEM_McrPRM_NotDEF_node.PUBLISED:boolean;
begin //< его НЕЛЬЗЯ публикаовать, это "аварийный" объект
    result:=FALSE;
end;

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

