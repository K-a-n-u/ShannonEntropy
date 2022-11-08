(*
  As a single line: 
      ShannonEntropy[dist_?DistributionParameterQ] := Expectation[LogLikelihood[dist, {x}], x \[Distributed] dist];
      
  References:
    <https://www.stat.cmu.edu/~cshalizi/754/2006/>
    <https://www.stat.cmu.edu/~cshalizi/754/2006/notes/lecture-28.pdf>
      See Definition 258, Page 191 (the bottom of page 3 in the PDF).
*)
ShannonEntropy::usage = 
  "Calculates the Shannon Entropy of a random variable distributed according to the input distribution.
  For example: 
  	Let X \[Distributed] NormalDistribution[0,1], then 
  	H(X) = \!\(\*FractionBox[\(1\), \(2\)]\)(Log[2 \[Pi]]+1) = ShannonEntropy[NormalDistribution[0,1]]
  
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
  		The entropy of the distribution as defined by Shannon's entropy function, H.";
ShannonEntropy::errorNotAValidDistribution = "The distribution, `1`, does not appear to be a valid distribution.";
ShannonEntropy::errorBaseIsProblematic = "The Log of `1` will results in an Indeterminate value, because \Log[0] \[Rule] -\[Infinity] and Log[1] = 0.";
Options[ShannonEntropy] = {Method -> Expectation};
ShannonEntropy[distribution_?(Not[DistributionParameterQ[#]] &)] := Catch[Throw[Message[ShannonEntropy::errorNotAValidDistribution]; Return[$Failed]]];
ShannonEntropy[base_?( # <= 0 || # == 1 &), distribution_] := Catch[Throw[Message[ShannonEntropy::errorBaseIsProblematic]; Return[$Failed]]];
ShannonEntropy[base_?( 0 < # && # != 1 &), distribution_?DistributionParameterQ, optionsShannonEntropy : OptionsPattern[]] := ShannonEntropy[distribution, optionsShannonEntropy]/Log[base]; (*Transforms the base of the log function.*)
ShannonEntropy[distribution_?DistributionParameterQ, optionsShannonEntropy : OptionsPattern[]] := Function[Block[{#}, Return[-OptionValue[Method][LogLikelihood[distribution, {#}], # \[Distributed] distribution]]]][Unique[]]; (*this is equivalent to sum x Log(P(x)) using the definition of expectation and Loglikelihood.*)
