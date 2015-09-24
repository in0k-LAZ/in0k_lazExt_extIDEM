unit lazExt_extIDEM__SUB6_MACROS;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,  extIDEM_coreObject,
     lazExt_extIDEM_preSet_edit,
     //---                           lazExt_extIDEM_maCRO_Text_CORE
     lazExt_extIDEM_maCRO_Text,     lazExt_extIDEM_maCRO_File_CORE,
     lazExt_extIDEM_maCRO_TextSL,   lazExt_extIDEM_maCRO_Text_CORE,
     lazExt_extIDEM_maCRO_TextML,

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

  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, StdCtrls;

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

 { tExtIDEM_preSet_SUB6_Edit }

 tExtIDEM_preSet_SUB6_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
    ToggleBox1: TToggleBox;
  public
    //function GetTitle:string; override;
  end;

implementation

{$R *.lfm}

{
Add('Comments', '');
Add('CompanyName', '');
Add('FileDescription', '');
Add('FileVersion', '');
Add('InternalName', '');
Add('LegalCopyright', '');
Add('LegalTrademarks', '');
Add('OriginalFilename', '');
// - PrivateBuild
Add('ProductName', '');
Add('ProductVersion', '');
// - SpecialBuild
}

{
VALUE "CompanyName",      VER_COMPANYNAME_STR
VALUE "FileDescription",  VER_FILEDESCRIPTION_STR
VALUE "FileVersion",      VER_FILEVERSION_STR
VALUE "InternalName",     VER_INTERNALNAME_STR
VALUE "LegalCopyright",   VER_LEGALCOPYRIGHT_STR
VALUE "LegalTrademarks1", VER_LEGALTRADEMARKS1_STR
VALUE "LegalTrademarks2", VER_LEGALTRADEMARKS2_STR
VALUE "OriginalFilename", VER_ORIGINALFILENAME_STR
VALUE "ProductName",      VER_PRODUCTNAME_STR
VALUE "ProductVersion",   VER_PRODUCTVERSION_STR

Comments	Additional information that should be displayed for diagnostic purposes.
CompanyName	Company that produced the file?for example, "Microsoft Corporation" or "Standard Microsystems Corporation, Inc." This string is required.
FileDescription	File description to be presented to users. This string may be displayed in a list box when the user is choosing files to install?for example, "Keyboard Driver for AT-Style Keyboards". This string is required.
FileVersion	Version number of the file?for example, "3.10" or "5.00.RC2". This string is required.
InternalName	Internal name of the file, if one exists?for example, a module name if the file is a dynamic-link library. If the file has no internal name, this string should be the original filename, without extension. This string is required.
LegalCopyright	Copyright notices that apply to the file. This should include the full text of all notices, legal symbols, copyright dates, and so on. This string is optional.
LegalTrademarks	Trademarks and registered trademarks that apply to the file. This should include the full text of all notices, legal symbols, trademark numbers, and so on. This string is optional.
OriginalFilename	Original name of the file, not including a path. This information enables an application to determine whether a file has been renamed by a user. The format of the name depends on the file system for which the file was created. This string is required.
PrivateBuild	Information about a private version of the file?for example, "Built by TESTER1 on \TESTBED". This string should be present only if VS_FF_PRIVATEBUILD is specified in the fileflags parameter of the root block.
ProductName	Name of the product with which the file is distributed. This string is required.
ProductVersion	Version of the product with which the file is distributed?for example, "3.10" or "5.00.RC2". This string is required.
SpecialBuild	Text that indicates how this version of the file differs from the standard version?for example, "Private build for TESTER1 solving mouse problems on M250 and M250E computers". This string should be present only if VS_FF_SPECIALBUILD is specified in the fileflags parameter of the root block.
}

procedure tExtIDEM_preSet_SUB6_node.set_def_maCROs;
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

class function tExtIDEM_preSet_SUB6_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_preSet_SUB6_Edit;
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

