unit lazExt_extIDEM_preSet_NDF;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node, extIDEM_coreObject,
     lazExt_extIDEM_preSet_edit,
  Classes, SysUtils, FileUtil, Forms, Controls;

type


 TextIDEM_preSet_NDF_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
   // function GetTitle:string; override;
  end;

 tExtIDEM_preSet_NDF_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function obj_IDNT:string; override;
    class function obj_Name:string; override;
    class function obj_Desc:string; override;
  end;



implementation

{$R *.lfm}

{function TextIDEM_preSet_NDF_Edit.GetTitle:string;
begin
    result:=tExtIDEM_preSet_NDF_node.obj_Name;
end; }

//==============================================================================

class function tExtIDEM_preSet_NDF_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_preSet_NDF_Edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_preSet_NDF_node.obj_IDNT:string;
begin
    result:='extIDEM_NDF';
end;

class function tExtIDEM_preSet_NDF_node.obj_Name:string;
begin
    result:='NOT define';
end;

class function tExtIDEM_preSet_NDF_node.obj_Desc:string;
begin
    result:='NOT found or NOT define preSet.';
end;


end.

