import go
import semmle.go.dataflow.DataFlow
import semmle.go.dataflow.TaintTracking
    
class Config extends TaintTracking::Configuration {
	Config() { this = "cve-2021-43798" }

	override predicate isSource(DataFlow::Node source) {
		exists (
            DefineStmt stmt, SelectorExpr selexpr |
            selexpr = stmt.getRhs().getAChild*() and
            selexpr.getBase().toString() = "web" and
            selexpr.getSelector().toString() = "Params" and
            source.asExpr() = stmt.getAnRhs()
        )
	}
	
	override predicate isSink(DataFlow::Node sink) {
        exists (
            CallExpr call |
            call.getTarget().toString() = "Open" and
            sink.asExpr() = call.getAnArgument()
        )
	}

    // override predicate isAdditionalTaintStep(DataFlow::Node node1, DataFlow::Node node2) { 
	// 	TaintTracking::localTaintStep(node1, node2) or
	// 	exists (
    //         CallExpr call | call.getAnArgument*() = node1.asExpr() and
    //         call = node2.asExpr()
    //     )
	// }
}
 
from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select source.getNode().asExpr().getLocation() as source_expr, sink.getNode().asExpr().getLocation() as target_expr
    