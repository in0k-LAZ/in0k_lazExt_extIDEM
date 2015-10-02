unit in0k_lazExt_extIDEM_REG;

{$mode objfpc}{$H+}
interface
{$I in0k_lazExt_extIDEM_INI.inc}
{$ifDef lazExt_extIDEM_EventLOG_mode}
    {$define _DbgFileInUSES_}
    {$define _EventLOG_}
{$endIf}
{$ifDef lazExt_extIDEM_DEBUG_mode}
    {$define _DbgFileInUSES_}
    {$define _DEBUG_}
    {$define _TSTPRM_}
    {$define _TSTABS_}
{$else}
    {$define _INLINE_}
{$endIf}

uses {$ifDef _DbgFileInUSES_}ExtIDEM_DEBUG,{$endIf}
   lazExt_extIDEM,
IDEOptionsIntf,  //lazExt_extIDEM_preSet_edit,


//lazExt_extIDEM__NDF_MACROS,
lazExt_extIDEM__USER_MACROS,
lazExt_extIDEM__SUB6_MACROS,

lazExt_extIDEM_prjOptionEdit,
lazExt_extIDEM_prjResource,   ProjectResourcesIntf,
Classes, SysUtils;

procedure REGISTER;

implementation

var OptionsGroup: Integer;






procedure REGISTER;
var edt:integer;
begin
    {$ifDef _EventLOG_}
    ExtIDEM_DEBUG.RegisterInIdeLAZARUS;
    {$endIf}

    RegisterProjectResource(tExtIDEM_prjResources);
    //---
    lazExt_extIDEM_CRT;
    edt := GetFreeIDEOptionsIndex(GroupProject,ProjectOptionsMisc);//();
    RegisterIDEOptionsEditor(GroupProject, tLazExt_extIDEM_frmPrjOptionEdit, edt);
    lazExt_extIDEM_INT(GroupProject,edt);
    //---
    extIDEM.PreSETs_ADD_Node(tExtIDEM_USER_MACROS_node);
    extIDEM.PreSETs_ADD_Node(tExtIDEM_SUB6_MACROS_node);
    //extIDEM.PreSETs_ADD_Node(tExtIDEM_preSet_NDF_node);




   // lazExt_extIDEM_preSet_SUB6

 //   pg:= GetFreeIDEOptionsIndex(GroupProject,OptionsGroup);//();
//    RegisterIDEOptionsEditor(GroupProject, tLazExt_extIDEM_preSet_frmEdit, pg,OptionsGroup);
    //RegisterIDEOptionsEditor(GroupProject, tLazExt_extIDEM_frmPrjOptionEdit, 4,OptionsGroup);




  ///lazExt_extIDEM_prjOptionEdit


end;

end.

