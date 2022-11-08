ShannonEntropy[dist_?DistributionParameterQ] := Expectation[LogLikelihood[dist, {x}], x \[Distributed] dist];
