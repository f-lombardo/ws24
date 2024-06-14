import go
import semmle.go.dataflow.DataFlow
import semmle.go.dataflow.TaintTracking


from SelectorExpr selexpr, CallExpr call
where exists (DefineStmt stmt, DataFlow::Node source, DataFlow::Node sink |
        selexpr = stmt.getRhs().getAChild*() and
        selexpr.getBase().toString() = "web" and
        selexpr.getSelector().toString() = "Params" and
        call.getTarget().toString() = "Open" and
        source.asExpr() = stmt.getAnRhs() and
        sink.asExpr() = call.getAnArgument() and
        
        // DataFlow::localFlow(source, sink)
        TaintTracking::localTaint(source, sink)
    )
select selexpr.getLocation(), call.getLocation()