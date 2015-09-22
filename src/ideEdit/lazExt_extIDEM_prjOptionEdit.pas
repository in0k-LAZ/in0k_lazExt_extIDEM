unit lazExt_extIDEM_prjOptionEdit;

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf, lazExt_extIDEM,    Graphics,

lazExt_extIDEM_maCRO_node, extIDEM_coreObject,
lazExt_extIDEM_preSet_node, Classes,
  SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls,
  lazExt_extIDEM_prjResource, types;

type

 tLazExt_extIDEM_IDEOptions = class(TAbstractIDEOptions)
 public
   class function GetGroupCaption:string; override;
   class function GetInstance: TAbstractIDEOptions; override;
 end;


 { tLazExt_extIDEM_frmPrjOptionEdit }

 tLazExt_extIDEM_frmPrjOptionEdit = class(TAbstractIDEOptionsEditor)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    procedure lst_preSetDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lst_preSetDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lst_preSetSelectionChange(Sender: TObject; User: boolean);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView1Deletion(Sender: TObject; Node: TTreeNode);
 private
   _nodeFrame_:TFrame;
    procedure _rePlace_setFRM_(const FRM:tFrame);
    function  _rePlace_getFRM_(const ITM:tLazExt_extIDEM_preSet_Node):tFrame;
    procedure _rePlace_setITM_(const ITM:tLazExt_extIDEM_preSet_Node);

 private //< управление текстовкой
    procedure _labels_macroNames_INITFNT;
    procedure _labels_macroNames_setText(const preSetName,macroName:string);
    procedure _labels_macroNames_setUsed(const value:boolean);
    procedure _labels_macroNames_setDELT(const value:boolean);
 private
    procedure _rePlace_TreeNODE_Labels_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_(const treeNode:TTreeNode);

 private
    function  _treePreSets_node_is_PreSET(const treeNode:TTreeNode):boolean;
    function  _treePreSets_node_is_MACRO (const treeNode:TTreeNode):boolean;
    function  _treePreSets_node_get_IDENT(const treeNode:TTreeNode):string;

 private
    procedure  _treePreSets_clear_not_IDE;
    procedure  _treePreSets_clear_forFREE;

    procedure  _treePreSets_setUp_ide_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
    procedure  _treePreSets_setUp_ide_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);

    procedure  _treePreSets_setUp_prj_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
    procedure  _treePreSets_setUp_prj_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);

    function   _treePreSets_find_preSET_(const idnt:string):TTreeNode;
    function   _treePreSets_find_ideMCR_(const prnt:TTreeNode; const idnt:string):TTreeNode;
{ private
    procedure  _lstPreSets_clear_forFREE;
    procedure  _lstPreSets_clear_forREAD;
    function   _lstPreSets_Find_IDNT(const value:string):integer;
    function   _lstPreSets_Item_Frame_(const value:integer):tFrame;
    procedure  _lstPreSets_Show_Item_(const value:integer);}
  public
    constructor Create(AOwner: TComponent); override;
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

 tNodeDATA=class
  strict private
   _node_ide_:tExtIDEM_core_objNODE; //< что предоставляет IDE
   _node_prj_:tExtIDEM_core_objNODE; //< что записано в ПРОЕКТ
   _edit_frm_:tExtIDEM_core_objEDIT; //< tLazExt_extIDEM_preSet_frmEdit;
    procedure _node_prj_set_(const value:tExtIDEM_core_objNODE);
    function  _node_getACTV_:tExtIDEM_core_objNODE; inline;
    //-------
    function  _node_is_MacroITM_:boolean;
    function  _node_is_MacroPRM_:boolean;
    //-------
    function  _node_get_EDIT(const aOwner:TComponent):tExtIDEM_core_objEDIT;
    function  _node_get_IDNT:string;
    function  _node_get_NAME:string;
    function  _node_get_DESC:string;
    function  _node_get_ENBL:boolean;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    class function Create_IDE(const node:tExtIDEM_core_objNODE):tNodeDATA;
    class function Create_PRJ(const node:tExtIDEM_core_objNODE):tNodeDATA;
  public
    procedure Node_PRJ_clean;
    procedure Node_PRJ_SET(const value:tExtIDEM_core_objNODE);
  public
    function IDE_based:boolean;
    function PRJ_based:boolean;
    function IS_Macros:boolean;
    function IS_McrPRM:boolean;
  public
    property Node_IDE:tExtIDEM_core_objNODE read _node_ide_;
    property Node_PRJ:tExtIDEM_core_objNODE read _node_prj_;
    property NodeIDNT:string  read _node_get_IDNT;
    property NodeNAME:string  read _node_get_NAME;
    property NodeDESC:string  read _node_get_DESC;
    property NodeENBL:boolean read _node_get_ENBL;

    //property EDITOR  :tFrame read _edit_frm_ ;
  end;

//------------------------------------------------------------------------------

constructor tNodeDATA.Create;
begin
  _node_ide_:=nil;
  _node_prj_:=nil;
  _edit_frm_:=nil;
end;

destructor tNodeDATA.DESTROY;
begin
  _edit_frm_.FREE;
end;

//------------------------------------------------------------------------------

class function tNodeDATA.Create_IDE(const node:tExtIDEM_core_objNODE):tNodeDATA;
begin
    result:=tNodeDATA.Create;
    result._node_ide_:=node;
end;

class function tNodeDATA.Create_PRJ(const node:tExtIDEM_core_objNODE):tNodeDATA;
begin
    result:=tNodeDATA.Create;
    result._node_prj_:=node;
end;

//------------------------------------------------------------------------------

function tNodeDATA.IDE_based:boolean;
begin
    result:=Assigned(_node_ide_);
end;

function tNodeDATA.PRJ_based:boolean;
begin
    result:=not IDE_based;
end;

//------------------------------------------------------------------------------

function tNodeDATA.IS_Macros:boolean;
begin
    result:=_node_is_MacroITM_;//   Assigned(_node_ACTIVE_) and (_node_ACTIVE_ is tLazExt_extIDEM_preSet_Node);
end;

function tNodeDATA.IS_McrPRM:boolean;
begin
    result:=_node_is_MacroPRM_;//    result:=Assigned(_node_ACTIVE_) and (_node_ACTIVE_ is tLazExt_extIDEM_node);
end;

//------------------------------------------------------------------------------

function tNodeDATA._node_get_EDIT(const aOwner:TComponent):tExtIDEM_core_objEDIT;
var tmp:tExtIDEM_core_objNODE;
begin
    result:=_edit_frm_;
    if (not Assigned(result))and(Assigned(_node_getACTV_)) then begin //< тут все сложнее
        result:=_node_getACTV_.nodeTEdit.Create(aOwner);
    end;
end;

function tNodeDATA._node_get_IDNT:string;
begin
    result:='nil';
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.node_IDNT;
    end;
end;

function tNodeDATA._node_get_NAME:string;
begin
    result:='';
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.node_Name;
    end;
end;

function tNodeDATA._node_get_DESC:string;
begin
    result:='';
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.node_Desc;
    end;
end;

function tNodeDATA._node_get_ENBL:boolean;
begin
    if IDE_based then begin
        result:=Assigned(_node_prj_);
        {todo: добавить проверку _node_prj_.Enable}
    end
    else result:=false;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA._node_prj_set_(const value:tExtIDEM_core_objNODE);
begin
   _node_prj_:=value;
end;

//------------------------------------------------------------------------------

// получить указатель на ТЕКУЩИЙ активный объект
function tNodeDATA._node_getACTV_:tExtIDEM_core_objNODE;
begin
    result:=_node_prj_;
    if not Assigned(result) then result:=_node_ide_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tNodeDATA._node_is_MacroITM_:boolean;
begin
    result:=false;
   { if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_ is tLazExt_extIDEM_preSet_Node;

        _node_getACTV_.ClassParent;


    end;  }

    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.InheritsFrom(tLazExt_extIDEM_preSet_Node);
    end;
end;

function tNodeDATA._node_is_MacroPRM_:boolean;
begin
    result:=false;
    if Assigned(_node_getACTV_) then begin
        // result:=_node_getACTV_ is tLazExt_extIDEM_node;
        result:=_node_getACTV_.InheritsFrom(tLazExt_extIDEM_node);
    end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.Node_PRJ_clean;
begin
   _node_prj_set_(nil);
end;

procedure tNodeDATA.Node_prj_SET(const value:tExtIDEM_core_objNODE);
begin
   _node_prj_set_(value);
end;

{%endRegion}


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


//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_ide_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
var tmp:tLazExt_extIDEM_node;
begin
    with preSet do begin
        tmp:=Param_First;
        while Assigned(tmp) do begin
            TreeView1.Items.AddChildObject(treeNode,tmp.node_IDNT,tNodeDATA.Create_IDE(tmp));
            tmp:=Param_Next(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_ide_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);
var tmp:tLazExt_extIDEM_preSet_Node;
    itm:TTreeNode;
begin
    with preSETsList do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            itm:=TreeView1.Items.AddChildObject(nil,tmp.node_Name,tNodeDATA.Create_IDE(tmp));
           _treePreSets_setUp_ide_ideMCRs_(itm,tmp);
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_prj_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
var tmp:tLazExt_extIDEM_node;
  lNode:TTreeNode;
begin
    with preSet do begin
        tmp:=Param_First;
        while Assigned(tmp) do begin
            lNode:=_treePreSets_find_ideMCR_(treeNode,tmp.node_IDNT);
            if Assigned(lNode) and Assigned(lNode.Data) then begin
                tNodeDATA(lNode.Data).Node_PRJ_SET(tmp);
            end
            else begin
                TreeView1.Items.AddChildObject(treeNode,tmp.node_IDNT,tNodeDATA.Create_PRJ(tmp));
            end;
            //--->
            tmp:=Param_Next(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_prj_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);
var tmp:tLazExt_extIDEM_preSet_Node;
  lNode:TTreeNode;
begin
    with preSETsList do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            lNode:=_treePreSets_find_preSET_(tmp.node_IDNT);
            if Assigned(lNode) and Assigned(lNode.Data) then begin
                tNodeDATA(lNode.Data).Node_PRJ_SET(tmp);
            end
            else begin
                lNode:=TreeView1.Items.AddChildObject(nil,tmp.node_Name,tNodeDATA.Create_PRJ(tmp));
            end;
            //---
           _treePreSets_setUp_prj_ideMCRs_(lNode,tmp);
            //--->
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
   _treePreSets_clear_forFREE;  //< полная очистка
   _treePreSets_setUp_ide_preSETs_(extIDEM.preSets);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ReadSettings(AOptions:TAbstractIDEOptions);
begin
   _treePreSets_clear_not_IDE; //< чистим от зависимостей проекта
    //------------
    if Assigned(ActiveProject_ExtIDEM_prjResources) and
       Assigned(ActiveProject_ExtIDEM_prjResources.preSets)
    then begin
      _treePreSets_setUp_prj_preSETs_(ActiveProject_ExtIDEM_prjResources.preSets);
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.WriteSettings(AOptions:TAbstractIDEOptions);
begin

end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetDrawItem(
  Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin

end;


procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_setFRM_(const FRM:tFrame);
begin
    if FRM<>_nodeFrame_ then begin
        // готовим новый
        if Assigned(FRM) then begin
            FRM.Parent:=Panel3;
            FRM.Align:=alClient;
            FRM.SendToBack;
            FRM.Show;
        end;
        // убираем старый
        if Assigned(_nodeFrame_) then _nodeFrame_.Hide;
        // запомнили новый
       _nodeFrame_:=FRM;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._rePlace_getFRM_(const ITM:tLazExt_extIDEM_preSet_Node):tFrame;
begin
    result:=nil;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_setITM_(const ITM:tLazExt_extIDEM_preSet_Node);
begin
end;



//------------------------------------------------------------------------------

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_is_PreSET(const treeNode:TTreeNode):boolean;
begin
    result:=Assigned(treeNode) and Assigned(treeNode.Data);
    if result then with tNodeDATA(treeNode.Data) do begin
        if not(Assigned(Node_IDE) or Assigned(Node_PRJ)) then result:=FALSE
        else begin
            if tNodeDATA(treeNode.Data).PRJ_based
            then result:=tNodeDATA(treeNode.Data).Node_PRJ is tLazExt_extIDEM_preSet_Node
            else result:=tNodeDATA(treeNode.Data).Node_IDE is tLazExt_extIDEM_preSet_Node;
        end;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_is_MACRO(const treeNode:TTreeNode):boolean;
begin
    result:=Assigned(treeNode) and Assigned(treeNode.Data);
    if result then with tNodeDATA(treeNode.Data) do begin
        if not(Assigned(Node_IDE) or Assigned(Node_PRJ)) then result:=FALSE
        else begin
            if tNodeDATA(treeNode.Data).PRJ_based
            then result:=tNodeDATA(treeNode.Data).Node_PRJ is tLazExt_extIDEM_node
            else result:=tNodeDATA(treeNode.Data).Node_IDE is tLazExt_extIDEM_node;
        end;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_get_IDENT(const treeNode:TTreeNode):string;
begin
    result:='ndf';
    if _treePreSets_node_is_PreSET(treeNode)
    then
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_clear_not_IDE;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    //TreeView1.BeginUpdate;
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        node:=Enumerator.Current;
        while Assigned(node) do begin
            data:=tNodeDATA(node.Data);
            if Assigned(data) and (data.IDE_based) then begin
//                data.Node_PRJ_clean;
                if not Enumerator.MoveNext then break;
            end
            else begin
                node.Delete;
            end;
            try node:=Enumerator.Current; except BREAK; end;
        end;
    end;
    Enumerator.FREE;
    //TreeView1.EndUpdate;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_clear_forFREE;
begin
    TreeView1.Items.Clear;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_find_preSet_(const idnt:string):TTreeNode;
var data:tNodeDATA;
begin
    result:=TreeView1.Items.GetFirstNode;
    while Assigned(result) do begin
        data:=tNodeDATA(result.Data);
        if Assigned(data) and data.IDE_based then begin
            if tLazExt_extIDEM_preSet_Node(data.Node_IDE).node_IDNT=idnt
            then break
        end;
        result:=result.GetNextSibling;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_find_ideMCR_(const prnt:TTreeNode; const idnt:string):TTreeNode;
var data:tNodeDATA;
begin
    result:=prnt.GetFirstChild;
    while Assigned(result) do begin
        data:=tNodeDATA(result.Data);
        if Assigned(data) and data.IDE_based then begin
            if tLazExt_extIDEM_node(data.Node_IDE).Node_IDNT=idnt
            then break
        end;
        result:=result.GetNextSibling;
    end;
end;


//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetSelectionChange(Sender:TObject; User:boolean);
begin
   //_lstPreSets_Show_Item_(TListBox(Sender).ItemIndex);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Change(Sender:TObject; Node:TTreeNode);
begin
    if Assigned(node) then _rePlace_TreeNODE_(node);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
    //
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Deletion(Sender: TObject;
  Node: TTreeNode);
begin
    if Assigned(node) then begin
        if Assigned(node.Data) then begin
            tNodeDATA(node.Data).FREE;
            node.Data:=nil;
        end;
        //node.free;
    end;
end;

{procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_clear_forFREE;
var tmp:tListNode;
    idx:integer;
begin
    for idx:=0 to lst_preSet.Items.Count-1 do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        lst_preSet.Items.Objects[idx]:=nil;
        tmp.FREE;
    end;
    lst_preSet.Clear;
end;}

{procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_clear_forREAD;
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
end;}

{function tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Find_IDNT(const value:string):integer;
var tmp:tListNode;
    idx:integer;
begin
    result:=-1;
    for idx:=0 to lst_preSet.Items.Count-1 do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        if tmp._node_ide_.Obj_IDNT=value then begin
            result:=idx;
            BREAK;
        end;
    end;
end; }

{function tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Item_Frame_(const value:integer):tFrame;
var tmp:tListNode;
begin
    result:=nil;
    tmp:=tListNode(lst_preSet.Items.Objects[value]);
    if Assigned(tmp) then begin
        result:=tmp._edit_frm_;
        if not Assigned(result) then begin
            if Assigned(tmp._node_ide_)and Assigned(tmp._node_ide_.def_frmEdtr)
            then result:=tmp._node_ide_.def_frmEdtr.Create(SELF)
           else
            if Assigned(tmp._node_prj_)and Assigned(tmp._node_prj_.def_frmEdtr)
            then result:=tmp._node_prj_.def_frmEdtr.Create(SELF);
            //
            tmp._edit_frm_:=result;
        end;
    end;
end;}

{procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Show_Item_(const value:integer);
var tmp:tListNode;
begin
    if (0<=value) then begin
      // _rePlace_setFRM_(_lstPreSets_Item_Frame_(idx));
        //---
     //   tmp:=tListNode(lst_preSet.Items.Objects[value]);
     //   label1.Caption:='';
     //   if Assigned(tmp._node_ide_) then label1.Caption:=label1.Caption+'+' else label1.Caption:=label1.Caption+'-';
     //   if Assigned(tmp._node_prj_) then label1.Caption:=label1.Caption+'+' else label1.Caption:=label1.Caption+'-';


    end
    else begin
       _rePlace_setFRM_(nil);
    end;
end;}


//------------------------------------------------------------------------------

constructor tLazExt_extIDEM_frmPrjOptionEdit.Create(AOwner: TComponent);
begin
    Inherited;
   _labels_macroNames_INITFNT;
end;

destructor tLazExt_extIDEM_frmPrjOptionEdit.DESTROY;
begin
   _treePreSets_clear_forFREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_Labels_(const treeNode:TTreeNode);
var nodeData:tNodeDATA;
begin
    if not (Assigned(treeNode) and Assigned(treeNode.Data)) then begin
        label1.Caption:='Not Default';
        Label7.Caption:='Not Default';
       _labels_macroNames_setText('','');
       _labels_macroNames_setUsed(false);
       _labels_macroNames_setDELT(true);
    end
    else begin
        nodeData:=tNodeDATA(treeNode.Data);
        label1.Caption:=nodeData.NodeNAME;
        label7.Caption:=nodeData.NodeDESC;
        //--
        if nodeData.IS_Macros then begin
           _labels_macroNames_setText(nodeData.NodeIDNT,'');
           _labels_macroNames_setUsed(nodeData.NodeENBL);
            //_labels_macroNames_setDELT(nodeData.NodeENBL);
        end
       else
        if nodeData.IS_McrPRM then begin
            if Assigned(treeNode.Parent) and Assigned(treeNode.Parent.Data)
            then _labels_macroNames_setText(tNodeDATA(treeNode.Parent.Data).NodeIDNT,nodeData.NodeIDNT)
            else _labels_macroNames_setText('',nodeData.NodeIDNT);
           _labels_macroNames_setUsed(nodeData.NodeENBL);
            //_labels_macroNames_setDELT(true);
        end
       else begin
           _labels_macroNames_setText('nfd','nfd');
           _labels_macroNames_setUsed(false);
           _labels_macroNames_setDELT(true);
        end;
    end;
end;

// отображение соответстующего фрейма
procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_(const treeNode:TTreeNode);
begin
   _rePlace_TreeNODE_Labels_(treeNode)
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._labels_macroNames_INITFNT;
begin
    with label2 do begin
        Font.Style:=[fsBold];
    end;
    with label4 do begin
        Font.Style:=[];
    end;
    with label6 do begin
        Font.Style:=[];
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._labels_macroNames_setText(const preSetName,macroName:string);
begin
    with label3 do begin
        if preSetName='' then Caption:='xxx' else Caption:=preSetName;
        if macroName='' then Font.Style:=[fsBold] else Font.Style:=[];
    end;
    with label5 do begin
        if macroName='' then Font.Style:=[] else Font.Style:=[fsBold];
        if macroName='' then Caption:='xxx' else Caption:=macroName;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._labels_macroNames_setUsed(const value:boolean);
begin
    if value then begin
        with label2.Font do Color:=clHotLight;
        with label3.Font do Color:=clDefault;
        with label4.Font do Color:=clHotLight;
        with label5.Font do Color:=clDefault;
        with label6.Font do Color:=clHotLight;
    end
    else begin
        with label2.Font do Color:=clGrayText;
        with label3.Font do Color:=clGrayText;
        with label4.Font do Color:=clGrayText;
        with label5.Font do Color:=clGrayText;
        with label6.Font do Color:=clGrayText;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._labels_macroNames_setDELT(const value:boolean);
begin
    if value then begin
        with label2.Font do Style:=Style+[fsStrikeOut];
        with label3.Font do Style:=Style+[fsStrikeOut];
        with label4.Font do Style:=Style+[fsStrikeOut];
        with label5.Font do Style:=Style+[fsStrikeOut];
        with label6.Font do Style:=Style+[fsStrikeOut];
    end
    else begin
        with label2.Font do Style:=Style-[fsStrikeOut];
        with label3.Font do Style:=Style-[fsStrikeOut];
        with label4.Font do Style:=Style-[fsStrikeOut];
        with label5.Font do Style:=Style-[fsStrikeOut];
        with label6.Font do Style:=Style-[fsStrikeOut];
    end;
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

