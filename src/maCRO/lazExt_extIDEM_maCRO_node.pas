unit lazExt_extIDEM_maCRO_node;

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

uses lazExt_extIDEM_maCRO_edit, extIDEM_coreObject,
  Classes, SysUtils;

type

 tLazExt_extIDEM_node=class(tExtIDEM_core_objNODE)
  protected
    procedure isChanged;
  private
   _next_:tLazExt_extIDEM_node;
   _edit_:tExtIDEM_core_objEditTYPE; //< выбранный редактор (может отличаться от defEditor)
   _IDNT_:string;
    //function _compare_IDNT_(const IDNT:string):integer;
  public
    constructor Create; override;
    constructor Create(const prmIDNT:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); virtual;
    destructor DESTROY; override;
  protected
    procedure SetUP;                                    virtual;
    procedure Copy (const Source:tLazExt_extIDEM_node); virtual;
  public
    //property Next:tLazExt_extIDEM_node read _next_ write _next_;
    //property Node_EditTYPE:tExtIDEM_core_objEditTYPE read _edit_;
    //property Node_IDNT:string read _IDNT_;

    function nodeTEdit:tExtIDEM_core_objEditTYPE; override;
    function node_IDNT:string; override;
  public
    //class function defEditor:tExtIDEM_core_objEditTYPE; virtual; {$ifNdef _TSTABS_}abstract;{$endif}


                 //PUBLISED
    class function PUBLISED:boolean; virtual;


  end;
 tLazExt_extIDEM_nodeTYPE=class of tLazExt_extIDEM_node;


 tLazExt_extIDEM_nodesList_core=class
  protected
   _nodes_:tLazExt_extIDEM_node;
  protected
    function  _node_getNext(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
    procedure _node_setNext(const node:tLazExt_extIDEM_node; const value:tLazExt_extIDEM_node);
  protected
    procedure _nodes_CLR_;
    function  _nodes_LST_:tLazExt_extIDEM_node;
    function  _nodes_FND_(const IDNT:string):tLazExt_extIDEM_node;
    procedure _nodes_INS_(const node:tLazExt_extIDEM_node);
  protected
    procedure _nodes_CP_ (const Target:tLazExt_extIDEM_nodesList_core);
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    function ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE; const nodeEdit:tExtIDEM_core_objEditTYPE):boolean;
    function ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE):boolean;
    function ADD(const nodeType:tLazExt_extIDEM_nodeTYPE):boolean;
  public
    function Nodes_First:tLazExt_extIDEM_node;
    function Nodes_Next(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
 end;



implementation

constructor tLazExt_extIDEM_node.Create;
begin
    Create('',nil);
end;

constructor tLazExt_extIDEM_node.Create(const prmIDNT:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    if prmIDNT<>''      then _IDNT_:=prmIDNT else  _IDNT_:=Obj_IDNT;
    if Assigned(EDITor) then _edit_:=EDITor  else  _edit_:=ObjTEdit;
   _next_:=nil;
end;

destructor tLazExt_extIDEM_node.DESTROY;
begin // наследие дельфей
   _next_:=nil;
   _edit_:=nil;
   _IDNT_:='';
end;

//------------------------------------------------------------------------------

{{$ifDef _TSTABS_}
class function tLazExt_extIDEM_node.defEditor:tExtIDEM_core_objEditTYPE;
begin
    Assert(false,self.ClassName+'.defEditor mast by OVERRIDE');
    result:=NIL; {todo: вставить НОТ ДЕФ редактор}
end;
{$endif}}

class function tLazExt_extIDEM_node.PUBLISED:boolean;
begin
    result:=FALSE;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_node.isChanged;
begin
   _isChange_;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_node.Copy(const Source:tLazExt_extIDEM_node);
begin
   //
end;

procedure tLazExt_extIDEM_node.SetUP;
begin
   //
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_node.nodeTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=_edit_;
end;

function tLazExt_extIDEM_node.node_IDNT:string;
begin
    result:=_IDNT_;
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

function tLazExt_extIDEM_nodesList_core.ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE; const nodeEdit:tExtIDEM_core_objEditTYPE):boolean;
var tmp:tLazExt_extIDEM_node;
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


function tLazExt_extIDEM_nodesList_core.Nodes_First:tLazExt_extIDEM_node;
begin
    result:=_nodes_;
end;

function tLazExt_extIDEM_nodesList_core.Nodes_Next(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    result:=_node_getNext(node);
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_nodesList_core._node_getNext(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    result:=node._next_;
end;

procedure tLazExt_extIDEM_nodesList_core._node_setNext(const node:tLazExt_extIDEM_node; const value:tLazExt_extIDEM_node);
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
var tmp:tLazExt_extIDEM_node;
begin
    tmp:=_nodes_;
    while Assigned(tmp) do begin
       _nodes_:=tmp._next_;
        tmp.FREE;
        tmp:=_nodes_;
    end;
end;

function tLazExt_extIDEM_nodesList_core._nodes_LST_:tLazExt_extIDEM_node;
begin
   result:=_nodes_;
   while Assigned(result)and Assigned(result._next_) do result:=result._next_;
end;

// поиск в спискае узла с совпадающим идентификатором
function tLazExt_extIDEM_nodesList_core._nodes_FND_(const IDNT:string):tLazExt_extIDEM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(IDNT='','IDNT === NIL string');
    {$endIF}
    result:=_nodes_;
    while Assigned(result) do begin
        if result.Node_IDNT=IDNT then BREAK;
        result:=result._next_;
    end;
end;

procedure tLazExt_extIDEM_nodesList_core._nodes_INS_(const node:tLazExt_extIDEM_node);
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
var tmp:tLazExt_extIDEM_node;
    tmq:tLazExt_extIDEM_node;
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

