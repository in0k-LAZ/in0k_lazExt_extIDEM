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
   lazExt_extIDEM_preSet_NDF,
   LazIDEIntf,
   lazExt_extIDEM_mcrPRM_NotDEF,
   lazExt_extIDEM_preSet_USER,
   lazExt_extIDEM_preSet_node,
   lazExt_extIDEM_mcrPRM_usrTEXT,
   lazExt_extIDEM_mcrPRM_usrFILE;

type

  // это список из ProjectFile
 {tExtIDEM_prjResources_list=class(tLazExt_extIDEM_preSetsList_core)
  //
  end;
 }
 tExtIDEM_prjResources=class(TAbstractProjectResource)
  protected
   _list_:tLazExt_extIDEM_preSetsList_core;
    procedure _list_reInit;
  protected
    function _getConfigPATH_(const Path:string):string; virtual;
  protected
//   _used_:boolean;
//    procedure _used_set_(const value:boolean);
  public
    constructor Create; override;

//    procedure DoAfterBuild({%H-}AResources: TAbstractProjectResources; {%H-}AReason: TCompileReason; {%H-}SaveToTestDir: boolean); virtual;
//    procedure DoBeforeBuild({%H-}AResources: TAbstractProjectResources; {%H-}AReason: TCompileReason; {%H-}SaveToTestDir: boolean); virtual;
    function UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    procedure WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;
    procedure ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;

  public
    //function  UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    //procedure WriteToProjectFile(AConfig: {Laz2_XMLCfg.TXMLConfig}TObject; Path: String); override;
    //procedure ReadFromProjectFile(AConfig: {Laz2_XMLCfg.TXMLConfig}TObject; Path: String); override;
  public
    property preSets:tLazExt_extIDEM_preSetsList_core read _list_;
//    property used:boolean read _used_ write _used_set_;
  end;


 function ActiveProject_ExtIDEM_prjResources:tExtIDEM_prjResources;

implementation


// получть ЭКЗЕМПЛЯР ресурсов 'Sub6' для текущего АКТИВНОГО проекта
function ActiveProject_ExtIDEM_prjResources:tExtIDEM_prjResources;
begin
    result:=nil;
    if Assigned(LazarusIDE) and                     //< -- такое чуство что
       Assigned(LazarusIDE.ActiveProject) and       //<    проверок слишком
       Assigned(LazarusIDE.ActiveProject.Resources) //<    много
    then begin
        with TAbstractProjectResources(LazarusIDE.ActiveProject.Resources)
        do result:=tExtIDEM_prjResources(Resource[tExtIDEM_prjResources]);
    end;
end;


constructor tExtIDEM_prjResources.Create;
begin
    inherited;
//   _list_:=nil;
   _list_reInit;
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
  // _list_.PreSETs_ADD(tExtIDEM_preSet_NDF_node.Create);

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
var i:tLazExt_extIDEM_preSet_Node;
begin
   _list_.FREE;
   _list_:=tLazExt_extIDEM_preSetsList_core.Create;
    //---
    i:=tExtIDEM_preSet_NDF_node.Create;
   _list_.PreSETs_ADD(i);

   //---
   i:=tExtIDEM_preSet_USER_node.Create;
   i.Param_ADD('Text', TlazExt_extIDEM_mcrPRM_usrTEXT_itm);
   i.Param_ADD('File', TlazExt_extIDEM_mcrPRM_usrFILE_itm);
   i.Param_ADD('asd1', tLazExt_extIDEM_maCRO_NDF_node);
   i.Param_ADD('asd2', tLazExt_extIDEM_maCRO_NDF_node);
  _list_.PreSETs_ADD(i);



end;

end.

