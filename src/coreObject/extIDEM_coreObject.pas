unit extIDEM_coreObject;

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


uses Classes, SysUtils, Forms;

type

 tExtIDEM_core_objNODE=class;

 tExtIDEM_core_objEDIT=class(TFrame)
  public
    constructor Create(TheOwner:TComponent); override;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE); virtual;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE); virtual;
  end;
 tExtIDEM_core_objEditTYPE=class of tExtIDEM_core_objEDIT;

 tExtIDEM_core_objNODE=class
  protected //< этап кофигурации
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function Obj_IDNT:string;                    virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function Obj_Name:string;                    virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function Obj_Desc:string;                    virtual; {$ifNdef _TSTABS_} abstract; {$endif}
  public    //< нормальная работа
    function nodeTEdit:tExtIDEM_core_objEditTYPE; virtual;
    function node_IDNT:string; virtual;
    function node_Name:string; virtual;
    function node_Desc:string; virtual;
  end;

implementation

{$R *.lfm}

constructor tExtIDEM_core_objEDIT.Create(TheOwner:TComponent);
var GUID:TGUID;
begin
    inherited;
    {todo: фигня ... думать как делать по нормальному}
    if CreateGUID(GUID)=0 then self.Name:=GUIDToString(GUID)+self.Name;
end;

//------------------------------------------------------------------------------

// ЧИТАТЬ настройки в визуальные компаненты
procedure tExtIDEM_core_objEDIT.Settings_Read(const node:tExtIDEM_core_objNODE);
begin
    // реализовывать в потомках
end;

// СОХРАНЯТЬ настройки из визуальных компанент
procedure tExtIDEM_core_objEDIT.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    // реализовывать в потомках
end;

//==============================================================================

{$ifDef _TSTABS_}
class function tExtIDEM_core_objNODE.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    Assert(false,self.ClassName+'.Obj_EDIT mast by OVERRIDE');
    result:=tExtIDEM_core_objEDIT;
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_core_objNODE.Obj_IDNT:string;
begin
    Assert(false,self.ClassName+'.Obj_IDNT mast by OVERRIDE');
    result:=self.ClassName;
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_core_objNODE.Obj_Name:string;
begin
    Assert(false,self.ClassName+'.Obj_Name mast by OVERRIDE');
    result:=self.ClassName;
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_core_objNODE.Obj_Desc:string;
begin
    Assert(false,self.ClassName+'.Obj_Desc mast by OVERRIDE');
    result:=self.ClassName;
end;
{$endif}

//------------------------------------------------------------------------------

function tExtIDEM_core_objNODE.nodeTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=ObjTEdit;
end;

function tExtIDEM_core_objNODE.node_IDNT:string;
begin
    result:=Obj_IDNT;
end;

function tExtIDEM_core_objNODE.node_Name:string;
begin
    result:=Obj_Name;
end;

function tExtIDEM_core_objNODE.node_Desc:string;
begin
    result:=Obj_Desc;
end;

end.

