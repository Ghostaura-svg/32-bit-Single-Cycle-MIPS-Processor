
module branch_logic (
    input Branch,
    input BranchNE,
    input Zero,
    output PCSrc
);

assign PCSrc =
       (Branch   &&  Zero)
    || (BranchNE && !Zero);

endmodule