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


uses Classes, SysUtils, Forms, windows,Laz2_XMLCfg;

type

 tExtIDEM_core_objNODE=class;

 tExtIDEM_core_objEDIT=class(TFrame)
  strict private
   _ENBL_:boolean; //< активно или нет
   _DLTD_:boolean; //< должно ли быть УДАЛЕНО
    procedure _ENBL_SET_(const value:boolean); {$ifDef _INLINE_}inline;{$endIf}
    procedure _DLTD_SET_(const value:boolean); {$ifDef _INLINE_}inline;{$endIf}
  public
    constructor Create(TheOwner:TComponent); override;
  public
    property NodeEnabled:boolean read _ENBL_ write _ENBL_SET_;
    property NodeMustDEL:boolean read _DLTD_ write _DLTD_SET_;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE); virtual;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE); virtual;
  end;
 tExtIDEM_core_objEditTYPE=class of tExtIDEM_core_objEDIT;

 tExtIDEM_core_objNODE=class
  strict private
   _CHNG_:boolean; //< флаг "Данные ИЗМЕНИЛИСЬ"
   _ENBL_:boolean; //< активно или нет
   _DLTD_:boolean; //< должно ли быть УДАЛЕНО
    procedure _CHNG_SET_(const value:boolean);{$ifDef _INLINE_}inline;{$endIf}
    procedure _ENBL_SET_(const value:boolean);{$ifDef _INLINE_}inline;{$endIf}
    procedure _DLTD_SET_(const value:boolean);{$ifDef _INLINE_}inline;{$endIf}
  protected
    procedure  set_IsCHANGed;                 {$ifDef _INLINE_}inline;{$endIf}
  protected //< этап кофигурации
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function Obj_IDNT:string;                    virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function Obj_Name:string;                    virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function Obj_Desc:string;                    virtual; {$ifNdef _TSTABS_} abstract; {$endif}
  public    //< нормальная работа
    function  nodeTEdit:tExtIDEM_core_objEditTYPE; virtual;
    function  node_IDNT:string; virtual;
    function  node_Name:string; virtual;
    function  node_Desc:string; virtual;
  public    //<
    procedure node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); virtual;
    procedure node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); virtual;
  public
    constructor Create;
  public
    property Enabled:boolean read _ENBL_ write _ENBL_SET_; //< участвует в событиях проекта
    property Changed:boolean read _CHNG_;                  //< данные были изменены
    property MustDEL:boolean read _DLTD_ write _DLTD_SET_; //< настройки необходимо УДАЛИТЬ
  end;

implementation

{$R *.lfm}

constructor tExtIDEM_core_objEDIT.Create(TheOwner:TComponent);
begin
    inherited;
    {todo: фигня ... думать как делать по нормальному}
    self.Name:=self.Name+inttostr(GetTickCount64);
   _ENBL_:=FALSE;
end;

//------------------------------------------------------------------------------

// ЧИТАТЬ настройки в визуальные компаненты
procedure tExtIDEM_core_objEDIT.Settings_Read(const node:tExtIDEM_core_objNODE);
begin // доРеализовывать в потомках
   _ENBL_:=node.Enabled;
   _DLTD_:=node.MustDEL;
end;

// СОХРАНЯТЬ настройки из визуальных компанент
procedure tExtIDEM_core_objEDIT.Settings_Write(const node:tExtIDEM_core_objNODE);
begin // доРеализовывать в потомках
    node.Enabled:=_ENBL_;
    node.MustDEL:=_DLTD_;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_core_objEDIT._ENBL_SET_(const value:boolean);
begin
   _ENBL_:=value;
end;

procedure tExtIDEM_core_objEDIT._DLTD_SET_(const value:boolean);
begin
   _DLTD_:=value;
end;

//==============================================================================

constructor tExtIDEM_core_objNODE.Create;
begin
    inherited;
   _CHNG_:=FALSE;
   _ENBL_:=FALSE;
   _DLTD_:=FALSE;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_core_objNODE._CHNG_SET_(const value:boolean);
begin
   _CHNG_:=value;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_core_objNODE._ENBL_SET_(const value:boolean);
begin
    if _ENBL_<>value then begin
       _ENBL_:=value;
        if _ENBL_ then _DLTD_:=FALSE;
       _CHNG_SET_(TRUE);
    end;
end;

procedure tExtIDEM_core_objNODE._DLTD_SET_(const value:boolean);
begin
    if _DLTD_<>value then begin
       _DLTD_:=value;
        if _DLTD_ then _ENBL_:=FALSE;
       _CHNG_SET_(TRUE);
    end;
end;

//------------------------------------------------------------------------------

// установить флаг "Данные ИЗМЕНИЛИСЬ"
procedure tExtIDEM_core_objNODE.set_IsCHANGed;
begin
   _CHNG_SET_(TRUE);
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_core_objNODE.node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin // доРеализовывать в потомках
   _CHNG_SET_(FALSE); //< снимает отметку об изменениях
end;

procedure tExtIDEM_core_objNODE.node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin // доРеализовывать в потомках
   _CHNG_SET_(FALSE); //< снимает отметку об изменениях
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

