import cpp

from VariableAccess size, AddExpr add, DeclStmt stmt, VariableDeclarationEntry len,
FunctionCall mallocCall, FunctionCall memcpyCall
where

select memcpyCall, "Potential heap overflow due to unsafe memory copy after arithmetic overflow."
