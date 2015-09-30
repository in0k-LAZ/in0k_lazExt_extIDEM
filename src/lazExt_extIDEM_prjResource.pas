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
   Laz2_XMLCfg, Laz2_DOM, //< !!! для работы ОБЯЗАТЕЛЬНО пользоваться этой библиотекой
   ProjectResourcesIntf,            Dialogs,   lazExt_extIDEM,
   extIDEM_coreObject, extIDEM_MACROS_node, extIDEM_McrPRM_node,
   extIDEM_McrPRM_NotDEF,
   lazExt_extIDEM__NDF_MACROS,
   //lazExt_extIDEM__NDF_MACROS,
   //lazExt_extIDEM_maCRO_node,
   LazIDEIntf;//,
//   lazExt_extIDEM_mcrPRM_NotDEF,
  // lazExt_extIDEM__USER_MACROS
  // lazExt_extIDEM_preSet_node,
   //lazExt_extIDEM_mcrPRM_usrTEXT,
   //lazExt_extIDEM_mcrPRM_usrFILE
   //;

type

  // это список из ProjectFile
 {tExtIDEM_prjResources_list=class(tLazExt_extIDEM_preSetsList_core)
  //
  end;
 }
 tExtIDEM_prjResources=class(TAbstractProjectResource)
  private
   _mustDel_:boolean; //< должно быть стерто
   _enabled_:boolean; //< используется этот механизм
    procedure _mustDel_set_(const value:boolean);
    procedure _enabled_set_(const value:boolean);
  protected
   _list_:tLazExt_extIDEM_preSetsList_core;
    procedure _list_clear_;
    procedure _list_reIni_;
  strict private
    function  _getConfigPATH_(const Path:string):string;{$ifDef _INLINE_}inline;{$endIf}
  strict private
    function  _MacroPRM_PATH_ (const macroPRM:tExtIDEM_McrPRM_node; const prntPath:String):string; {$ifDef _INLINE_}inline;{$endIf}
    procedure _MacroPRM_Save_ (const macroPRM:tExtIDEM_McrPRM_node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
    procedure _MacroPRM_Load_ (const macroPRM:tExtIDEM_McrPRM_node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
  strict private
    function  _MacroPRMs_PATH_(const prntPath:string):string;{$ifDef _INLINE_}inline;{$endIf}
    procedure _MacroPRMs_Save_(const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
    procedure _MacroPRMs_Load_(const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
  strict private
    function  _MacroITM_PATH_ (const macroITM:tLazExt_extIDEM_preSet_Node; const prntPath:String):string;{$ifDef _INLINE_}inline;{$endIf}
    procedure _MacroITM_Save_ (const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
    procedure _MacroITM_Load_ (const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
  strict private
    function  _MacroITMs_PATH_(const prntPath:string):string;{$ifDef _INLINE_}inline;{$endIf}
    procedure _MacroITMs_Save_(const list:tLazExt_extIDEM_preSetsList_core; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
    procedure _MacroITMs_Load_(const list:tLazExt_extIDEM_preSetsList_core; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
  protected
//   _used_:boolean;
  public
    constructor Create; override;
    destructor DESTROY; override;

//    procedure DoAfterBuild({%H-}AResources: TAbstractProjectResources; {%H-}AReason: TCompileReason; {%H-}SaveToTestDir: boolean); virtual;
//    procedure DoBeforeBuild({%H-}AResources: TAbstractProjectResources; {%H-}AReason: TCompileReason; {%H-}SaveToTestDir: boolean); virtual;
    function  UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    procedure WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;
    procedure ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;

  public
    //function  UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    //procedure WriteToProjectFile(AConfig: {Laz2_XMLCfg.TXMLConfig}TObject; Path: String); override;
    //procedure ReadFromProjectFile(AConfig: {Laz2_XMLCfg.TXMLConfig}TObject; Path: String); override;
  public
    property preSets:tLazExt_extIDEM_preSetsList_core read _list_;
    property Enabled:boolean read _enabled_ write _enabled_set_;
    property MustDEL:boolean read _mustDel_ write _mustDel_set_;
  end;


 function ActiveProject_ExtIDEM_prjResources:tExtIDEM_prjResources;

implementation
const
   _cTXT_pathDelimiter_='/';
   _cTXT_ITEMs_        ='ITEMs';
   _cTXT_Enables_      ='Enabled';


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
   _mustDel_:=false;
   _enabled_:=false;
    //---
   _list_:=NIL;
   _list_reIni_;
end;

destructor tExtIDEM_prjResources.DESTROY;
begin
   _list_clear_;
    inherited;
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
        if not _mustDel_ then begin // тут сохранение идет
            SetDeleteValue(_getConfigPATH_(Path)+'Enabled',_enabled_,true);
           _MacroITMs_Save_(_list_,TXMLConfig(AConfig),_getConfigPATH_(Path));
        end;
        //--- а может и не надо?
        if (_mustDel_)or ( (not _enabled_)and(not HasChildPaths(_getConfigPATH_(Path))) )
        then DeletePath(_getConfigPATH_(Path));
    end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteToProjectFile  : '+Path);
    {$endIf}
end;

procedure tExtIDEM_prjResources.ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
   _list_reIni_; //< мы юудем его ПЕРЕЗАГРУЖАТЬ полностью
   _mustDel_:=FALSE;
    with TXMLConfig(AConfig) do begin
       _enabled_:=GetValue(_getConfigPATH_(Path)+'Enabled',HasChildPaths(_getConfigPATH_(Path)));
       _MacroITMs_Load_(_list_, TXMLConfig(AConfig),_getConfigPATH_(Path));
    end;
    //---
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadFromProjectFile : '+Path);
    {$endIf}
end;

//------------------------------------------------------------------------------
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tExtIDEM_prjResources._getConfigPATH_(const Path:string):string;
begin
    result:=Path+'extIDEM'+_cTXT_pathDelimiter_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{%region --- _MacroPRM_..  Save|load ------------------------------ /fold}

function  tExtIDEM_prjResources._MacroPRM_PATH_(const macroPRM:tExtIDEM_McrPRM_node; const prntPath:String):string;
begin
    result:=prntPath+macroPRM.node_IDNT+_cTXT_pathDelimiter_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tExtIDEM_prjResources._MacroPRM_Save_(const macroPRM:tExtIDEM_McrPRM_node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
begin
    if (macroPRM.MustDEL) then AConfig.DeletePath(_MacroPRM_PATH_(macroPRM,prntPath))
    else begin
        AConfig.SetValue(_MacroPRM_PATH_(macroPRM,prntPath)+_cTXT_Enables_,macroPRM.Enabled);
        //--- сохраняем
        macroPRM.node_Save(AConfig,_MacroPRM_PATH_(macroPRM,prntPath));
        //--- а может и не надо?
        if (not macroPRM.Enabled)and(not AConfig.HasChildPaths(_MacroPRM_PATH_(macroPRM,prntPath)))
        then AConfig.DeletePath(_MacroPRM_PATH_(macroPRM,prntPath));
    end;
end;

procedure tExtIDEM_prjResources._MacroPRM_Load_(const macroPRM:tExtIDEM_McrPRM_node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
begin
    ShowMessage('_MacroPRM_Load_ :'+_MacroPRM_PATH_(macroPRM,prntPath));
    macroPRM.Enabled:=AConfig.GetValue(_MacroPRM_PATH_(macroPRM,prntPath)+_cTXT_Enables_,true);
    macroPRM.node_Load(AConfig,_MacroPRM_PATH_(macroPRM,prntPath));
end;

{%endRegion}

{%region --- _MacroPRMs_.. Save|load ------------------------------ /fold}

function tExtIDEM_prjResources._MacroPRMs_PATH_(const prntPath:string):string;
begin
    result:=prntPath+_cTXT_ITEMs_+_cTXT_pathDelimiter_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tExtIDEM_prjResources._MacroPRMs_Save_(const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
var tmp:tExtIDEM_McrPRM_node;
begin
    tmp:=macroITM.Param_First;
    while Assigned(tmp) do begin
       _MacroPRM_Save_(tmp,AConfig,_MacroPRMs_PATH_(prntPath));
        tmp:=macroITM.Param_Next(tmp);
    end;
    //--- а может и не надо вовсе
    if not AConfig.HasChildPaths(_MacroPRMs_PATH_(prntPath))
    then AConfig.DeletePath(_MacroPRMs_PATH_(prntPath));
end;

procedure tExtIDEM_prjResources._MacroPRMs_Load_(const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
var dom_Node:TDomNode;
    macroPRM:tExtIDEM_McrPRM_node;
    ide__PRM:tExtIDEM_McrPRM_node;
    //cccITM:tLazExt_extIDEM_preSet_Node;
begin
    ShowMessage('_MacroPRMs_Load_ :'+_MacroPRMs_PATH_(prntPath));

    dom_Node:=AConfig.FindNode(_MacroPRMs_PATH_(prntPath),false);
    if Assigned(dom_Node) then begin
        dom_Node:=dom_Node.FirstChild;
        while Assigned(dom_Node) do begin
            macroPRM:=macroITM.Param_FND(dom_Node.NodeName);
            if not Assigned(macroPRM) then begin //< такого еще нет
                ide__PRM:=extIDEM.FIND_IDNT(macroITM.node_IDNT,dom_Node.NodeName);
                if Assigned(ide__PRM) then begin
                    ShowMessage('_MacroPRMs_Load_ : COPY ===');
                    macroPRM:=tLazExt_extIDEM_nodeTYPE(ide__PRM.ClassType).Create;
                    macroPRM.Copy(ide__PRM);
                    ShowMessage('_MacroPRMs_Load_ : COPY +++');
                end
                else begin
                    macroPRM:=tExtIDEM_McrPRM_NotDEF_node.Create(dom_Node.NodeName);
                end;
                if Assigned(macroPRM) then begin
                    macroITM.Param_INS(macroPRM);
                end;
            end;
            //---
            if Assigned(macroPRM) then begin
               _MacroPRM_Load_(macroPRM,AConfig,_MacroPRMs_PATH_(prntPath))
            end;
            //---
            dom_Node:=dom_Node.NextSibling;
        end;
    end;
end;

{%endRegion}

{%region --- _MacroITM_ .. Save|load ------------------------------ /fold}

function tExtIDEM_prjResources._MacroITM_PATH_(const macroITM:tLazExt_extIDEM_preSet_Node; const prntPath:String):string;
begin
    result:=prntPath+macroITM.node_IDNT+_cTXT_pathDelimiter_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tExtIDEM_prjResources._MacroITM_Save_(const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
begin
    if (macroITM.MustDEL) then AConfig.DeletePath(_MacroITM_PATH_(macroITM,prntPath))
    else begin
        AConfig.SetValue(_MacroITM_PATH_(macroITM,prntPath)+_cTXT_Enables_,macroITM.Enabled);
        //---
        macroITM.node_Save(AConfig,_MacroITM_PATH_(macroITM,prntPath));
       _MacroPRMs_Save_   (macroITM,AConfig,_MacroITM_PATH_(macroITM,prntPath));
        //--- а может и не надо?
        if (not macroITM.Enabled)and(not AConfig.HasChildPaths(_MacroITM_PATH_(macroITM,prntPath)))
        then AConfig.DeletePath(_MacroITM_PATH_(macroITM,prntPath));
    end;
end;

procedure tExtIDEM_prjResources._MacroITM_Load_(const macroITM:tLazExt_extIDEM_preSet_Node; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
begin
    // загружаем САМ узел
    macroITM.Enabled:=AConfig.GetValue(_MacroITM_PATH_(macroITM,prntPath)+_cTXT_Enables_,true);
    macroITM.node_Load(AConfig,_MacroITM_PATH_(macroITM,prntPath));
    ShowMessage('LOAD :'+_MacroITM_PATH_(macroITM,prntPath));
    // идем по ВЛОЖЕННЫМ узлам и пытаемся их ЗАГРУЗИТЬ
   _MacroPRMs_Load_(macroITM, AConfig, _MacroITM_PATH_(macroITM,prntPath));
end;

{%endRegion}

{%region --- _MacroITMs_.. Save|load ------------------------------ /fold}

function tExtIDEM_prjResources._MacroITMs_PATH_(const prntPath:string):string;
begin
    result:=prntPath+_cTXT_ITEMs_+_cTXT_pathDelimiter_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tExtIDEM_prjResources._MacroITMs_Save_(const list:tLazExt_extIDEM_preSetsList_core; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
var tmp:tLazExt_extIDEM_preSet_Node;
begin
    tmp:=list.PreSETs_enumFIRST;
    while Assigned(tmp) do begin
       _MacroITM_Save_(tmp,AConfig,_MacroITMs_PATH_(prntPath));
        tmp:=list.PreSETs_enum_NEXT(tmp);
    end;
    //--- а может и не надо вовсе
    if not AConfig.HasChildPaths(_MacroITMs_PATH_(prntPath))
    then AConfig.DeletePath(_MacroITMs_PATH_(prntPath));
end;

procedure tExtIDEM_prjResources._MacroITMs_Load_(const list:tLazExt_extIDEM_preSetsList_core; const AConfig:Laz2_XMLCfg.TXMLConfig; const prntPath:String);
var dom_Node:TDomNode;
    macroITM:tLazExt_extIDEM_preSet_Node;
begin
    dom_Node:=AConfig.FindNode(_MacroITMs_PATH_(prntPath),false);
    if Assigned(dom_Node) then begin
        dom_Node:=dom_Node.FirstChild;
        while Assigned(dom_Node) do begin
            macroITM:=list.PreSETs_Find_IDNT(dom_Node.NodeName);
            if not Assigned(macroITM) then begin //< её ещё НЕТ в списке ... надо создать
                macroITM:=extIDEM.FIND_IDNT(dom_Node.NodeName);
                if Assigned(macroITM) then begin //< ага, идже её поддерживает
                    macroITM:=tLazExt_extIDEM_preSet_NodeTYPE(macroITM.ClassType).Create;
                    list.PreSETs_ADD(macroITM);
                end
                else begin //< неизвестный тип ... создаем сответствующий
                    macroITM:=tExtIDEM_NDF_MACROS_node.Create;//(dom_Node.NodeName);
                end;
            end;
            //---
            if Assigned(macroITM) then begin
                _MacroITM_Load_(macroITM, AConfig, _MacroITMs_PATH_(prntPath));
            end;
            macroITM:=nil;
            //---
            dom_Node:=dom_Node.NextSibling;
        end;
    end;
end;

{%endRegion}

//------------------------------------------------------------------------------


procedure tExtIDEM_prjResources._mustDel_set_(const value:boolean);
begin
    if _mustDel_<>value then begin
       _mustDel_:=value;
        if _mustDel_ then _enabled_:=FALSE;
        SetModified(true);
    end;
end;

procedure tExtIDEM_prjResources._enabled_set_(const value:boolean);
begin
    if _enabled_<>value then begin
       _enabled_:=value;
        if _enabled_ then _mustDel_:=FALSE;
        SetModified(true);
    end;
end;

//------------------------------------------------------------------------------

procedure tExtIDEM_prjResources._list_clear_;
begin
   _list_.FREE;
end;

procedure tExtIDEM_prjResources._list_reIni_;
var i:tLazExt_extIDEM_preSet_Node;
begin
   _list_clear_;
   _list_:=tLazExt_extIDEM_preSetsList_core.Create;
    {//---
    i:=tExtIDEM_preSet_NDF_node.Create;
   _list_.PreSETs_ADD(i);

   //---
   i:=tExtIDEM_preSet_USER_node.Create;
   i.Param_ADD('Text', TlazExt_extIDEM_mcrPRM_usrTEXT_itm);
   i.Param_ADD('File', TlazExt_extIDEM_mcrPRM_usrFILE_itm);
   i.Param_ADD('asd1', tLazExt_extIDEM_maCRO_NDF_node);
   i.Param_ADD('asd2', tLazExt_extIDEM_maCRO_NDF_node);
  _list_.PreSETs_ADD(i);}



end;

//------------------------------------------------------------------------------



end.

