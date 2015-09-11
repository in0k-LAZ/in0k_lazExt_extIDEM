unit lazExt_extIDEM_preSet_node;

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

uses lazExt_extIDEM_preSet_edit, sysutils;

type

 tLazExt_extIDEM_preSet_Node=class(tLazExt_extIDEM_preSet_edtNode)
  private
   _next_:tLazExt_extIDEM_preSet_Node;
   _indx_:Integer; //< TIDEOptionsEditorRec.Index
    function _node_nameCMP_(const name:string):integer;
    function _node_name_IS_(const name:string):boolean;
    function _node_indxCMP_(const indx:integer):integer;
    function _node_indx_IS_(const indx:integer):boolean;
  public
    class function defEditor:tLazExt_extIDEM_preSet_frmEditTYPE; virtual; {$ifNdef _TSTABS_}abstract;{$endif}
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
    function  _nodes_FND_(const IDNT:string):tLazExt_extIDEM_preSet_Node; overload;
    function  _nodes_FND_(const INDX:integer):tLazExt_extIDEM_preSet_Node; overload;
    procedure _nodes_INS_(const node:tLazExt_extIDEM_preSet_Node);
    function  _nodes_ADD_(const preSet:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    //function PreSETs_ADD_Node(const preSet:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node; virtual;
    function PreSETs_enumFIRST:tLazExt_extIDEM_preSet_Node;
    function PreSETs_enum_NEXT(const node:tLazExt_extIDEM_preSet_Node):tLazExt_extIDEM_preSet_Node;
  end;

implementation

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_Node.defEditor:tLazExt_extIDEM_preSet_frmEditTYPE;
begin
    Assert(false,self.ClassName+'.defEditor mast by OVERRIDE');
    result:=NIL; {todo: вставить НОТ ДЕФ редактор}
end;
{$endif}

//------------------------------------------------------------------------------

function tLazExt_extIDEM_preSet_Node._node_nameCMP_(const name:string):integer;
begin
    result:=sysutils.CompareText(self.preSet_Name,name);
end;

function tLazExt_extIDEM_preSet_Node._node_name_IS_(const name:string):boolean;
begin
    result:= 0=_node_nameCMP_(name);
end;

function tLazExt_extIDEM_preSet_Node._node_indxCMP_(const indx:integer):integer;
begin
    if indx=self._indx_ then result:=0
    else begin
        result:=-1;
        if indx<self._indx_ then result:=-1
    end;
end;

function tLazExt_extIDEM_preSet_Node._node_indx_IS_(const indx:integer):boolean;
begin
    result:= 0=_node_indxCMP_(indx)
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

{function tLazExt_extIDEM_preSetsList_core.PreSETs_ADD_Node(const preSet:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    if not Assigned(_nodes_FND_(preSet.preSet_Name)) then begin
        result:=preSet.Create;
       _nodes_INS_(result);
    end
    else result:=nil
end;}

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

//------------------------------------------------------------------------------

// поиск в спискае узла с совпадающим идентификатором
function tLazExt_extIDEM_preSetsList_core._nodes_FND_(const IDNT:string):tLazExt_extIDEM_preSet_Node;
begin
    {$ifDef _TSTPRM_}
        Assert(IDNT='','IDNT === NIL string');
    {$endIF}
    result:=_nodes_;
    while Assigned(result) do begin
        if result._node_name_IS_(IDNT) then BREAK;
        result:=result._next_;
    end;
end;

//------------------------------------------------------------------------------

// поиск в спискае узла с совпадающим индексом
function tLazExt_extIDEM_preSetsList_core._nodes_FND_(const INDX:integer):tLazExt_extIDEM_preSet_Node;
begin
   {$ifDef _TSTPRM_}
       Assert(INDX<=0,'INDX is INvalid');
   {$endIF}
   result:=_nodes_;
   while Assigned(result) do begin
       if result._node_indx_IS_(INDX) then BREAK;
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

function tLazExt_extIDEM_preSetsList_core._nodes_ADD_(const preSet:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(preSet),'preSet === NIL');
    {$endIF}
    if not Assigned(_nodes_FND_(preSet.preSet_Name)) then begin
        result:=preSet.Create;
       _nodes_INS_(result);
    end
    else result:=nil
end;

end.

