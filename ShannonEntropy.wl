ShannonEntropy::usage = 
  "Calculate the Shannon Entropy of a random variable distributed \
according to the input distribution; for example: 
  for X \[Distributed] NormalDistribution[0,1], H(X) = \
\!\(\*FractionBox[\(1\), \(2\)]\)(Log[2 \[Pi]]+1) = \
ShannonEntropy[NormalDistribution[0,1]]
  	Inputs:
  		A.
  			1. A distribution.
  
  		B.
  			1. A Real number as the base in which to calculate ShannonEntropy,
  			2. A distribution
  
  	Options:
  		Method:
  			1. Expectation,
  			2. NExpectation
  	Result:
  		The entropy of the distribution as defined by Shannon's entropy \
function, H.";
ShannonEntropy::errorNotAValidDistribution = "The distribution, `1`, does not appear to be a valid distribution.";
ShannonEntropy::errorBaseIsProblematic = "The Log of `1` will results in an Indeterminate value, because \Log[0] \[Rule] -\[Infinity] and Log[1] = 0.";
Options[ShannonEntropy] = {Method -> Expectation};
ShannonEntropy[distribution_?(Not[DistributionParameterQ[#]] &)] := Catch[Throw[Message[ShannonEntropy::errorNotAValidDistribution]; Return[$Failed]]];
ShannonEntropy[base_?(Not[NumberQ[#]] || 0 > # || # == 1 &), distribution_, OptionsPattern[]] := Catch[Throw[Message[ShannonEntropy::errorBaseIsProblematic]; Return[$Failed]]];
ShannonEntropy[base_?(NumberQ[#] && 0 < # && # != 1 &), distribution_?DistributionParameterQ, OptionsPattern[]] := ShannonEntropy[distribution, Method -> OptionValue[Method]]/Log[base];
ShannonEntropy[distribution_?DistributionParameterQ, OptionsPattern[]] := Function[Block[{#}, OptionValue[Method][LogLikelihood[distribution, {#}], # \[Distributed] distribution]]][Unique[]];
