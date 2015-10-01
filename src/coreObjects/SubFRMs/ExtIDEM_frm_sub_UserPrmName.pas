unit ExtIDEM_frm_sub_UserPrmName;

{$mode objfpc}{$H+}

interface

uses extIDEM_frm_sub, extIDEM_coreObject, extIDEM_McrPRM_node, Graphics, ComCtrls,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

 tExtIDEM_sub_UserPrmName_frm__validate=function(const Node:tTreeNode; const Data:tExtIDEM_core_objNODE):boolean of object;


 { tExtIDEM_sub_UserPrmName_frm }

 tExtIDEM_sub_UserPrmName_frm = class(tExtIDEM_sub_frm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    procedure _edt_DESC__setParent;
    function  _edt_NAME__getParent:string;
    //procedure _edt_NAME__setParent;
  private
   _validate_:tExtIDEM_sub_UserPrmName_frm__validate;
   _treeNode_:tTreeNode;
   _nodeData_:tExtIDEM_McrPRM_node;


    function _node_DESC_isParent_(const value:string):boolean;
    function _node_NAME_is_Valid_(const node:tExtIDEM_core_objNODE):boolean;
  public
    constructor Create(AOwner:TComponent); override;
  public
    //property PrmNode:tExtIDEM_core_objNODE write _node_SET_;



    //property PrmNameTest:tExtIDEM_sub_UserPrmName_frm__testNodeName write _fTestNodeName;

    procedure INIT(const Node:tTreeNode; const Data:tExtIDEM_core_objNODE; const FNK:tExtIDEM_sub_UserPrmName_frm__validate);


  end;

implementation

{$R *.lfm}

constructor tExtIDEM_sub_UserPrmName_frm.Create(AOwner:TComponent);
begin
    inherited;
   _validate_:=nil;
   _nodeData_:=nil;
   _treeNode_:=nil;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_sub_UserPrmName_frm.INIT(const Node:tTreeNode; const Data:tExtIDEM_core_objNODE; const FNK:tExtIDEM_sub_UserPrmName_frm__validate);
begin
    if Assigned(Node) and Assigned(Data) and Assigned(FNK) and (Data is tExtIDEM_McrPRM_node)
    then begin
        _validate_:=FNK;
        _treeNode_:=Node;
        _nodeData_:=tExtIDEM_McrPRM_node(Data);
         //---
         Edit1.Text:=_nodeData_.node_IDNT;
         Edit2.Text:=_nodeData_.node_Desc;
    end
    else begin
        _validate_:=nil;
        _treeNode_:=nil;
        _nodeData_:=nil;
    end;
end;

//------------------------------------------------------------------------------

function tExtIDEM_sub_UserPrmName_frm._node_DESC_isParent_(const value:string):boolean;
begin
    result:=false;
    if Assigned(_nodeData_) then begin
        result:=CompareText(value,_nodeData_.node_Desc)=0;
    end;
end;

function tExtIDEM_sub_UserPrmName_frm._node_NAME_is_Valid_(const node:tExtIDEM_core_objNODE):boolean;
begin
    result:=false;
    if Assigned(_validate_) then result:=_validate_(_treeNode_,_nodeData_);
end;

//------------------------------------------------------------------------------

{procedure tExtIDEM_sub_UserPrmName_frm._edt_NAME__setParent;
begin
    if Assigned(_node_) then Edit1.Text:=_node_.node_IDNT
    else Edit1.Text:='';
    Edit1.SelectAll;
end;}

type

 tExtIDEM_McrPRM_node_CCC=class(tExtIDEM_McrPRM_node)
  protected
   procedure node_IDNT_set(const value:string);
   function  node_Obj_IDNT:string;
  end;

function tExtIDEM_McrPRM_node_CCC.node_Obj_IDNT:string;
begin
   result:=Obj_IDNT;
end;

procedure tExtIDEM_McrPRM_node_CCC.node_IDNT_set(const value:string);
begin
   _IDNT_:=value;
end;

function tExtIDEM_sub_UserPrmName_frm._edt_NAME__getParent:string;
begin
    if Assigned(_nodeData_) then result:=tExtIDEM_McrPRM_node_CCC(_nodeData_).node_Obj_IDNT
    else result:='notDefine';
end;

procedure tExtIDEM_sub_UserPrmName_frm._edt_DESC__setParent;
begin
    if Assigned(_nodeData_) then Edit2.Text:=_nodeData_.node_Desc
    else Edit2.Text:='';
    Edit2.SelectAll;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_sub_UserPrmName_frm.Edit1Change(Sender: TObject);
var str:string;
begin
    str:=trim(tEdit(Sender).Text);
    if str='' then str:=_edt_NAME__getParent;
    //---
    if Assigned(_nodeData_) then tExtIDEM_McrPRM_node_CCC(_nodeData_).node_IDNT_set(str);
    //---
    if _node_NAME_is_Valid_(_nodeData_)
    then tEdit(Sender).Font.Color:=clDefault
    else tEdit(Sender).Font.Color:=clRed;
end;

procedure tExtIDEM_sub_UserPrmName_frm.Edit2Change(Sender: TObject);
var str:string;
begin
    str:=trim(tEdit(Sender).Text);
    //---
    if str='' then _edt_DESC__setParent;
    //---
    if _node_DESC_isParent_(tEdit(Sender).Text)
    then tEdit(Sender).Font.Color:=clGrayText
    else tEdit(Sender).Font.Color:=clDefault;
end;

//------------------------------------------------------------------------------

end.

