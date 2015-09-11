unit lazExt_extIDEM_preSet_USER;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,
     lazExt_extIDEM_preSet_edit,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_preSet_USER_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
   function GetTitle:string; override;
  end;

 tExtIDEM_preSet_USER_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function def_frmEdtr:tLazExt_extIDEM_preSet_frmEditTYPE; override;
    class function preSet_IDNT:string; override;
    class function preSet_Name:string; override;
    class function preSet_Desc:string; override;
  end;

implementation

{$R *.lfm}


function tExtIDEM_preSet_USER_Edit.GetTitle:string;
begin
    result:=tExtIDEM_preSet_USER_node.preSet_Name;
end;

//==============================================================================

class function tExtIDEM_preSet_USER_node.def_frmEdtr:tLazExt_extIDEM_preSet_frmEditTYPE;
begin
    result:=TextIDEM_preSet_USER_Edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_preSet_USER_node.preSet_IDNT:string;
begin
    result:='extIDEM_USR';
end;

class function tExtIDEM_preSet_USER_node.preSet_Name:string;
begin
    result:='User sets';
end;

class function tExtIDEM_preSet_USER_node.preSet_Desc:string;
begin
    result:='Macroses set by user.';
end;



end.

