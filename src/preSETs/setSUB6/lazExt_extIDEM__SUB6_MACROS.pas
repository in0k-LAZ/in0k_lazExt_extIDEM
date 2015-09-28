unit lazExt_extIDEM__SUB6_MACROS;

{$mode objfpc}{$H+}

interface

uses StdCtrls,
     //--------
     lazExt_extIDEM__SUB6_mcrPRM__Comments,
     lazExt_extIDEM__SUB6_mcrPRM__CompanyName,
     lazExt_extIDEM__SUB6_mcrPRM__FileDescription,
     lazExt_extIDEM__SUB6_mcrPRM__FileVersion,
     lazExt_extIDEM__SUB6_mcrPRM__InternalName,
     lazExt_extIDEM__SUB6_mcrPRM__LegalCopyright,
     lazExt_extIDEM__SUB6_mcrPRM__LegalTrademarks,
     lazExt_extIDEM__SUB6_mcrPRM__OriginalFilename,
     //---
     lazExt_extIDEM__SUB6_mcrPRM__ProductName,
     lazExt_extIDEM__SUB6_mcrPRM__ProductVersion,
     //--------
     extIDEM_coreObject, extIDEM_MACROS_Intf;

type

 tExtIDEM_SUB6_MACROS_edit=class(TExtIDEM_MACROS_edit_custom)
  end;

 tExtIDEM_SUB6_MACROS_node=class(tExtIDEM_MACROS_node_custom)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function obj_IDNT:string; override;
    class function obj_Name:string; override;
    class function obj_Desc:string; override;
  public
    procedure set_def_maCROs; override;
  end;


implementation

{$R *.lfm}

//==============================================================================

procedure tExtIDEM_SUB6_MACROS_node.set_def_maCROs;
begin
    Param_ADD(tExtIDEM_SUB6_mcrPRM__Comments_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__CompanyName_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__FileDescription_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__FileVersion_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__InternalName_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__LegalCopyright_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__LegalTrademarks_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__OriginalFilename_itm);
    // - PrivateBuild
    Param_ADD(tExtIDEM_SUB6_mcrPRM__ProductName_itm);
    Param_ADD(tExtIDEM_SUB6_mcrPRM__ProductVersion_itm);
    // - SpecialBuild
end;

//------------------------------------------------------------------------------

class function tExtIDEM_SUB6_MACROS_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_SUB6_MACROS_edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_SUB6_MACROS_node.obj_IDNT:string;
begin
    result:='SUB6';
end;

class function tExtIDEM_SUB6_MACROS_node.obj_Name:string;
begin
    result:='System Use Block VI';
end;

class function tExtIDEM_SUB6_MACROS_node.obj_Desc:string;
begin
    result:='System Use Block "Version Info"';
end;

end.

