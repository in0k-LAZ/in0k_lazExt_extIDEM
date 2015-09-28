unit lazExt_extIDEM__SUB6_mcrPRM__InternalName;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject,
     lazExt_extIDEM_frm_sub_valFILE,
     lazExt_extIDEM_frm_sub_COMMENTs,
     lazExt_extIDEM_frm_sub_RESULT,
     extIDEM_McrPRM_File_CORE,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

 TextIDEM_SUB6_mcrPRM__InternalName_frm = class(TlazExt_extIDEM_maCRO_File_CORE_edit)
  end;

 tExtIDEM_SUB6_mcrPRM__InternalName_itm=class(tLazExt_extIDEM_maCRO_File_CORE_node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  end;

implementation

const
  _cTXT_Obj_IDNT_='InternalName';
  _cTXT_Obj_Name_='Internal Name';
  _cTXT_Obj_Desc_='Internal name of the file, if one exists for example, a module name if the file is a dynamic-link library. If the file has no internal name, this string should be the original filename, without extension. This string is required.';

{$R *.lfm}

//==============================================================================

class function tExtIDEM_SUB6_mcrPRM__InternalName_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_SUB6_mcrPRM__InternalName_frm;
end;

class function tExtIDEM_SUB6_mcrPRM__InternalName_itm.Obj_IDNT:string;
begin
    result:=_cTXT_Obj_IDNT_;
end;

class function tExtIDEM_SUB6_mcrPRM__InternalName_itm.Obj_Name:string;
begin
    result:=_cTXT_Obj_Name_;
end;

class function tExtIDEM_SUB6_mcrPRM__InternalName_itm.Obj_Desc:string;
begin
    result:=_cTXT_Obj_Desc_;
end;

end.

