unit in0k_lazExt_extIDEM_REG;

{$mode objfpc}{$H+}

interface

uses    lazExt_extIDEM,
IDEOptionsIntf,  lazExt_extIDEM_Group_edit,
lazExt_extIDEM_prjOptionEdit,
  Classes, SysUtils;

procedure REGISTER;

implementation

var OptionsGroup: Integer;





procedure REGISTER;
var edt:integer;
begin
    //---
    edt := GetFreeIDEOptionsIndex(GroupProject,ProjectOptionsMisc);//();
    RegisterIDEOptionsEditor(GroupProject, tLazExt_extIDEM_frmPrjOptionEdit, edt);
    lazExt_extIDEM_INIT(GroupProject,edt);

 //   pg:= GetFreeIDEOptionsIndex(GroupProject,OptionsGroup);//();
//    RegisterIDEOptionsEditor(GroupProject, tLazExt_extIDEM_preSet_frmEdit, pg,OptionsGroup);
    //RegisterIDEOptionsEditor(GroupProject, tLazExt_extIDEM_frmPrjOptionEdit, 4,OptionsGroup);




  ///lazExt_extIDEM_prjOptionEdit


end;

end.

