unit lazExt_extIDEM_preSet_node;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_Group_edit, sysutils;

type

 tLazExt_extIDEM_preSet_Node=class(tLazExt_extIDEM_preSet_edtNode)
  private
   _next_:tLazExt_extIDEM_preSet_Node;
    function _node_nameCMP_(const name:string):integer;
  public
  end;
 tLazExt_extIDEM_preSet_NodeTYPE=class of tLazExt_extIDEM_preSet_Node;

 tLazExt_extIDEM_preSetsList_core=class
  protected
   _nodes_:tLazExt_extIDEM_preSet_Node;
  protected
    //function  _node_getNext(const node:tLazExt_extIDEM_preSet_Node):tLazExt_extIDEM_preSet_Node;
    //procedure _node_setNext(const node:tLazExt_extIDEM_preSet_Node; const value:tLazExt_extIDEM_preSet_Node);
  protected
    procedure _nodes_CLR_;
    function  _nodes_FND_(const IDNT:string):tLazExt_extIDEM_preSet_Node;
    procedure _nodes_INS_(const node:tLazExt_extIDEM_preSet_Node);
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    function PreSETs_ADD_Node(const preSet:tLazExt_extIDEM_preSet_NodeTYPE):boolean;
    function PreSETs_enumFIRST:tLazExt_extIDEM_preSet_Node;
    function PreSETs_enum_NEXT(const node:tLazExt_extIDEM_preSet_Node):tLazExt_extIDEM_preSet_Node;
  end;


implementation


function tLazExt_extIDEM_preSet_Node._node_nameCMP_(const name:string):integer;
begin
    result:=sysutils.CompareText(self.preSet_Name,name);
end;

//==============================================================================

constructor tLazExt_extIDEM_preSetsList_core.Create;
begin
    inherited;
   _nodes_:=nil;
end;

destructor tLazExt_extIDEM_preSetsList_core.DESTROY;
begin
   //_nodes_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_preSetsList_core.PreSETs_ADD_Node(const preSet:tLazExt_extIDEM_preSet_NodeTYPE):boolean;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    if not Assigned(_nodes_FND_(preSet.preSet_Name)) then begin
       _nodes_INS_(preSet.Create);
        result:=true;
    end
    else result:=false
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_extIDEM_preSetsList_core.PreSETs_enumFIRST:tLazExt_extIDEM_preSet_Node;
begin
    result:=_nodes_;
end;

function tLazExt_extIDEM_preSetsList_core.PreSETs_enum_NEXT(const node:tLazExt_extIDEM_preSet_Node):tLazExt_extIDEM_preSet_Node;
begin
   {$ifDef _TSTPRM_}
       Assert(Assigned(node),'NODE === NIL');
   {$endIF}
   result:=node._next_;
end;

//------------------------------------------------------------------------------

{function tLazExt_extIDEM_preSetsList_core._node_getNext(const node:tLazExt_extIDEM_preSet_Node):tLazExt_extIDEM_preSet_Node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    result:=node._next_;
end;

procedure tLazExt_extIDEM_preSetsList_core._node_setNext(const node:tLazExt_extIDEM_preSet_Node; const value:tLazExt_extIDEM_preSet_Node);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    node._next_:=value;
end;
}
//------------------------------------------------------------------------------

{procedure tLazExt_extIDEM_preSetsList_core._nodes_setFIRST(const value:tObject);
begin

end;

function  tLazExt_extIDEM_preSetsList_core._nodes_getFIRST:tObject;
begin

end;}

//------------------------------------------------------------------------------

// очистка списка узлов (уничтожение)
procedure tLazExt_extIDEM_preSetsList_core._nodes_CLR_;
var tmp:tLazExt_extIDEM_preSet_Node;
begin
    tmp:=_nodes_;
    while Assigned(tmp) do begin
       _nodes_:=tmp._next_;
        tmp.FREE;
        tmp:=_nodes_;
    end;
end;

// поиск в спискае узла с совпадающим идентификатором
function tLazExt_extIDEM_preSetsList_core._nodes_FND_(const IDNT:string):tLazExt_extIDEM_preSet_Node;
begin
    {$ifDef _TSTPRM_}
        Assert(IDNT='','IDNT === NIL string');
    {$endIF}
    result:=_nodes_;
    while Assigned(result) do begin
        if 0=result._node_nameCMP_(IDNT) then BREAK;
        result:=result._next_;
    end;
end;

procedure tLazExt_extIDEM_preSetsList_core._nodes_INS_(const node:tLazExt_extIDEM_preSet_Node);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    node._next_:=_nodes_;
   _nodes_:=node;
end;

end.

