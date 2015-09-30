unit lazExt_extIDEM__USER_MACROS;

{$mode objfpc}{$H+}

interface

uses extIDEM_MACROS_Intf, extIDEM_coreObject,
   extIDEM_McrPRM_node,
  lazExt_extIDEM__USER_mcrPRM__TEXT,
  lazExt_extIDEM__USER_mcrPRM__FILE,

  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, StdCtrls;

type

 { tExtIDEM_USER_MACROS_edit }

 tExtIDEM_USER_MACROS_edit=class(TExtIDEM_MACROS_edit_custom)
   Button1: TButton;
   ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure ComboBox1Change(Sender: TObject);
  private
    function _cmb_prmLst_get_selected_:tExtIDEM_McrPRM_node;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE); override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE); override;
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

{$R *.lfm}

function tExtIDEM_USER_MACROS_edit._cmb_prmLst_get_selected_:tExtIDEM_McrPRM_node;
begin
    result:=nil;
    if ComboBox1.ItemIndex>=0 then begin
        result:= tExtIDEM_McrPRM_node(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    end;
end;

procedure tExtIDEM_USER_MACROS_edit.ComboBox1Change(Sender: TObject);
var tmp:tExtIDEM_McrPRM_node;
begin
    tmp:=_cmb_prmLst_get_selected_;
    if Assigned(tmp) then begin
        Label1.Caption:=tmp.node_Desc;
        Button1.Enabled:=true;
    end
    else begin
        Button1.Enabled:=false;
    end;
end;

procedure tExtIDEM_USER_MACROS_edit.Settings_Read(const node:tExtIDEM_core_objNODE);
var tmp:tExtIDEM_McrPRM_node;
begin
    ComboBox1.Clear;
    if node is tExtIDEM_USER_MACROS_node then begin
        tmp:=tExtIDEM_USER_MACROS_node(node).Param_First;
        while Assigned(tmp) do begin
            ComboBox1.Items.AddObject(tmp.node_Name,tmp);


            tmp:=tExtIDEM_USER_MACROS_node(node).Param_Next(tmp);
        end;
    end;

    if ComboBox1.Items.Count>0 then begin
       ComboBox1.ItemIndex:=0;
       ComboBox1.Enabled:=true;
       Button1  .Enabled:=true;
    end
    else begin
        ComboBox1.ItemIndex:=-1;
        ComboBox1.Enabled:=false;
        Button1  .Enabled:=false;
    end;
end;

procedure tExtIDEM_USER_MACROS_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin

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

