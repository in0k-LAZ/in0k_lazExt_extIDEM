unit SetUpListTests;

{$mode objfpc}{$H+}

interface

uses
  lazExt_extIDEM_frm_sub_valTEXT,
  lazExt_extIDEM_frm_sub_valFILE,
  lazExt_extIDEM_frm_sub_RESULT,
  lazExt_extIDEM_frm_sub_COMMENTs,
  //---
  lazExt_extIDEM_maCRO_Text_CORE,
  lazExt_extIDEM_maCRO_File_CORE,

  wndMain;

procedure SetUpListTest_DO;

implementation

procedure SetUpListTest_DO;
begin
    mainWnd.ListTest_add_Frame(TextIDEM_sub_valTEXT_frm);
    mainWnd.ListTest_add_Frame(TextIDEM_sub_valFILE_frm);
    mainWnd.ListTest_add_Frame(TextIDEM_sub_COMMENTs_frm);
    mainWnd.ListTest_add_Frame(TextIDEM_sub_RESULT_frm);
    //---
    mainWnd.ListTest_add_Frame(TlazExt_extIDEM_maCRO_Text_CORE_edit);
    mainWnd.ListTest_add_Frame(TlazExt_extIDEM_maCRO_File_CORE_edit);
end;

end.

