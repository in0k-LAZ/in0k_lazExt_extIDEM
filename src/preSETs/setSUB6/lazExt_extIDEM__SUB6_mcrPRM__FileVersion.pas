unit lazExt_extIDEM__SUB6_mcrPRM__FileVersion;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject,
     lazExt_extIDEM_frm_sub_valFILE,
     lazExt_extIDEM_frm_sub_COMMENTs,
     lazExt_extIDEM_frm_sub_RESULT,
     extIDEM_McrPRM_File_CORE,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

 TextIDEM_SUB6_mcrPRM__FileVersion_frm = class(TlazExt_extIDEM_maCRO_File_CORE_edit)
  end;

 tExtIDEM_SUB6_mcrPRM__FileVersion_itm=class(tLazExt_extIDEM_maCRO_File_CORE_node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  end;

implementation

const
  _cTXT_Obj_IDNT_='FileVersion';
  _cTXT_Obj_Name_='File Version';
  _cTXT_Obj_Desc_='Version number of the file for example, "3.10" or "5.00.RC2". This string is required.';

{$R *.lfm}

//==============================================================================

class function tExtIDEM_SUB6_mcrPRM__FileVersion_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_SUB6_mcrPRM__FileVersion_frm;
end;

class function tExtIDEM_SUB6_mcrPRM__FileVersion_itm.Obj_IDNT:string;
begin
    result:=_cTXT_Obj_IDNT_;
end;

class function tExtIDEM_SUB6_mcrPRM__FileVersion_itm.Obj_Name:string;
begin
    result:=_cTXT_Obj_Name_;
end;

class function tExtIDEM_SUB6_mcrPRM__FileVersion_itm.Obj_Desc:string;
begin
    result:=_cTXT_Obj_Desc_;
end;

end.

