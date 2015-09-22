unit lazExt_extIDEM_preSet_SUB6;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,  extIDEM_coreObject,
     lazExt_extIDEM_preSet_edit,
     //---
     lazExt_extIDEM_maCRO_Text,
     lazExt_extIDEM_maCRO_TextSL,
     lazExt_extIDEM_maCRO_TextML,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_preSet_SUB6_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function obj_IDNT:string; override;
    class function obj_Name:string; override;
    class function obj_Desc:string; override;
  public
    procedure set_def_maCROs; override;
  end;

 tExtIDEM_preSet_SUB6_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
    //function GetTitle:string; override;
  end;

implementation

{$R *.lfm}

procedure tExtIDEM_preSet_SUB6_node.set_def_maCROs;
begin
    Param_ADD('asd1', tLazExt_extIDEM_maCRO_Text_node  );
    Param_ADD('asd2', tLazExt_extIDEM_maCRO_TextSL_node);
    Param_ADD('asd3', tLazExt_extIDEM_maCRO_TextML_node);
end;

//------------------------------------------------------------------------------

class function tExtIDEM_preSet_SUB6_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_preSet_SUB6_Edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_preSet_SUB6_node.obj_IDNT:string;
begin
    result:='SUB6';
end;

class function tExtIDEM_preSet_SUB6_node.obj_Name:string;
begin
    result:='System Use Block VI';
end;

class function tExtIDEM_preSet_SUB6_node.obj_Desc:string;
begin
    result:='System Use Block "Version Info"';
end;

//==============================================================================

{function tExtIDEM_preSet_SUB6_Edit.GetTitle:string;
begin
    result:=tExtIDEM_preSet_SUB6_node.obj_Name;
end; }



end.

