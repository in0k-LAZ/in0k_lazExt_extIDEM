unit lazExt_extIDEM_preSet_USER;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node, extIDEM_coreObject,
     lazExt_extIDEM_preSet_edit,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_preSet_USER_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
   //function GetTitle:string; override;
  end;

 tExtIDEM_preSet_USER_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string; override;
    class function Obj_Name:string; override;
    class function Obj_Desc:string; override;
  end;

implementation

{$R *.lfm}


{function tExtIDEM_preSet_USER_Edit.GetTitle:string;
begin
    result:=tExtIDEM_preSet_USER_node.Obj_Name;
end;}

//==============================================================================

class function tExtIDEM_preSet_USER_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_core_objEDIT;//TextIDEM_preSet_USER_Edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_preSet_USER_node.Obj_IDNT:string;
begin
    result:='extIDEM_USR';
end;

class function tExtIDEM_preSet_USER_node.Obj_Name:string;
begin
    result:='User sets';
end;

class function tExtIDEM_preSet_USER_node.Obj_Desc:string;
begin
    result:='Macroses set by user.';
end;



end.

