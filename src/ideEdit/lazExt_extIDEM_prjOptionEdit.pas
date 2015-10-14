unit lazExt_extIDEM_prjOptionEdit;

{$mode objfpc}{$H+}
interface
{$I in0k_lazExt_extIDEM_INI.inc}
{$ifDef lazExt_extIDEM_EventLOG_mode}
    {$define _DbgFileInUSES_}
    {$define _EventLOG_}
{$endIf}
{$ifDef lazExt_extIDEM_DEBUG_mode}
    {$define _DbgFileInUSES_}
    {$define _DEBUG_}
    {$define _TSTPRM_}
    {$define _TSTABS_}
{$else}
    {$define _INLINE_}
{$endIf}

uses {$ifDef _DbgFileInUSES_}ExtIDEM_DEBUG,{$endIf}
    IDEOptionsIntf,

lazExt_extIDEM,  extIDEM_McrPRM_NotDEF,
Graphics,
//lazExt_extIDEM_mcrPRM_NotDEF,

//lazExt_extIDEM__NDF_MACROS,
     Dialogs,    lazExt_extIDEM__NDF_MACROS, lazExt_extIDEM__USER_MACROS,
//lazExt_extIDEM_maCRO_node,
extIDEM_coreObject,
//lazExt_extIDEM_preSet_node,
ExtIDEM_frm_sub_UserPrmName,
Classes,                    extIDEM_MACROS_node,extIDEM_McrPRM_node, //extIDEM_MACROS_node,
  SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls,
  lazExt_extIDEM_prjResource, extIDEM_frm_nodeName, types;

type

 tLazExt_extIDEM_IDEOptions = class(TAbstractIDEOptions)
 public
   class function GetGroupCaption:string; override;
   class function GetInstance: TAbstractIDEOptions; override;
 end;


 { tLazExt_extIDEM_frmPrjOptionEdit }

 tLazExt_extIDEM_frmPrjOptionEdit = class(TAbstractIDEOptionsEditor)
   Button1: TButton;
   ui_ExtIDEM_LOGO: TLabel;
   ui_ExtIDEM_HINT: TLabel;
   ui_ExtIDEM_MustDEL: TCheckBox;
    ui_ExtIDEM_Enabled: TCheckBox;
    chb_nodeEnabled: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    frm_nodeName: TlazExt_extIDEM_nodeName_frm;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    procedure chb_nodeEnabledChange(Sender: TObject);
    procedure chb_nodeEnabledClick(Sender: TObject);
    procedure TreeView1AdvancedCustomDraw(Sender: TCustomTreeView;
      const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure ui_ExtIDEM_EnabledChange(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure lst_preSetDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lst_preSetDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lst_preSetSelectionChange(Sender: TObject; User: boolean);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView1Deletion(Sender: TObject; Node: TTreeNode);
    procedure ui_ExtIDEM_MustDELChange(Sender: TObject);

 private
   _ExtIDEM_:tExtIDEM_prjResources;
    procedure _ExtIDEM_SET_(const value:tExtIDEM_prjResources);
    procedure _ui_ExtIDEM_Enablede_eventCLR_;
    procedure _ui_ExtIDEM_Enablede_eventSET_;
 private
    function _getNameForTree_(const node:tExtIDEM_core_objNODE):string;
 private
   _frmUsrPRM_:tExtIDEM_sub_UserPrmName_frm;
    function _frmUsrPRM_GET_:tExtIDEM_sub_UserPrmName_frm;

    procedure _frmUsrPRM_SHOW_(const treeNode:tTreeNode; const nodeData:tExtIDEM_core_objNODE);
    procedure _frmUsrPRM_HIDE_;
    function  _frmUsrPRM_onTestName_(const treeNode:tTreeNode; const nodeData:tExtIDEM_core_objNODE):boolean;


 private
   _nodeTree_ :TtreeNode;
   _nodeFrame_:tExtIDEM_core_objEDIT;
    procedure _rePlace_setFRM_(const FRM:tExtIDEM_core_objEDIT);
//    function  _rePlace_getFRM_(const ITM:tLazExt_extIDEM_preSet_Node):tExtIDEM_core_objEDIT;
//    procedure _rePlace_setITM_(const ITM:tLazExt_extIDEM_preSet_Node);


    procedure _chb_nodeEnabled_eventCLR;
    procedure _chb_nodeEnabled_eventSET;


 private
    function  _MACROS_UsrSET_:tTreeNode;
    function  _MACROS_UsrSET_(out NodeDATA:pointer):tTreeNode;
    function  _MACROS_UsrSET_PRMs_findNewIDNT_(const MACROS:tExtIDEM_USER_MACROS_node; const template:string; out newIDNT:string):boolean;
    function  _MACROS_UsrSET_PRMs_unique_IDNT_(const MACROS:tExtIDEM_USER_MACROS_node; const node:tExtIDEM_McrPRM_node):boolean;
    procedure _MACROS_UsrSET_DoAddNewNode(const templateNode:tExtIDEM_McrPRM_node);
    function  _MACROS_UsrSET_validateName(const node:tExtIDEM_McrPRM_node):boolean;

 private
    procedure _rePlace_TreeNODE_enblCh_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_Labels_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_Editor_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_usrPRM_(const treeNODE:TTreeNode);
    procedure _rePlace_TreeNODE_(const treeNode:TTreeNode);

 private
    function  _treePreSets_node_is_PreSET(const treeNode:TTreeNode):boolean;
    function  _treePreSets_node_is_MACRO (const treeNode:TTreeNode):boolean;
    function  _treePreSets_node_get_IDENT(const treeNode:TTreeNode):string;

 private
    function  _treePreSets_node_get_MACROS(const treeNode:TTreeNode):TTreeNode;
 private
    procedure  _treePreSets_clear_not_IDE;
    procedure  _treePreSets_clear_forFREE;
    procedure  _treePreSets_clear_wasLoad_;

    procedure  _treePreSets_setUp_ide_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
    procedure  _treePreSets_setUp_ide_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);

    procedure  _treePreSets_setUp_prj_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
    procedure  _treePreSets_setUp_prj_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);

    function   _treePreSets_find_preSET_(const idnt:string):TTreeNode;
    function   _treePreSets_find_ideMCR_(const prnt:TTreeNode; const idnt:string):TTreeNode;
 private
    procedure  _treePreSets_Settings_Read_;
    function   _treePreSets_Settings_Write_:boolean;
 private
    function   _treePreSets_doExpand_:TTreeNode;
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
   _edit_frm_:tExtIDEM_core_objEDIT; //< редактор для объекта
    procedure _node_prj_set_(const value:tExtIDEM_core_objNODE);
    function  _node_prj_vld_:boolean; inline;
    function  _node_getACTV_:tExtIDEM_core_objNODE; inline;
    function  _edit_exist_:boolean; inline;
    //-------
    function  _node_is_MacroITM_:boolean;
    function  _node_is_MacroPRM_:boolean;
    function  _node_is_MacroNDF_:boolean;
    //-------
    function  _node_get_IDNT:string;
    function  _node_get_NAME:string;
    function  _node_get_DESC:string;
    //-------
    function  _node_get_EDIT:tExtIDEM_core_objEditTYPE;
    function  _node_get_ENBL:boolean;
    function  _node_get_DLTD:boolean;
  strict private
   _was_load_:boolean; //< данные "ЗАГРУЖЕНЫ" из объекта в `_edit_frm_`

  public
    constructor Create;
    destructor DESTROY; override;
  public
    class function Create_IDE(const node:tExtIDEM_core_objNODE):tNodeDATA;
    class function Create_PRJ(const node:tExtIDEM_core_objNODE):tNodeDATA;
  public
    property  Was_Loaded:boolean read _was_load_;
    procedure Was_Loaded_CLEAR;
  public
    function  IDE_based:boolean;
    function  PRJ_based:boolean;
    function  PRJ_exist:boolean;
    function  IS_Macros:boolean;
    function  IS_McrPRM:boolean;
    function  IS_NotDEF:boolean;
  public
    property  Node_EDT:tExtIDEM_core_objEDIT read _edit_frm_;
    property  Node_IDE:tExtIDEM_core_objNODE read _node_ide_;
    property  Node_PRJ:tExtIDEM_core_objNODE read _node_prj_;
    property  Node_ACT:tExtIDEM_core_objNODE read _node_getACTV_;
  public
    procedure Node_PRJ_clean;
    procedure Node_PRJ_SET(const value:tExtIDEM_core_objNODE);
    procedure Node_EDT_SET(const value:tExtIDEM_core_objEDIT);
  public
    property  NodeTEDT:tExtIDEM_core_objEditTYPE read _node_get_EDIT;
    property  NodeENBL:boolean read _node_get_ENBL;
    property  NodeDLTD:boolean read _node_get_DLTD;
    property  NodeIDNT:string  read _node_get_IDNT;
    property  NodeNAME:string  read _node_get_NAME;
    property  NodeDESC:string  read _node_get_DESC;
  public
    procedure EDITOR_Settings_READ;
    function  EDITOR_Settings_WRITE:boolean;
  public
    procedure COPY_toPRJ_MacroITM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core);
    procedure COPY_toPRJ_MacroPRM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core; const MacroITM:tNodeDATA);
  end;

{todo: добавить проверку `if Assigned(_node_getACTV_)` в проверку в ASSERT}

//------------------------------------------------------------------------------

function _treeNodeDATA_(const TreeNode:tTreeNode):tNodeDATA;{$ifNdef _INLINE_}inline;{$endif}
begin
    result:=nil;
    if Assigned(TreeNode) then begin
        result:=tNodeDATA(TreeNode.Data);
    end;
end;

//------------------------------------------------------------------------------

constructor tNodeDATA.Create;
begin
  _node_ide_:=nil;
  _node_prj_:=nil;
  _edit_frm_:=nil;
  _was_load_:=false;
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

function tNodeDATA.PRJ_exist:boolean;
begin
    result:=Assigned(_node_prj_);
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

function tNodeDATA.IS_NotDEF:boolean;
begin
    result:=_node_is_MacroNDF_;
end;

//------------------------------------------------------------------------------

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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tNodeDATA._node_get_EDIT:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_core_objEditTYPE(_node_getACTV_);
    if Assigned(result) then begin
        result:=tExtIDEM_core_objNODE(result).nodeTEdit;
    end;
end;

function tNodeDATA._node_get_ENBL:boolean;
begin //<  может быть тока из проекта и НЕ ndf
    result:=_node_prj_vld_;
    if result then begin
        if _edit_exist_ and _was_load_ //< есть фрейм редактор и данные загружены
        then result:=_edit_frm_.NodeEnabled //< то данные мы ДОЛЖНЫ брать из него
        else result:=_node_prj_.Enabled;    //< иначе читаем прямо из объекта
    end;
end;


function tNodeDATA._node_get_DLTD:boolean;
begin //< может быть тока из проекта и НЕ ndf
    result:=_node_prj_vld_;
    if result then begin
        if _edit_exist_ and _was_load_ //< есть фрейм редактор и данные загружены
        then result:=_edit_frm_.NodeMustDEL //< то данные мы ДОЛЖНЫ брать из него
        else result:=_node_prj_.MustDEL;    //< иначе читаем прямо из объекта
    end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA._node_prj_set_(const value:tExtIDEM_core_objNODE);
begin
   _node_prj_:=value;
end;

function tNodeDATA._node_prj_vld_:boolean;
begin //< существует и ТОЧНО определен
    result:=Assigned(_node_prj_) and
    (NOT ( (_node_prj_ is tExtIDEM_McrPRM_NotDEF_node)or(_node_prj_ is tExtIDEM_NDF_MACROS_node ) ) );
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.Was_Loaded_CLEAR;
begin
   _was_load_:=FALSE;
end;

//------------------------------------------------------------------------------

// получить указатель на ТЕКУЩИЙ активный объект
function tNodeDATA._node_getACTV_:tExtIDEM_core_objNODE;
begin
    result:=_node_prj_; //< порядок ВАЖЕН :-)
    if not Assigned(result) then result:=_node_ide_;

    if not Assigned(result)
            then ShowMessage('_node_getACTV_ ERRRRRRRRRRRRRRRRRRRR');

end;

// редактор для объекта СОЗДАН
function tNodeDATA._edit_exist_:boolean; inline;
begin
    result:=Assigned(_edit_frm_);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tNodeDATA._node_is_MacroITM_:boolean;
begin
    result:=false;
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.InheritsFrom(tLazExt_extIDEM_preSet_Node);
    end;
end;

function tNodeDATA._node_is_MacroPRM_:boolean;
begin
    result:=false;
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.InheritsFrom(tExtIDEM_McrPRM_node);
    end;
end;

function tNodeDATA._node_is_MacroNDF_:boolean;
begin
    if _node_is_MacroITM_ then begin
        result:=_node_getACTV_.InheritsFrom(tExtIDEM_NDF_MACROS_node);
    end
   else
    if _node_is_MacroPRM_ then begin
        result:=_node_getACTV_.InheritsFrom(tExtIDEM_McrPRM_NotDEF_node);
    end
   else begin
       result:=false;
   end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.Node_PRJ_clean;
begin
   _node_prj_set_(nil);
   _was_load_:=FALSE;
end;

procedure tNodeDATA.Node_prj_SET(const value:tExtIDEM_core_objNODE);
begin
   _node_prj_set_(value);
end;

procedure tNodeDATA.Node_EDT_SET(const value:tExtIDEM_core_objEDIT);
begin
   _edit_frm_:=value;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.EDITOR_Settings_READ;
var tmpNode:tExtIDEM_core_objNODE;
begin
    tmpNode:=_node_getACTV_;
    if Assigned(tmpNode) and Assigned(_edit_frm_) then begin
        if not _was_load_ then begin //< если ещё не загружено, то грузим
            if _edit_frm_ is tExtIDEM_USER_MACROS_edit then begin //< тут своя атмосфера
               _edit_frm_.Settings_Read(_node_ide_); //< ВСЕГДА из IDE
            end
            else begin
               _edit_frm_.Settings_Read(tmpNode);
            end;
           _was_load_:=TRUE;
        end;
    end
    else _was_load_:=FALSE;
end;

function tNodeDATA.EDITOR_Settings_WRITE:boolean;
begin // !!! сохранение идет ТОЛЬКО в `_node_prj_`
    result:=false;
    if Assigned(_node_prj_) and Assigned(_edit_frm_) then begin
       _edit_frm_.Settings_Write(_node_prj_);
        result:=_node_prj_.Changed;
    end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.COPY_toPRJ_MacroITM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core);
begin
    {$ifDef _DEBUG_}
    Assert(Assigned(prjMARCOSES),'ERROR: prjMARCOSES=nil');
    {$endIF}

    if ( Assigned(prjMARCOSES)  )and(not Assigned(_node_prj_)) //< вообще есть смысл
        AND
       ( Assigned(_node_ide_) and (_node_ide_ is tLazExt_extIDEM_preSet_Node) and (not self.IS_NotDEF) )
    then begin
       _node_prj_:=tLazExt_extIDEM_preSet_NodeTYPE(_node_ide_.ClassType).Create;
        prjMARCOSES.PreSETs_ADD(tLazExt_extIDEM_preSet_Node(_node_prj_));
        //tLazExt_extIDEM_preSet_Node(_node_prj_).Enabled:=TRUE;
    end;
end;


procedure tNodeDATA.COPY_toPRJ_MacroPRM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core; const MacroITM:tNodeDATA);
//var tmpNode:tLazExt_extIDEM_node;
begin
    //ShowMessage('COPY_toPRJ_MacroPRM start');
    if ( Assigned(prjMARCOSES) and Assigned(MacroITM) and (not Assigned(_node_prj_)) ) //< вообще есть смысл
    then begin
        //ShowMessage('COPY_toPRJ_MacroPRM -1');
        if ( MacroITM.IS_Macros and (not MacroITM.IS_NotDEF) and MacroITM.PRJ_exist) then begin
            //ShowMessage('COPY_toPRJ_MacroPRM -2');

            if  ( Assigned(_node_ide_) and (_node_ide_ is tExtIDEM_McrPRM_node) and (not self.IS_NotDEF) )

    then begin
        //ShowMessage('COPY_toPRJ_MacroPRM -3');
        _node_prj_:=tLazExt_extIDEM_nodeTYPE(_node_ide_.ClassType).Create(MacroITM.Node_PRJ,tExtIDEM_McrPRM_node(_node_ide_));
         // tExtIDEM_McrPRM_node(_node_prj_).Copy(tExtIDEM_McrPRM_node(_node_ide_));
        // prjMARCOSES.PreSETs_ADD(tmpNode);
        tLazExt_extIDEM_preSet_Node(MacroITM.Node_PRJ).Param_INS(tExtIDEM_McrPRM_node(_node_prj_));
        // tExtIDEM_McrPRM_node(_node_prj_).Enabled:=TRUE;
     //   ShowMessage('COPY_toPRJ_MacroPRM');
    end;


        end;

    end;
end;

{%endRegion}


{%region -----------------------------------------------------------------}

type

 tListNode=class
   _node_ide_:tLazExt_extIDEM_preSet_Node; //< что предоставляет IDE
   _node_prj_:tLazExt_extIDEM_preSet_Node; //< что записано в ПРОЕКТ
   _edit_frm_:tFrame;                      //tLazExt_extIDEM_preSet_frmEdit;
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
var tmp:tExtIDEM_McrPRM_node;
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
            itm:=TreeView1.Items.AddChildObject(nil,_getNameForTree_(tmp),tNodeDATA.Create_IDE(tmp));
            if not (tmp is tExtIDEM_USER_MACROS_node) then begin
                // детей грузим для ВСЕХ кроме tExtIDEM_USER_MACROS_node
                // особенности Алгоритма работы
               _treePreSets_setUp_ide_ideMCRs_(itm,tmp);
            end;
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;


//------------------------------------------------------------------------------

function tLazExt_extIDEM_frmPrjOptionEdit._getNameForTree_(const node:tExtIDEM_core_objNODE):string;
begin
    if not Assigned(node) then result:='is NILL'
   else
    if node is tLazExt_extIDEM_preSet_Node then begin
        {todo: сделать настройку для выбора иммени}
        result:=node.node_Name;
    end
   else
    if node is tExtIDEM_McrPRM_node then begin
        {todo: сделать настройку для выбора иммени}
        result:=node.node_IDNT;
    end
   else begin
        result:='not DEFINE';
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_prj_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
var tmp:tExtIDEM_McrPRM_node;
  lNode:TTreeNode;
begin
    with preSet do begin
        tmp:=Param_First;
        while Assigned(tmp) do begin
            lNode:=_treePreSets_find_ideMCR_(treeNode,tmp.node_IDNT);
            if (not (preSet is tExtIDEM_USER_MACROS_node))and Assigned(lNode) and Assigned(lNode.Data) then begin
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
                lNode:=TreeView1.Items.AddChildObject(nil,_getNameForTree_(tmp),tNodeDATA.Create_PRJ(tmp));
            end;
            //---
           _treePreSets_setUp_prj_ideMCRs_(lNode,tmp);
            //--->
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;


//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._ExtIDEM_SET_(const value:tExtIDEM_prjResources);
begin
   _ui_ExtIDEM_Enablede_eventCLR_;
   _ExtIDEM_:=Value;
    if Assigned(_ExtIDEM_) then begin
        //
        ui_ExtIDEM_Enabled.Enabled:= true;//_ExtIDEM_.IsExist;
        ui_ExtIDEM_Enabled.Checked:=_ExtIDEM_.Enabled;
        //
        ui_ExtIDEM_MustDEL.Checked:=_ExtIDEM_.MustDEL;
        ui_ExtIDEM_MustDEL.Enabled:=_ExtIDEM_.Present;

        //---
        //Panel//2.Enabled:=_ExtIDEM_.Enabled;
        Panel3.Enabled:=_ExtIDEM_.Enabled;
        //--- ставим "ЛОГО"
        if _ExtIDEM_.Enabled
        then ui_ExtIDEM_LOGO.Font.Color:=clDefault
        else ui_ExtIDEM_LOGO.Font.Color:=clGrayText;
        if _ExtIDEM_.MustDEL
        then ui_ExtIDEM_LOGO.Font.Style:=ui_ExtIDEM_LOGO.Font.Style+[fsStrikeOut]
        else ui_ExtIDEM_LOGO.Font.Style:=ui_ExtIDEM_LOGO.Font.Style-[fsStrikeOut];
    end
    else begin //< чз ... надо ли вообще эту ветку
        //Panel2.Enabled:=false;
        Panel3.Enabled:=false;
    end;
   _ui_ExtIDEM_Enablede_eventSET_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_extIDEM_frmPrjOptionEdit.ui_ExtIDEM_EnabledChange(Sender: TObject);
begin
    if Assigned(_ExtIDEM_) then begin
       _ExtIDEM_.Enabled:=TCheckBox(Sender).Checked;
       _ExtIDEM_SET_(_ExtIDEM_);
        TreeView1.Repaint;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ui_ExtIDEM_MustDELChange(Sender:TObject);
begin
    if Assigned(_ExtIDEM_) then begin
       _ExtIDEM_.MustDEL:=TCheckBox(Sender).Checked;
       _ExtIDEM_SET_(_ExtIDEM_);
        TreeView1.Repaint;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_extIDEM_frmPrjOptionEdit._ui_ExtIDEM_Enablede_eventCLR_;
begin
    ui_ExtIDEM_Enabled.OnChange:=nil;
    ui_ExtIDEM_MustDEL.OnChange:=nil;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._ui_ExtIDEM_Enablede_eventSET_;
begin
    ui_ExtIDEM_Enabled.OnChange:=@ui_ExtIDEM_EnabledChange;
    ui_ExtIDEM_MustDEL.OnChange:=@ui_ExtIDEM_MustDELChange;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
   _ExtIDEM_SET_(nil);
   _treePreSets_clear_forFREE;  //< полная очистка
   _treePreSets_setUp_ide_preSETs_(extIDEM.preSets);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    // чистим от прощлых зависимостей проекта
   _treePreSets_clear_not_IDE;
   _treePreSets_clear_wasLoad_;
    // добавляем зависимости ТЕКУЩЕГО
   _ExtIDEM_SET_(ActiveProject_ExtIDEM_prjResources);
    if Assigned(_ExtIDEM_) and
       Assigned(_ExtIDEM_.preSets)
    then begin
      _treePreSets_setUp_prj_preSETs_(_ExtIDEM_.preSets);
    end;
    //---
   _treePreSets_Settings_Read_;
   _treePreSets_doExpand_;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.WriteSettings(AOptions:TAbstractIDEOptions);
var l:boolean;
begin
    l:=_treePreSets_Settings_Write_;
    if Assigned(_ExtIDEM_) and L then begin
        _ExtIDEM_.Modified:=TRUE;
    end;
   _ExtIDEM_.Modified:=TRUE;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.Label2Click(Sender: TObject);
begin
    tLabel(Sender).ShowHelp;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.chb_nodeEnabledChange(Sender: TObject);
var nodeData:tNodeDATA;
begin {todo: перенести логику в отдельную проц}
    if Assigned(_nodeFrame_) then begin //< изменяем данные в самом фрейме
        if not tCheckBox(Sender).Checked then begin
            // тут все просто, надо в самом фрейме поправить
           _nodeFrame_.NodeEnabled:=FALSE;
        end
        else begin //< а вот тут сложнее, возможно придется копировать
            nodeData:=_treeNodeDATA_(_nodeTree_);
            if Assigned(nodeData) then begin
                if nodeData.PRJ_exist then _nodeFrame_.NodeEnabled:=TRUE //< все есть, тока галочку поставить
                else begin //< ну все, точно копировать
                   if Assigned(ActiveProject_ExtIDEM_prjResources) and
                      Assigned(ActiveProject_ExtIDEM_prjResources.preSets)
                   then begin //< проверили что есть куда копировать (возможно это лишне)
                        if nodeData.IS_Macros then begin
                            nodeData.COPY_toPRJ_MacroITM(_ExtIDEM_.preSets);
                           _nodeFrame_.NodeEnabled:=TRUE;
                        end
                       else
                        if (nodeData.IS_McrPRM)and
                           (Assigned(_nodeTree_.Parent))and(Assigned(_treeNodeDATA_(_nodeTree_.Parent))) //< валидность его родителя НЕОБХОДИМА
                        then begin
                            // проверим или скопируем родительский МАКРОС
                           _treeNodeDATA_(_nodeTree_.Parent).COPY_toPRJ_MacroITM(_ExtIDEM_.preSets);
                            // теперь себя копируем
                            nodeData.COPY_toPRJ_MacroPRM(ActiveProject_ExtIDEM_prjResources.preSets, tNodeDATA(_nodeTree_.Parent.Data));
                           _nodeFrame_.NodeEnabled:=TRUE;
                        end
                       else begin
                           _nodeFrame_.NodeEnabled:=FALSE;
                        end;
                        self._rePlace_TreeNODE_(_nodeTree_);
                    end;
                end;
                //end
                //else begin
                //   _nodeFrame_.NodeEnabled:=FALSE; //< отметили что неиспользуется
                //end;
            end
            else begin //< по идее это какой-то касяк
               _nodeFrame_.NodeEnabled:=FALSE; //< отметили что неиспользуется
                {$ifDef _DEBUG_}
                Assert(FALSE,self.ClassName+'.chb_nodeEnabledChange'+' ERROR: chb_nodeEnabledChange _nodeTree_=nil');
                {$endIF}
            end;
        end;
        // _nodeFrame_.NodeEnabled:=tCheckBox(Sender).Checked; //< ???
    end;
    if Assigned(_nodeTree_) then begin //< переустановим отображения
      _rePlace_TreeNODE_Labels_(_nodeTree_);
      _rePlace_TreeNODE_enblCh_(_nodeTree_);
       TreeView1.Repaint;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.chb_nodeEnabledClick(Sender: TObject);
begin
end;


procedure _paint_left_(Const aCanvas:TCanvas; const aRect:tRect; const d:integer);
var ddw,ddy:integer;
    pL,pR:TPoint;
begin
    pl.x:=aRect.Left;
    pl.y:=aRect.Top;
    pR.x:=aRect.Left;
    pR.y:=aRect.Top;
    //---
    ddw:=d;
    ddy:=d;
    while true do begin
        if aRect.Bottom<=pl.y+ddy then BREAK;
        pl.y:=pl.y+ddy; ddy:=ddy+trunc(ddy/4+d);
        if aRect.Right<pr.x+ddw then BREAK;
        pr.x:=pr.x+ddw; ddw:=ddw+trunc(ddw/4+d);
        aCanvas.Line(pl,pr);
    end;
end;


procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1AdvancedCustomDraw(
  Sender: TCustomTreeView; const ARect: TRect; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
    if Stage=cdPostPaint then begin
        if (not Assigned(_ExtIDEM_)) or
           ( _ExtIDEM_.IsExist and not _ExtIDEM_.Enabled)
        then begin
            Sender.Canvas.Pen.Color:=clForm;
           _paint_left_(Sender.Canvas,ARect,1);
        end;
        if (not Assigned(_ExtIDEM_)) or (_ExtIDEM_.MustDEL) then begin
            Sender.Canvas.Pen.Color:=clGrayText;
           _paint_left_(Sender.Canvas,ARect,2);
        end;
        if (sender.Items.Count=0) then begin
            Sender.Canvas.Pen.Color:=clRED;
           _paint_left_(Sender.Canvas,ARect,3);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1AdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var nodeData:tNodeDATA;
var Rect:tRect;
    i:integer;
var TextStyle:TTextStyle;
begin
    DefaultDraw := true;
    if Stage=cdPostPaint then begin
        nodeData:=_treeNodeDATA_(Node);
        if Assigned(nodeData) and nodeData.PRJ_exist then begin
            Rect:=Node.DisplayRect(True);
            if (_MACROS_UsrSET_=Node.Parent) and ( not _MACROS_UsrSET_validateName(tExtIDEM_McrPRM_node(nodeData.Node_ACT)))
            then begin
                // пользовательский с НЕПРАВИЛЬНЫМ названием
                Rect:=Node.DisplayRect(True);
                i:=(Rect.Bottom-Rect.Top) div 2;
                i:= Rect.Top+i+1;
                Sender.Canvas.Pen.Color:=clRed;
                Sender.Canvas.Line(Rect.Left,i,Rect.Right,i);
            end;
            //---
            if nodeData.NodeDLTD then begin
                // его хотят УДАЛИТЬ
                i:=(Rect.Bottom-Rect.Top) div 2;
                i:= Rect.Top+i-1;
                Sender.Canvas.Pen.Color:=clGrayText;
                Sender.Canvas.Line(Rect.Left,i,Rect.Right,i);
            end
            else begin
                i:=(Rect.Bottom-Rect.Top) div 4;
                Rect.Bottom:=Rect.Bottom-i;
                Rect.Top   :=Rect.Top+i;
                i:=(Rect.Bottom-Rect.Top) div 4;
                Rect.Right :=Rect.Left+i;
                Rect.Left  :=Rect.Left-i;
                //---
                if nodeData.IS_NotDEF then begin
                    // хз че за узел.. он не с нашего района!!!
                    Sender.Canvas.Pen.Color  :=clRed;
                    Sender.Canvas.Brush.Color:=self.Color;
                end
               else
                if not nodeData.NodeENBL then begin
                    Sender.Canvas.Pen.Color:=clGrayText;
                    Sender.Canvas.Brush.Color:=self.Color;
                end
               else
                {if not nodeData.NodeENBL then} begin
                    Sender.Canvas.Pen.Color:=clHighlight;
                    Sender.Canvas.Brush.Color:=self.Color;
                end;
                Sender.Canvas.Rectangle(Rect);
                //---
            end;
            //---

        end;
    end;
end;


procedure tLazExt_extIDEM_frmPrjOptionEdit._chb_nodeEnabled_eventCLR;
begin
    with chb_nodeEnabled do begin
        OnChange:=nil;
        OnClick :=nil;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._chb_nodeEnabled_eventSET;
begin
    with chb_nodeEnabled do begin
        OnChange:=@chb_nodeEnabledChange;
        OnClick :=@chb_nodeEnabledClick;
    end;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_frmPrjOptionEdit._frmUsrPRM_GET_:tExtIDEM_sub_UserPrmName_frm;
begin
    result:=_frmUsrPRM_;
    if not Assigned(result) then begin
        result:=tExtIDEM_sub_UserPrmName_frm.Create(self);
        //---
        result.Parent:=Panel3;
        result.SendToBack;
        result.Align:=alTop;
    end;
   _frmUsrPRM_:=result;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._frmUsrPRM_SHOW_(const treeNode:tTreeNode; const nodeData:tExtIDEM_core_objNODE);
begin
    with _frmUsrPRM_GET_ do begin
        INIT(treeNode,nodeData,@_frmUsrPRM_onTestName_);
        Show;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._frmUsrPRM_HIDE_;
begin
    if Assigned(_frmUsrPRM_) then begin
        _frmUsrPRM_.Hide;
        _frmUsrPRM_.Enabled:=FALSE;
        _frmUsrPRM_.INIT(nil,nil,nil);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_extIDEM_frmPrjOptionEdit._frmUsrPRM_onTestName_(const treeNode:tTreeNode; const nodeData:tExtIDEM_core_objNODE):boolean;
begin
    result:=_MACROS_UsrSET_validateName(tExtIDEM_McrPRM_node(nodeData));
    if result then begin
        frm_nodeName.setErName(False);
       _rePlace_TreeNODE_Labels_(treeNode);
    end
    else begin
       _rePlace_TreeNODE_Labels_(treeNode);
        frm_nodeName.setErName(true);
    end;
    treeNode.Text:= _getNameForTree_(nodeData);
    TreeView1.Invalidate;
    TreeView1.Repaint;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetDrawItem(
  Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin

end;


procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_setFRM_(const FRM:tExtIDEM_core_objEDIT);
begin
    if FRM<>_nodeFrame_ then begin
        // сохраняем значение для СТАРОГО
        if Assigned(_nodeFrame_) and (_nodeFrame_.InheritsFrom(tExtIDEM_core_objEDIT))
        then begin
           _nodeFrame_.NodeEnabled:=chb_nodeEnabled.Checked;
        end;
        // готовим новый
        if Assigned(FRM) then begin
            //chb_nodeEnabled.Checked:=FRM.NodeEnabled;

            if FRM is tExtIDEM_USER_MACROS_edit then begin
                tExtIDEM_USER_MACROS_edit(FRM).fDoAddNewNode:=@_MACROS_UsrSET_DoAddNewNode;
            end;

            FRM.Parent:=Panel3;
            FRM.SendToBack;
            FRM.Align:=alClient;
            FRM.Show;
        end;
        // убираем старый
        if Assigned(_nodeFrame_) then begin
           _nodeFrame_.Hide;
        end;
        // запомнили новый
       _nodeFrame_:=FRM;
    end;
end;

{function tLazExt_extIDEM_frmPrjOptionEdit._rePlace_getFRM_(const ITM:tLazExt_extIDEM_preSet_Node):tFrame;
begin
    result:=nil;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_setITM_(const ITM:tLazExt_extIDEM_preSet_Node);
begin
end;}

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
            then result:=tNodeDATA(treeNode.Data).Node_PRJ is tExtIDEM_McrPRM_node
            else result:=tNodeDATA(treeNode.Data).Node_IDE is tExtIDEM_McrPRM_node;
        end;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_get_MACROs(const treeNode:TTreeNode):tTreeNode;
var tmp:tTreeNode;
begin
    result:=nil;
    tmp:=treeNode;
    while Assigned(tmp) do begin
        if _treePreSets_node_is_PreSET(treeNode) then begin
            result:=tmp;
        end;
        //-->
        tmp:=tmp.Parent;
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
            data:=_treeNodeDATA_(Node);
            if Assigned(data) and (data.IDE_based) then begin
                data.Node_PRJ_clean;
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

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_clear_wasLoad_;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        while Assigned(node) do begin
            node:=Enumerator.Current;
            data:=_treeNodeDATA_(Node);
            if Assigned(data) then data.Was_Loaded_CLEAR;
            if not Enumerator.MoveNext then break;
        end;
    end;
    Enumerator.FREE;
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
            if tExtIDEM_McrPRM_node(data.Node_IDE).Node_IDNT=idnt
            then break
        end;
        result:=result.GetNextSibling;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_Settings_Read_;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        while Assigned(node) do begin
            node:=Enumerator.Current;
            data:=_treeNodeDATA_(Node);
            if Assigned(data) then data.EDITOR_Settings_READ;
            if not Enumerator.MoveNext then break;
        end;
    end;
    Enumerator.FREE;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_Settings_Write_:boolean;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    result:=false;
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        while Assigned(node) do begin
            node:=Enumerator.Current;
            data:=_treeNodeDATA_(Node);
            if Assigned(data) then begin
                result:=data.EDITOR_Settings_WRITE;
            end;
            if not Enumerator.MoveNext then break;
        end;
    end;
    Enumerator.FREE;
end;

//
function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_doExpand_:TTreeNode;
var tmp :tTreeNode;
    tmpP:tTreeNode;
    tmpE:tTreeNode;
nodeDATA:tNodeDATA;
begin
    result:=TreeView1.Items.GetFirstNode;
    tmp :=result;
    tmpP:=nil;
    tmpE:=nil;
    while Assigned(tmp) do begin
        nodeDATA:=_treeNodeDATA_(tmp);
        if Assigned(nodeDATA) then begin
            if nodeDATA.PRJ_exist then begin
                if not Assigned(tmpP) then tmpP:=tmp;
                tmp.Expanded:=TRUE;
            end;
            if nodeDATA.NodeENBL then begin
                if not Assigned(tmpE) then tmpE:=tmp;
            end;
        end;
        //-->
        tmp:=tmp.GetNextSibling;
    end;
    if Assigned(tmpP) then result:=tmpP;
    if Assigned(tmpE) then result:=tmpE;
    //---
    if Assigned(result) then result.Selected:=TRUE;
end;


//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetSelectionChange(Sender:TObject; User:boolean);
begin
   //_lstPreSets_Show_Item_(TListBox(Sender).ItemIndex);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Change(Sender:TObject; Node:TTreeNode);
begin
   _rePlace_TreeNODE_(node);
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
            _treeNodeDATA_(Node).FREE;
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
   _ExtIDEM_:=nil;
   _nodeFrame_:=nil;
   _frmUsrPRM_:=nil;
end;

destructor tLazExt_extIDEM_frmPrjOptionEdit.DESTROY;
begin
   _treePreSets_clear_forFREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_usrPRM_(const treeNode:TTreeNode);
var NodeDATA:tNodeDATA;
begin
    NodeDATA:=_treeNodeDATA_(treeNode);
    if Assigned(NodeDATA)and(_MACROS_UsrSET_=treeNode.Parent) then begin
       _frmUsrPRM_SHOW_(treeNode,NodeDATA.Node_PRJ);
    end
    else begin
       _frmUsrPRM_HIDE_;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_Editor_(const treeNode:TTreeNode);
var NodeDATA:tNodeDATA;
    NodeEdit:tExtIDEM_core_objEDIT;
begin
    NodeDATA:=_treeNodeDATA_(treeNode);
    if Assigned(NodeDATA) then begin
        //--- готовим фрейм
        NodeEdit:=NodeDATA.Node_EDT;
        if (not Assigned(NodeEdit))and(Assigned(NodeDATA.NodeTEDT))
        then begin
            NodeEdit:=NodeDATA.NodeTEDT.Create(SELF);
            //ShowMessage('NodeDATA.NodeTEDT.Create'+NodeEdit.ClassName);
            NodeDATA.Node_EDT_SET(NodeEdit);
        end;
        //
        if Assigned(NodeEdit) then begin
            NodeDATA.EDITOR_Settings_READ;
        end;
    end;
    //--- показываем фрейм
    if Assigned(NodeEdit) then begin
       _rePlace_setFRM_(NodeEdit);
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_enblCh_(const treeNode:TTreeNode);
var nodeData:tNodeDATA;
begin
    if Assigned(treeNode)and Assigned(_nodeFrame_) then begin
        nodeData:=tNodeDATA(treeNode.Data);
        if Assigned(nodeData)and(nodeData.IS_Macros or nodeData.IS_McrPRM) then begin
            chb_nodeEnabled.Enabled:=true;
            if nodeData.NodeENBL then begin
                if _ExtIDEM_.Enabled
                then chb_nodeEnabled.State:=cbChecked
                else chb_nodeEnabled.State:=cbGrayed;
            end
            else chb_nodeEnabled.Checked:=FALSE;
            exit;
        end;
    end;{




            if nodeData.IS_Macros or nodeData.IS_McrPRM then begin
                chb_nodeEnabled.Enabled:=true;
                if _ExtIDEM_.Enabled




            chb_nodeEnabled.Checked:=nodeData.NodeENBL;
            if nodeData.IS_Macros then begin
                chb_nodeEnabled.Enabled:=true;
                Exit;
            end
           else
            if nodeData.IS_McrPRM then begin
                if Assigned(treeNode.Parent) and Assigned(treeNode.Parent.Data)
                then begin
                    chb_nodeEnabled.Enabled:=tNodeDATA(treeNode.Parent.Data).NodeENBL;
                end
                else begin
                    chb_nodeEnabled.Enabled:=false;
                end;
                chb_nodeEnabled.Enabled:=true;
                Exit;
            end;
        end
    end;               }
    // !!! этот код сработает только если НЕ ВСТРЕТИТСЯ `exit` !!!
    chb_nodeEnabled.Enabled:=FALSE;
    chb_nodeEnabled.Checked:=FALSE;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_Labels_(const treeNode:TTreeNode);
var nodeData:tNodeDATA;
begin
    if not (Assigned(treeNode) and Assigned(treeNode.Data)) then begin
        label1.Caption:='Not Default';
        Label7.Caption:='Not Default';
        frm_nodeName.setDELETED(true);
        frm_nodeName.setUsed   (false);
        frm_nodeName.setNames  ('','');
    end
    else begin
        nodeData:=tNodeDATA(treeNode.Data);
        label1.Caption:=nodeData.NodeNAME;
        label1.Hint   :=nodeData.NodeNAME;
        Label2.Hint   :=nodeData.NodeDESC;
        //--
        if nodeData.IS_Macros then begin
           //frm_nodeName.setDELETED(true);
           frm_nodeName.setUsed   (nodeData.NodeENBL);
           frm_nodeName.setNames  (nodeData.NodeIDNT,'');
        end
       else
        if nodeData.IS_McrPRM then begin
            if Assigned(treeNode.Parent) and Assigned(treeNode.Parent.Data)
            then begin
                frm_nodeName.setNames(tNodeDATA(treeNode.Parent.Data).NodeIDNT,nodeData.NodeIDNT);
                frm_nodeName.setUsed(nodeData.NodeENBL and tNodeDATA(treeNode.Parent.Data).NodeENBL);
            end
            else begin
                frm_nodeName.setNames('',nodeData.NodeIDNT);
                frm_nodeName.setUsed(_nodeFrame_.NodeEnabled{ nodeData.NodeENBL});
            end;
        end
       else begin
           frm_nodeName.setDELETED(false);
           frm_nodeName.setUsed   (false);
           frm_nodeName.setNames  ('nfd','nfd');
        end;
    end;
end;

// отображение соответстующего фрейма
procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_(const treeNode:TTreeNode);
var nodeData:tNodeDATA;
begin
    nodeData:=_treeNodeDATA_(treeNode);
    if Assigned(treeNode) and Assigned(nodeData) then begin
       _nodeTree_:=treeNode;
       _chb_nodeEnabled_eventCLR;
        {$ifDEF _EventLOG_}
         DEBUG('_rePlace_TreeNODE_','$treeNODE:nodeDATA '+addr2txt(treeNode)+':'+addr2str(nodeData));
        {$endIf}
           _rePlace_TreeNODE_usrPRM_(treeNode);
           _rePlace_TreeNODE_Editor_(treeNode);
           _rePlace_TreeNODE_Labels_(treeNode);
           _rePlace_TreeNODE_enblCh_(treeNode);
       _chb_nodeEnabled_eventSET;
    end
    {$ifDEF _EventLOG_}
    else begin
        {todo: делать и думать}
        DEBUG('_rePlace_TreeNODE_','treeNODE:nodeDATA is Wrong'+addr2txt(treeNode)+':'+addr2txt(nodeData));
    end;
    {$endIf}
end;

//------------------------------------------------------------------------------

// найти узел дерева, который отвечает за ПОЛЬЗОВАТЕЛЬСКИЙ набор
// --- он ОБЯЗАН присутствовать, можно НЕ проверять
function tLazExt_extIDEM_frmPrjOptionEdit._MACROS_UsrSET_(out NodeDATA:pointer):tTreeNode;
begin
    NodeDATA:=nil;
    result  :=TreeView1.Items.GetFirstNode;
    while Assigned(result) do begin
        NodeDATA:=_treeNodeDATA_(result);
        if Assigned(NodeDATA) then begin
            // tmpData.Node_IDE - именно тут ДОЛЖНО лежать !!!
            if tNodeDATA(NodeDATA).Node_IDE is tExtIDEM_USER_MACROS_node
            then BREAK;
        end;
        result:=result.GetNextSibling;
    end;
    {$ifDef _DEBUG_}
    Assert(Assigned(result),'ERROR: _MACROS_UsrSET_ NOT FOUND');
    {$endIF}
end;

function tLazExt_extIDEM_frmPrjOptionEdit._MACROS_UsrSET_:tTreeNode;
var tmp:pointer;
begin
    result:=_MACROS_UsrSET_(tmp);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_extIDEM_frmPrjOptionEdit._MACROS_UsrSET_PRMs_findNewIDNT_(const MACROS:tExtIDEM_USER_MACROS_node; const template:string; out newIDNT:string):boolean;
var i:integer;
begin
    result:=false;
    i:=0;
    while (i<1024)and(not result) do begin
        newIDNT:=template+'_'+inttostr(i);
        if Assigned(MACROS) then begin
            if not Assigned(MACROS.Param_FND(newIDNT)) then begin // такого имени НЕТ ... )))
                result:=TRUE;
                break;
            end;
        end
        else begin // ага, его еще тупо НЕТ => все ок
            result:=TRUE;
            break;
        end;
        inc(i);
    end;
end;

function  tLazExt_extIDEM_frmPrjOptionEdit._MACROS_UsrSET_PRMs_unique_IDNT_(const MACROS:tExtIDEM_USER_MACROS_node; const node:tExtIDEM_McrPRM_node):boolean;
begin
    result:=false;
    if Assigned(MACROS) then begin
        result:= not Assigned(MACROS.Param_FND(node.node_IDNT,node)); // кроме нас никого?
    end
    else begin // ага, его еще тупо НЕТ => все ок
        result:=TRUE;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._MACROS_UsrSET_DoAddNewNode(const templateNode:tExtIDEM_McrPRM_node);
var TreeNode_UsrSET:tTreeNode;
    UsrSET_NodeDATA:tNodeDATA;
    //---
    newNode_obj:tExtIDEM_McrPRM_node;
    newNodeIDNT:string;
begin
    {$ifDef _EventLOG_}
    DEBUG('UI UsrSET DoAddNewNode','templateNode'+addr2txt(templateNode)+' TYPE:'+templateNode.ClassName+' IDNT:'+templateNode.node_IDNT);
    {$endIF}
    TreeNode_UsrSET:=_MACROS_UsrSET_(pointer(UsrSET_NodeDATA));
    if _MACROS_UsrSET_PRMs_findNewIDNT_(tExtIDEM_USER_MACROS_node(UsrSET_NodeDATA.Node_PRJ),templateNode.node_IDNT,newNodeIDNT)
    then begin
        if not UsrSET_NodeDATA.PRJ_exist then UsrSET_NodeDATA.COPY_toPRJ_MacroITM(_ExtIDEM_.preSets);
        // создаем новый и ДОБАВЛЯЕМ к спискам
        newNode_obj:=tLazExt_extIDEM_nodeTYPE(templateNode.ClassType).Create(UsrSET_NodeDATA.Node_PRJ,newNodeIDNT,templateNode.nodeTEdit);
        if tExtIDEM_USER_MACROS_node(UsrSET_NodeDATA.Node_PRJ).Param_INS(newNode_obj) then begin
            TreeView1.Items.AddChildObject(TreeNode_UsrSET, _getNameForTree_(newNode_obj), tNodeDATA.Create_PRJ(newNode_obj));
            TreeNode_UsrSET.Expanded:=TRUE;
        end
        else begin //< касяк неясный
            newNode_obj.FREE;
            {$ifDef _DEBUG_}
            Assert(false,Self.ClassName+'._MACROS_UsrSET_DoAddNewNode cant insert node in tExtIDEM_USER_MACROS_node');
            {$endIF}
        end;
    end
    else begin
        {todo: сделать человеческое сообщение о НЕ возможности добавить узел}
        {$ifDef _DEBUG_}
        Assert(false,Self.ClassName+'._MACROS_UsrSET_DoAddNewNode newNodeIDNT NOF FOUND');
        {$endIF}
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._MACROS_UsrSET_validateName(const node:tExtIDEM_McrPRM_node):boolean;
var TreeNode_UsrSET:tTreeNode;
    UsrSET_NodeDATA:tNodeDATA;
begin
    if Assigned(node) then begin
        {todo: проверить на валидность само имя, типа пробелы, символы и т.д.}
        //--- проверяем на УНИКАЛЬНОСТЬ имени
        TreeNode_UsrSET:=_MACROS_UsrSET_(pointer(UsrSET_NodeDATA));
        result:=_MACROS_UsrSET_PRMs_unique_IDNT_(tExtIDEM_USER_MACROS_node(UsrSET_NodeDATA.Node_PRJ),node);
    end
    else result:=FALSE;
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

