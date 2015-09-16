unit lazExt_extIDEM_prjOptionEdit;

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf, {in0k_lazExt_extIDEM_REG,} lazExt_extIDEM, lazExt_extIDEM_preSet_node,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, lazExt_extIDEM_prjResource;

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
  private
    procedure  _lstPreSets_clear_forFREE;
    procedure  _lstPreSets_clear_forREAD;
    function   _lstPreSets_Find_IDNT(const value:string):integer;
  public
    destructor DESTROY; override;
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

{%region -----------------------------------------------------------------}

type

 tListNode=class
   _node_ide_:tLazExt_extIDEM_preSet_Node; //< что предоставляет IDE
   _node_prj_:tLazExt_extIDEM_preSet_Node; //< что записано в ПРОЕКТ
   _edit_frm_:tFrame;//tLazExt_extIDEM_preSet_frmEdit;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    class function Create_IDE(const node:tLazExt_extIDEM_preSet_Node):tListNode;
    class function Create_PRJ(const node:tLazExt_extIDEM_preSet_Node):tListNode;
  end;

//------------------------------------------------------------------------------

constructor tListNode.Create;
begin
  _node_ide_:=nil;
  _node_prj_:=nil;
  _edit_frm_:=nil;
end;

destructor tListNode.DESTROY;
begin
  _edit_frm_.FREE;
end;

//------------------------------------------------------------------------------

class function tListNode.Create_IDE(const node:tLazExt_extIDEM_preSet_Node):tListNode;
begin
    result:=tListNode.Create;
    result._node_ide_:=node;
end;

class function tListNode.Create_PRJ(const node:tLazExt_extIDEM_preSet_Node):tListNode;
begin
    result:=tListNode.Create;
    result._node_prj_:=node;
end;

{%endRegion}



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
    _lstPreSets_clear_forFREE; //< полная очистка
    with extIDEM.preSets do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            lst_preSet.AddItem(tmp.preSet_Name,tListNode.Create_IDE(tmp));
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ReadSettings(AOptions:TAbstractIDEOptions);
var tmp:tLazExt_extIDEM_preSet_Node;
  lNode:tListNode;
    idx:integer;
begin
    _lstPreSets_clear_forREAD; //< частичная очистка
    //------------
    _lstPreSets_clear_forFREE; //< полная очистка
    with ActiveProject_ExtIDEM_prjResources.preSets do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            idx:=_lstPreSets_Find_IDNT(tmp.preSet_IDNT);
            if idx>0 then begin
                lNode:=tListNode(lst_preSet.Items.Objects[idx]);
                lNode._node_prj_:=tmp;
            end
            else begin
                lNode:=tListNode.Create_PRJ(tmp);
                lst_preSet.AddItem('+'+tmp.preSet_Name,lNode);
            end;
            //--->
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.WriteSettings(AOptions:TAbstractIDEOptions);
begin

end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_clear_forFREE;
var tmp:tListNode;
    idx:integer;
begin
    for idx:=0 to lst_preSet.Items.Count-1 do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        lst_preSet.Items.Objects[idx]:=nil;
        tmp.FREE;
    end;
    lst_preSet.Clear;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_clear_forREAD;
var tmp:tListNode;
    idx:integer;
begin
    idx:=0;
    while idx<lst_preSet.Items.Count do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        if Assigned(tmp._node_ide_) then begin
            tmp._node_prj_:=nil;
            inc(idx);
        end
        else begin
            tmp.FREE;
            lst_preSet.Items.Objects[idx]:=nil;
            lst_preSet.Items.Delete(idx);
        end;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Find_IDNT(const value:string):integer;
var tmp:tListNode;
    idx:integer;
begin
    result:=-1;
    for idx:=0 to lst_preSet.Items.Count-1 do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        if tmp._node_ide_.preSet_IDNT=value then begin
            result:=idx;
            BREAK;
        end;
    end;
    lst_preSet.Clear;
end;



destructor tLazExt_extIDEM_frmPrjOptionEdit.DESTROY;
begin
    _lstPreSets_clear_forFREE;
    inherited;
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

