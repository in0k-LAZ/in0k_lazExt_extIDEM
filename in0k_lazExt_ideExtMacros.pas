{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_ideExtMacros;

interface

uses
  in0k_lazExt_extIDEM_REG, lazExt_extIDEM, extIDEM_McrPRM_node, 
  lazExt_extIDEM_prjOptionEdit, lazExt_extIDEM_prjOptionEdit_node, 
  extIDEM_MACROS_Intf, extIDEM_MACROS_node, lazExt_extIDEM__NDF_MACROS, 
  lazExt_extIDEM__USER_MACROS, lazExt_extIDEM__SUB6_MACROS, 
  lazExt_extIDEM_prjResource, lazExt_extIDEM_subFrm_core, 
  ExtIDEM_frm_nodeName, ExtIDEM_frm_sub, ExtIDEM_frm_sub_NotDEF, 
  ExtIDEM_frm_sub_RESULT, ExtIDEM_frm_sub_valFILE, ExtIDEM_frm_sub_valTEXT, 
  ExtIDEM_frm_sub_COMMENTs, extIDEM_McrPRM_NotDEF, extIDEM_McrPRM_File_CORE, 
  extIDEM_McrPRM_Text_CORE, lazExt_extIDEM__SUB6_mcrPRM__OriginalFilename, 
  lazExt_extIDEM__SUB6_mcrPRM__ProductVersion, 
  lazExt_extIDEM__SUB6_mcrPRM__ProductName, 
  lazExt_extIDEM__SUB6_mcrPRM__LegalTrademarks, 
  lazExt_extIDEM__SUB6_mcrPRM__LegalCopyright, 
  lazExt_extIDEM__SUB6_mcrPRM__InternalName, 
  lazExt_extIDEM__SUB6_mcrPRM__FileVersion, 
  lazExt_extIDEM__SUB6_mcrPRM__FileDescription, 
  lazExt_extIDEM__SUB6_mcrPRM__CompanyName, 
  lazExt_extIDEM__SUB6_mcrPRM__Comments, extIDEM_McrPRM_Intf, 
  lazExt_extIDEM__USER_mcrPRM__FILE, lazExt_extIDEM__USER_mcrPRM__TEXT, 
  ExtIDEM_frm_sub_UserPrmName, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_extIDEM_REG', @in0k_lazExt_extIDEM_REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_ideExtMacros', @Register);
end.
