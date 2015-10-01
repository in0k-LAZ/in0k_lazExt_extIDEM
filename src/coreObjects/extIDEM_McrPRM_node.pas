unit extIDEM_McrPRM_node;

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

uses extIDEM_coreObject, Laz2_XMLCfg,
  Classes, SysUtils;

type

 tExtIDEM_McrPRM_node=class(tExtIDEM_core_objNODE)
  private
   _next_:tExtIDEM_McrPRM_node;
   _edit_:tExtIDEM_core_objEditTYPE; //< выбранный редактор (может отличаться от defEditor)
  protected
   _IDNT_:string;
  private
   _rIDE_:integer;
   _rSRC_:integer;
    procedure _rIDE_SET_(const value:integer);
    procedure _rSRC_SET_(const value:integer);
  protected
    function  ConfigPath(const ParentPath:string):string;
  protected
    property  ResultForIDE:integer read _rIDE_ write _rIDE_SET_;
    property  ResultForSRC:integer read _rSRC_ write _rSRC_SET_;
    procedure AConfig_setResultValue(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String; const defIDE,defSRC:integer);
    procedure AConfig_getResultValue(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String; const defIDE,defSRC:integer);
  public
    constructor Create; override;
    constructor Create(const prmIDNT:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); virtual;
    destructor DESTROY; override;
  protected
    procedure SetUP;                                    virtual;
  public
    procedure Copy (const Source:tExtIDEM_McrPRM_node); virtual;
    //property Next:tExtIDEM_McrPRM_node read _next_ write _next_;
    //property Node_EditTYPE:tExtIDEM_core_objEditTYPE read _edit_;
    //property Node_IDNT:string read _IDNT_;

    function nodeTEdit:tExtIDEM_core_objEditTYPE; override;
    function node_IDNT:string; override;
  public
    //class function defEditor:tExtIDEM_core_objEditTYPE; virtual; {$ifNdef _TSTABS_}abstract;{$endif}


                 //PUBLISED
    class function PUBLISED:boolean; virtual;


  end;
 tLazExt_extIDEM_nodeTYPE=class of tExtIDEM_McrPRM_node;


 tLazExt_extIDEM_nodesList_core=class
  protected
   _nodes_:tExtIDEM_McrPRM_node;
  protected
    function  _node_getNext(const node:tExtIDEM_McrPRM_node):tExtIDEM_McrPRM_node;
    procedure _node_setNext(const node:tExtIDEM_McrPRM_node; const value:tExtIDEM_McrPRM_node);
  protected
    procedure _nodes_CLR_;
    function  _nodes_LST_:tExtIDEM_McrPRM_node;
    function  _nodes_FND_(const IDNT:string; const withOut:tExtIDEM_McrPRM_node=nil):tExtIDEM_McrPRM_node;
    procedure _nodes_INS_(const node:tExtIDEM_McrPRM_node);
  protected
    procedure _nodes_CP_ (const Target:tLazExt_extIDEM_nodesList_core);
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    procedure INS(const node:tExtIDEM_McrPRM_node);

    function ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE; const nodeEdit:tExtIDEM_core_objEditTYPE):boolean;
    function ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE):boolean;
    function ADD(const nodeType:tLazExt_extIDEM_nodeTYPE):boolean;

    function FND(const prmName:string):tExtIDEM_McrPRM_node;
    function FND(const prmName:string; const withOut:tExtIDEM_McrPRM_node):tExtIDEM_McrPRM_node;


  public
    function Nodes_First:tExtIDEM_McrPRM_node;
    function Nodes_Next(const node:tExtIDEM_McrPRM_node):tExtIDEM_McrPRM_node;
 end;



implementation

constructor tExtIDEM_McrPRM_node.Create;
begin
    Create('',nil);
   _rIDE_:=0;
   _rSRC_:=0;
end;

constructor tExtIDEM_McrPRM_node.Create(const prmIDNT:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    if prmIDNT<>''      then _IDNT_:=prmIDNT else  _IDNT_:=Obj_IDNT;
    if Assigned(EDITor) then _edit_:=EDITor  else  _edit_:=ObjTEdit;
   _next_:=nil;
end;

destructor tExtIDEM_McrPRM_node.DESTROY;
begin // наследие дельфей
   _next_:=nil;
   _edit_:=nil;
   _IDNT_:='';
end;

//------------------------------------------------------------------------------

{{$ifDef _TSTABS_}
class function tExtIDEM_McrPRM_node.defEditor:tExtIDEM_core_objEditTYPE;
begin
    Assert(false,self.ClassName+'.defEditor mast by OVERRIDE');
    result:=NIL; {todo: вставить НОТ ДЕФ редактор}
end;
{$endif}}

class function tExtIDEM_McrPRM_node.PUBLISED:boolean;
begin
    result:=FALSE;
end;

//------------------------------------------------------------------------------


procedure tExtIDEM_McrPRM_node.Copy(const Source:tExtIDEM_McrPRM_node);
begin
   _IDNT_:=Source._IDNT_;
   _edit_:=Source._edit_;
end;

procedure tExtIDEM_McrPRM_node.SetUP;
begin
   //
end;

//------------------------------------------------------------------------------

function tExtIDEM_McrPRM_node.nodeTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=_edit_;
end;

function tExtIDEM_McrPRM_node.node_IDNT:string;
begin
    result:=_IDNT_;
end;


//------------------------------------------------------------------------------

procedure tExtIDEM_McrPRM_node._rIDE_SET_(const value:integer);
begin
    if value<>_rIDE_ then begin
       _rIDE_:=value;
        set_IsCHANGed;
    end;
end;

procedure tExtIDEM_McrPRM_node._rSRC_SET_(const value:integer);
begin
    if value<>_rSRC_ then begin
       _rSRC_:=value;
        set_IsCHANGed;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _cTXT_pathDELIM='/';


function tExtIDEM_McrPRM_node.ConfigPath(const ParentPath:string):string;
begin
    result:=ParentPath+self._IDNT_+_cTXT_pathDELIM;
end;

const
  _cTXT_RESULT_='RESULT';
  _cTXT_forIDE_='forIDE';
  _cTXT_forSRC_='forSRC';

procedure tExtIDEM_McrPRM_node.AConfig_setResultValue(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String; const defIDE,defSRC:integer);
begin
    AConfig.SetDeleteValue(Path+_cTXT_RESULT_+_cTXT_pathDELIM+_cTXT_forIDE_,_rIDE_,defIDE);
    AConfig.SetDeleteValue(Path+_cTXT_RESULT_+_cTXT_pathDELIM+_cTXT_forSRC_,_rSRC_,defSRC);
end;

procedure tExtIDEM_McrPRM_node.AConfig_getResultValue(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String; const defIDE,defSRC:integer);
begin
   _rIDE_:=AConfig.GetValue(Path+_cTXT_RESULT_+_cTXT_pathDELIM+_cTXT_forIDE_,defIDE);
   _rSRC_:=AConfig.GetValue(Path+_cTXT_RESULT_+_cTXT_pathDELIM+_cTXT_forSRC_,defSRC);
end;

//==============================================================================

constructor tLazExt_extIDEM_nodesList_core.Create;
begin
    inherited;
   _nodes_:=nil;
end;

destructor tLazExt_extIDEM_nodesList_core.DESTROY;
begin
   _nodes_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_nodesList_core.INS(const node:tExtIDEM_McrPRM_node);
begin
   _nodes_INS_(node);
end;

function tLazExt_extIDEM_nodesList_core.ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE; const nodeEdit:tExtIDEM_core_objEditTYPE):boolean;
var tmp:tExtIDEM_McrPRM_node;
begin
    {$ifDef _TSTPRM_}
       // Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    tmp:=nodeType.Create(prmName,nodeEdit);
    if Assigned(_nodes_FND_(tmp.node_Name)) then begin //< такой уже есть
        result:=FALSE;
        tmp.FREE;
    end
    else begin //< такого нет, вставляем
       _nodes_INS_(tmp);
        result:=true;
    end;
    {$ifDef _TSTPRM_}
         Assert(result, ClassName+'.ADD('+prmName+','+nodeType.ClassName+')'+'FALSE');
    {$endIF}
end;

function tLazExt_extIDEM_nodesList_core.ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE):boolean;
begin
    result:=ADD(prmName,nodeType,nil)
end;

function tLazExt_extIDEM_nodesList_core.ADD(const nodeType:tLazExt_extIDEM_nodeTYPE):boolean;
begin
    result:=ADD('',nodeType,nil)
end;

function tLazExt_extIDEM_nodesList_core.FND(const prmName:string):tExtIDEM_McrPRM_node;
begin
    result:=_nodes_FND_(prmName);
end;

function tLazExt_extIDEM_nodesList_core.FND(const prmName:string; const withOut:tExtIDEM_McrPRM_node):tExtIDEM_McrPRM_node;
begin
    result:=_nodes_FND_(prmName,withOut);
end;

function tLazExt_extIDEM_nodesList_core.Nodes_First:tExtIDEM_McrPRM_node;
begin
    result:=_nodes_;
end;

function tLazExt_extIDEM_nodesList_core.Nodes_Next(const node:tExtIDEM_McrPRM_node):tExtIDEM_McrPRM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    result:=_node_getNext(node);
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_nodesList_core._node_getNext(const node:tExtIDEM_McrPRM_node):tExtIDEM_McrPRM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    result:=node._next_;
end;

procedure tLazExt_extIDEM_nodesList_core._node_setNext(const node:tExtIDEM_McrPRM_node; const value:tExtIDEM_McrPRM_node);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    node._next_:=value;
end;

//------------------------------------------------------------------------------

{procedure tLazExt_extIDEM_nodesList_core._nodes_setFIRST(const value:tObject);
begin

end;

function  tLazExt_extIDEM_nodesList_core._nodes_getFIRST:tObject;
begin

end;}

//------------------------------------------------------------------------------

// очистка списка узлов (уничтожение)
procedure tLazExt_extIDEM_nodesList_core._nodes_CLR_;
var tmp:tExtIDEM_McrPRM_node;
begin
    tmp:=_nodes_;
    while Assigned(tmp) do begin
       _nodes_:=tmp._next_;
        tmp.FREE;
        tmp:=_nodes_;
    end;
end;

function tLazExt_extIDEM_nodesList_core._nodes_LST_:tExtIDEM_McrPRM_node;
begin
   result:=_nodes_;
   while Assigned(result)and Assigned(result._next_) do result:=result._next_;
end;

// поиск в спискае узла с совпадающим идентификатором
function tLazExt_extIDEM_nodesList_core._nodes_FND_(const IDNT:string; const withOut:tExtIDEM_McrPRM_node=nil):tExtIDEM_McrPRM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(IDNT='','IDNT === NIL string');
    {$endIF}
    result:=_nodes_;
    while Assigned(result) do begin
        if (result.Node_IDNT=IDNT)and(withOut<>result) then BREAK;
        result:=result._next_;
    end;
end;

procedure tLazExt_extIDEM_nodesList_core._nodes_INS_(const node:tExtIDEM_McrPRM_node);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    node._next_:=_nodes_LST_;
    if Assigned(node._next_) then begin
        node._next_._next_:=node;
        node._next_:=nil;
    end
    else _nodes_:=node;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_nodesList_core._nodes_CP_(const Target:tLazExt_extIDEM_nodesList_core);
var tmp:tExtIDEM_McrPRM_node;
    tmq:tExtIDEM_McrPRM_node;
begin //
    tmp:=Nodes_First;
    while Assigned(tmp) do begin
        tmq:=tLazExt_extIDEM_nodeTYPE(tmp.ClassType).Create(tmp.Node_IDNT);
        tmq.Copy(tmp);
        Target._nodes_INS_(tmq);
        //--->
        tmp:=Nodes_Next(tmp);
    end;
end;

end.

