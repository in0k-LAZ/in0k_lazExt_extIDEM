unit lazExt_extIDEM_mcrPRM_usrFILE;

{$mode objfpc}{$H+}
interface
{$I in0k_lazExt_extIDEM_INI.inc}
{$ifDef lazExt_extIDEM_DEBUG_mode}
    {$define _DEBUG_}
    {$define _TSTPRM_}
    {$define _TSTABS_}
{$else}
    {$define _INLINE_}
{$endIf}


uses lazExt_extIDEM_maCRO_File_CORE,


    lazExt_extIDEM_maCRO_node, lazExt_extIDEM_maCRO_edit, extIDEM_coreObject,
  lazExt_extIDEM_frm_sub_RESULT, lazExt_extIDEM_frm_sub_valTEXT, Classes,
  SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, EditBtn, Buttons;

type

 { TlazExt_extIDEM_mcrPRM_usrFILE_frm }

 TlazExt_extIDEM_mcrPRM_usrFILE_frm=class(TlazExt_extIDEM_maCRO_File_CORE_edit)
  end;

 TlazExt_extIDEM_mcrPRM_usrFILE_itm=class(tLazExt_extIDEM_maCRO_File_CORE_node)
  public
    class function PUBLISED:boolean; override;
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
  end;


implementation

{$R *.lfm}

//==============================================================================

class function TlazExt_extIDEM_mcrPRM_usrFILE_itm.PUBLISED:boolean;
begin
    result:=TRUE;
end;

class function TlazExt_extIDEM_mcrPRM_usrFILE_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TlazExt_extIDEM_mcrPRM_usrFILE_frm;
end;

end.

