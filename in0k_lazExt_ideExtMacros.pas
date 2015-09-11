{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_ideExtMacros;

interface

uses
  in0k_lazExt_extIDEM_REG, lazExt_extIDEM, lazExt_extIDEM_node, 
  lazExt_extIDEM_edit, lazExt_extIDEM_prjOptionEdit, 
  lazExt_extIDEM_prjOptionEdit_node, lazExt_extIDEM_preSet_edit, 
  lazExt_extIDEM_preSet_node, lazExt_extIDEM_preSet_NDF, 
  lazExt_extIDEM_preSet_USER, lazExt_extIDEM_preSet_SUB6, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_extIDEM_REG', @in0k_lazExt_extIDEM_REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_ideExtMacros', @Register);
end.
