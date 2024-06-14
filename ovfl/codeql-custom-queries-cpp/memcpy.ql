import cpp

from FunctionCall memcpy
where memcpy.getTarget().hasName("memcpy") and
not memcpy.getArgument(2).getUnderlyingType().isConst() and
// notice the use of getTarget to semantically match the same variable
exists(AddExpr add |
    add.getAnOperand().(VariableAccess).getTarget() = memcpy.getArgument(2).(VariableAccess).getTarget())
select "Found flexible memcpy call!", memcpy, memcpy.getLocation()