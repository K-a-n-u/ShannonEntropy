# ShannonEntropy
A simple implementation of Shannon's entropy function, better known as $H(X)$, to calculate the entropy of distributions, rather than sets of data
realized by those distributions.

This is in contrast to Mathematica's `Entropy` which does not work on distributions.

All of it is just a more thorough version of the single line:\
``ShannonEntropy[dist_?DistributionParameterQ] := -Expectation[LogLikelihood[dist, {x}], x \[Distributed] dist];``
# Usage:
 
 In an arbitrary base: \
    ``ShannonEntropy[base, distribution]`` ``[base information units]``, \
 or in base E: \
    ``ShannonEntropy[distribution]`` ``[nats]``.
    
 ### Options:
  1. Method -> Expectation,
  2. Method -> NExpectation
    
## Example
  1. ``ShannonEntropy[NormalDistribution[0,1]]`` which is $\dfrac{1}{2}\left(\ln_{e}\left(2 \pi\right)+1\right)$.
  2. ``ShannonEntropy[2, NormalDistribution[0,1]]`` ``=`` $\dfrac{1}{2 \ln\left(2\right)}\left(\ln_{e}\left(2 \pi\right)+1\right)$
  3. ``ShannonEntropy[NormalDistribution[0,1], Method -> NExpectation]`` ``=`` ``1.41894``,
  4. ``ShannonEntropy[2, NormalDistribution[0,1], Method -> NExpectation]`` which results in ``2.0471``.
  
## Additional Resources
[[1]](https://www.stat.cmu.edu/~cshalizi/754/2006/) \
[[2]](https://www.stat.cmu.edu/~cshalizi/754/2006/notes/lecture-28.pdf) See Definition 258, Page 191 (the bottom of page 3 in the PDF)
