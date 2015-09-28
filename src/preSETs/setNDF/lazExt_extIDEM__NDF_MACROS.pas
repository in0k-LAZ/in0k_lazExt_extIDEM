unit lazExt_extIDEM__NDF_MACROS;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject, extIDEM_MACROS_Intf;

type

 tExtIDEM_NDF_MACROS_edit=class(TExtIDEM_MACROS_edit_custom)
  public
   // function GetTitle:string; override;
  end;

 tExtIDEM_NDF_MACROS_node=class(tExtIDEM_MACROS_node_custom)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function obj_IDNT:string; override;
    class function obj_Name:string; override;
    class function obj_Desc:string; override;
  end;



implementation

{$R *.lfm}

{function TextIDEM_NDF_MACROS_edit.GetTitle:string;
begin
    result:=tExtIDEM_NDF_MACROS_node.obj_Name;
end; }

//==============================================================================

class function tExtIDEM_NDF_MACROS_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_NDF_MACROS_edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_NDF_MACROS_node.obj_IDNT:string;
begin
    result:='extIDEM_NDF';
end;

class function tExtIDEM_NDF_MACROS_node.obj_Name:string;
begin
    result:='NOT define';
end;

class function tExtIDEM_NDF_MACROS_node.obj_Desc:string;
begin
    result:='NOT found or NOT define preSet.';
end;


end.

