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


uses Classes, SysUtils, Forms, windows;

type

 tExtIDEM_core_objNODE=class;

 tExtIDEM_core_objEDIT=class(TFrame)
  private
   _ENBL_:boolean;
  protected
    procedure _ENBL_SET_(const value:boolean); virtual;
  public
    constructor Create(TheOwner:TComponent); override;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE); virtual;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE); virtual;
  public
    property NodeEnabled:boolean read _ENBL_ write _ENBL_SET_;
  end;
 tExtIDEM_core_objEditTYPE=class of tExtIDEM_core_objEDIT;

 tExtIDEM_core_objNODE=class
  private
   _CHNG_:boolean; //< было изменено
   _ENBL_:boolean; //< активно или нет
    procedure _CHNG_SET_(const value:boolean);
  protected
    procedure _isChange_;
    procedure _ENBL_SET_(const value:boolean); virtual;
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
  public
    property Changed:boolean read _CHNG_;
    property Enabled:boolean read _ENBL_ write _ENBL_SET_;
  public
    constructor Create; virtual;
  end;

implementation

{$R *.lfm}

constructor tExtIDEM_core_objEDIT.Create(TheOwner:TComponent);
var GUID:TGUID;
begin
    inherited;
    {todo: фигня ... думать как делать по нормальному}
    //if CreateGUID(GUID)=0 then self.Name:=GUIDToString(GUID)+self.Name;
    self.Name:=self.Name+inttostr(GetTickCount64);
   _ENBL_:=FALSE;
end;

//------------------------------------------------------------------------------

// ЧИТАТЬ настройки в визуальные компаненты
procedure tExtIDEM_core_objEDIT.Settings_Read(const node:tExtIDEM_core_objNODE);
begin // доРеализовывать в потомках
   _ENBL_:=node.Enabled;
end;

// СОХРАНЯТЬ настройки из визуальных компанент
procedure tExtIDEM_core_objEDIT.Settings_Write(const node:tExtIDEM_core_objNODE);
begin // доРеализовывать в потомках
    //node.Enabled:=_ENBL_;
end;

//------------------------------------------------------------------------------

procedure  tExtIDEM_core_objEDIT._ENBL_SET_(const value:boolean);
begin
   _ENBL_:=value;
end;

//==============================================================================

constructor tExtIDEM_core_objNODE.Create;
begin
    inherited;
   _CHNG_:=FALSE;
   _ENBL_:=FALSE;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_core_objNODE._CHNG_SET_(const value:boolean);
begin
   _CHNG_:=value;
end;

procedure tExtIDEM_core_objNODE._isChange_;
begin
   _CHNG_SET_(TRUE);
end;

procedure tExtIDEM_core_objNODE._ENBL_SET_(const value:boolean);
begin
    if _ENBL_<>value then begin
       _ENBL_:=value;
       _isChange_;
    end;
end;

//------------------------------------------------------------------------------

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

