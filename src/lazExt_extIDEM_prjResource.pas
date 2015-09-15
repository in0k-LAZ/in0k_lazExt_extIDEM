unit lazExt_extIDEM_prjResource;

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

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
   Laz2_XMLCfg, //< !!! для работы ОБЯЗАТЕЛЬНО пользоваться этой библиотекой
   ProjectResourcesIntf,
   lazExt_extIDEM_preSet_node;

type

  // это список из ProjectFile
 tExtIDEM_prjResources_list=class(tLazExt_extIDEM_preSetsList_core)
  //
  end;

 tExtIDEM_prjResources=class(TAbstractProjectResource)
  protected
   _list_:tExtIDEM_prjResources_list;
    procedure _list_reInit;
  protected
    function _getConfigPATH_(const Path:string):string; virtual;
  protected
//   _used_:boolean;
//    procedure _used_set_(const value:boolean);
  public
    constructor Create; override;
  public
    function  UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    procedure WriteToProjectFile(AConfig: {Laz2_XMLCfg.TXMLConfig}TObject; Path: String); override;
    procedure ReadFromProjectFile(AConfig: {Laz2_XMLCfg.TXMLConfig}TObject; Path: String); override;
  public
//    property used:boolean read _used_ write _used_set_;
  end;

implementation

constructor tExtIDEM_prjResources.Create;
begin
    inherited;
   _list_:=nil;
end;

//------------------------------------------------------------------------------

function tExtIDEM_prjResources.UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean;
begin
    result:=true;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        if result
        then DEBUG(self.ClassName+'.UpdateResources=true : '+MainFilename)
        else DEBUG(self.ClassName+'.UpdateResources=FALSE : '+MainFilename);
    {$endIf}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tExtIDEM_prjResources.WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
    with TXMLConfig(AConfig) do begin
       // SetDeleteValue(_getConfigPATH_(Path)+'USED', used, False);
    end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteToProjectFile  : '+Path);
    {$endIf}
end;

procedure tExtIDEM_prjResources.ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
    with TXMLConfig(AConfig) do begin
       // used:=GetValue(_getConfigPATH_(Path)+'USED', False);
    end;
    //---
   _list_reInit; //< мы юудем его ПЕРЕЗАГРУЖАТЬ полностью
    //---
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadFromProjectFile : '+Path);
    {$endIf}
end;

//------------------------------------------------------------------------------

function tExtIDEM_prjResources._getConfigPATH_(const Path:string):string;
begin
    result:=Path+'Sub6/';
end;

//------------------------------------------------------------------------------

//procedure tExtIDEM_prjResources._used_set_(const value:boolean);
//begin
//    if _used_<>value then begin
//       _used_:=value;
//        SetModified(true);
//    end;
//end;

//------------------------------------------------------------------------------

procedure tExtIDEM_prjResources._list_reInit;
begin
   _list_.FREE;
   _list_:=tExtIDEM_prjResources_list.Create;
end;

end.

