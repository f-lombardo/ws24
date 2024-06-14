import go
import semmle.go.dataflow.DataFlow
import semmle.go.dataflow.TaintTracking

from DefineStmt stmt, Expr e, Ident id, SelectorExpr selexpr
where id = stmt.getLhs(0) and
e = stmt.getRhs() and
selexpr = e.getAChild*() and
selexpr.getBase().toString() = "web" and
selexpr.getSelector().toString() = "Params"
select id