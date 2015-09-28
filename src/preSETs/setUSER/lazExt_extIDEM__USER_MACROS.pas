unit lazExt_extIDEM__USER_MACROS;

{$mode objfpc}{$H+}

interface

uses extIDEM_MACROS_Intf, extIDEM_coreObject,
  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, StdCtrls;

type

 tExtIDEM_USER_MACROS_edit=class(TExtIDEM_MACROS_edit_custom)
    Label1: TLabel;
    Label2: TLabel;
  end;

 tExtIDEM_USER_MACROS_node=class(tExtIDEM_MACROS_node_custom)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string; override;
    class function Obj_Name:string; override;
    class function Obj_Desc:string; override;
  end;

implementation

{$R *.lfm}

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

