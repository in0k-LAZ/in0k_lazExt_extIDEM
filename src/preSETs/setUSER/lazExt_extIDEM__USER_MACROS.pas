unit lazExt_extIDEM__USER_MACROS;

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

uses extIDEM_MACROS_Intf, extIDEM_coreObject, Dialogs,
   extIDEM_McrPRM_node, extIDEM_MACROS_node,
  lazExt_extIDEM__USER_mcrPRM__TEXT,
  lazExt_extIDEM__USER_mcrPRM__FILE,

  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, StdCtrls;

type

 tExtIDEM_USER_MACROS_edit__doAddNewNode=procedure(const templateNode:tExtIDEM_McrPRM_node) of object;

 tExtIDEM_USER_MACROS_node=class;

 { tExtIDEM_USER_MACROS_edit }

 tExtIDEM_USER_MACROS_edit=class(TExtIDEM_MACROS_edit_custom)
    btn_ADD: TButton;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure btn_ADDClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
   _node_:tExtIDEM_USER_MACROS_node; //< это СПИОК где мы берем ШАБЛОНЫ
    procedure _node_SET_(const value:tExtIDEM_USER_MACROS_node);
  private //< сообщить наверх, чтобы вставили НОВОЕ
   _fnk_doAddNewNode_:tExtIDEM_USER_MACROS_edit__doAddNewNode;
    procedure _fnk_doAddNewNode_SET_(const value:tExtIDEM_USER_MACROS_edit__doAddNewNode);
    procedure _doAddNewNode_(const templateNode:tExtIDEM_McrPRM_node);
  private
    procedure _cmb_LST_CLEAR_;
    procedure _cmb_LST_reSet_;
    function  _cmb_LST_get_selected_:tExtIDEM_McrPRM_node;
  private
    procedure _btn_Add__reSet_;
    procedure _lbl_DSC__reSet_;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE); override;
    {$ifDef _DEBUG_}
    procedure Settings_Write(const node:tExtIDEM_core_objNODE); override;
    {$endIf}
  public
    property fDoAddNewNode:tExtIDEM_USER_MACROS_edit__doAddNewNode write _fnk_doAddNewNode_SET_;
  end;

 tExtIDEM_USER_MACROS_node=class(tExtIDEM_MACROS_node_custom)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string; override;
    class function Obj_Name:string; override;
    class function Obj_Desc:string; override;
  public
    procedure set_def_maCROs; override;
  end;

implementation
uses lazExt_extIDEM;

{$R *.lfm}

procedure tExtIDEM_USER_MACROS_edit.Settings_Read(const node:tExtIDEM_core_objNODE);
begin
    if node is tExtIDEM_USER_MACROS_node
    then _node_SET_(tExtIDEM_USER_MACROS_node(node))
    else _node_SET_(NIL);
    ComboBox1Change(ComboBox1);
end;

{$ifDef _DEBUG_}
procedure tExtIDEM_USER_MACROS_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin {DO NOFING}
    inherited;
end;
{$endIf _DEBUG_}

//------------------------------------------------------------------------------

procedure tExtIDEM_USER_MACROS_edit._node_SET_(const value:tExtIDEM_USER_MACROS_node);
begin
   _node_:=value;
    if Assigned(_node_)
    then _cmb_LST_reSet_
    else _cmb_LST_CLEAR_;
end;

{function tExtIDEM_USER_MACROS_edit._node_fndNewName_(const prmName:string; out NewName:string):boolean;
var i:integer;
begin
    result:=false;
    if Assigned(_node_) then begin
        i:=0;
        while i<1024 do begin
            NewName:=prmName+'_'+inttostr(i);
            if not Assigned(_node_.Param_FND(NewName)) then begin
                result:=true;
                Break;
            end;
            inc(i);
        end;
    end;
    ShowMessage('_node_fndNewName_:'+NewName);
end;}

//------------------------------------------------------------------------------


procedure tExtIDEM_USER_MACROS_edit._fnk_doAddNewNode_SET_(const value:tExtIDEM_USER_MACROS_edit__doAddNewNode);
begin
   _fnk_doAddNewNode_:=value;
   _btn_Add__reSet_;
   _lbl_DSC__reSet_;
end;

procedure tExtIDEM_USER_MACROS_edit._doAddNewNode_(const templateNode:tExtIDEM_McrPRM_node);
begin
    if Assigned(_fnk_doAddNewNode_) then _fnk_doAddNewNode_(templateNode);
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_USER_MACROS_edit.ComboBox1Change(Sender: TObject);
begin
   _btn_Add__reSet_;
   _lbl_DSC__reSet_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tExtIDEM_USER_MACROS_edit._cmb_LST_CLEAR_;
begin
    ComboBox1.Clear;
    //---
    ComboBox1.Enabled:=false;
    ComboBox1.ItemIndex:=-1;
    ComboBox1Change(ComboBox1);
end;

procedure tExtIDEM_USER_MACROS_edit._cmb_LST_reSet_;
var tmp:tExtIDEM_McrPRM_node;
    mrc:tLazExt_extIDEM_preSet_Node;
begin
    ComboBox1.Clear;
    mrc:=extIDEM.FIND_IDNT(_node_.node_IDNT);
    if Assigned(mrc)then begin
        tmp:=mrc.Param_First;
        while Assigned(tmp) do begin
            ComboBox1.Items.AddObject(tmp.node_Name,tmp);
            tmp:=mrc.Param_Next(tmp);
        end;
    end;
    //---
    if ComboBox1.Items.Count>0 then begin
        ComboBox1.ItemIndex:=0;
        ComboBox1.Enabled:=true;
    end
    else begin
        ComboBox1.ItemIndex:=-1;
        ComboBox1.Enabled:=false;
    end;
    ComboBox1Change(ComboBox1);
end;

function tExtIDEM_USER_MACROS_edit._cmb_LST_get_selected_:tExtIDEM_McrPRM_node;
begin
    result:=nil;
    if (0<=ComboBox1.ItemIndex)and(ComboBox1.ItemIndex<ComboBox1.Items.Count) then begin
        result:=tExtIDEM_McrPRM_node(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    end;
end;


//------------------------------------------------------------------------------

procedure tExtIDEM_USER_MACROS_edit.btn_ADDClick(Sender: TObject);
var templateNode:tExtIDEM_McrPRM_node;
begin
    if Assigned(_node_) then begin
        templateNode:=_cmb_LST_get_selected_;
        if Assigned(templateNode) then _doAddNewNode_(templateNode);
    end;
end;

procedure tExtIDEM_USER_MACROS_edit._btn_Add__reSet_;
begin
    btn_ADD.Enabled:=Assigned(_fnk_doAddNewNode_)      //< есть ЧЕМ работать
                 and Assigned(_cmb_LST_get_selected_); //< есть НАД чем работать
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_USER_MACROS_edit._lbl_DSC__reSet_;
var tmp:tExtIDEM_McrPRM_node;
begin
    tmp:=_cmb_LST_get_selected_;
    if Assigned(tmp) then begin
        Label1.Caption:=tmp.node_Name;
        Label1.Enabled:=FALSE;
    end
    else begin
        Label1.Caption:='not Selected';
        Label1.Enabled:=FALSE;
    end;
end;

//==============================================================================

procedure tExtIDEM_USER_MACROS_node.set_def_maCROs;
begin
    Param_ADD(tExtIDEM__USER_mcrPRM__TEXT_itm);
    Param_ADD(tExtIDEM__USER_mcrPRM__FILE_itm);
end;

//==============================================================================

class function tExtIDEM_USER_MACROS_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_USER_MACROS_edit;//TextIDEM_MACROS_USER_edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_USER_MACROS_node.Obj_IDNT:string;
begin
    result:='extIDEM_USR';
end;

class function tExtIDEM_USER_MACROS_node.Obj_Name:string;
begin
    result:='User sets';
end;

class function tExtIDEM_USER_MACROS_node.Obj_Desc:string;
begin
    result:='Macroses set by user.';
end;

end.

