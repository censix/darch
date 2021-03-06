darch
=====

#### Create deep architectures in the R programming language


### Installation

When using [devtools](https://github.com/hadley/devtools/), the latest git version (identifiable by a version number ending in something greater than or equal to 9000) can be installed using

```R
install_github("maddin79/darch")
```

Then, use `?darch` to view its documentation or `example("darch")` to load some examples (these will not directly be executed, but provide `example.*` functions).

### About

The darch package is built on the basis of the code from G. E. Hinton and R. R. Salakhutdinov
(available under [Matlab Code for deep belief nets](http://www.cs.toronto.edu/~hinton/MatlabForSciencePaper.html
"Matlab for science paper") : last visit: 12.11.2015).

This package is for generating neural networks with many layers (deep architectures) and train them with the method introduced by the publications "A fast learning algorithm for deep belief nets" (G. E. Hinton, S. Osindero, Y. W. Teh) and "Reducing the dimensionality of data with neural networks" (G. E. Hinton, R. R. Salakhutdinov). This method includes a pre training with the contrastive divergence method published by G.E Hinton (2002) and a fine tuning with common known training algorithms like backpropagation or conjugate gradient, as well as more recent techniques like dropout and maxout.

Copyright (C) 2013-2015 Martin Drees and contributors

#### References
Hinton, G. E., S. Osindero, Y. W. Teh, A fast learning algorithm for deep belief nets,
Neural Computation 18(7), S. 1527-1554, DOI:
[10.1162/neco.2006.18.7.1527](http://dx.doi.org/10.1162/neco.2006.18.7.1527), 2006.

Hinton, G. E., R. R. Salakhutdinov, Reducing the dimensionality of data with neural
networks, Science 313(5786), S. 504-507, DOI:
[10.1126/science.1127647](http://dx.doi.org/10.1126/science.1127647), 2006.

Hinton, G. E., Training products of experts by minimizing contrastive divergence,
Neural Computation 14(8), S. 1711-1800, DOI:
[10.1162/089976602760128018](http://dx.doi.org/10.1162/089976602760128018), 2002.

Hinton, Geoffrey E. et al. (2012). "Improving neural networks by preventing coadaptation of feature detectors". In: Clinical Orthopaedics and Related Research abs/1207.0580. URL : [arxiv.org](http://arxiv.org/abs/1207.0580).

Goodfellow, Ian J. et al. (2013). "Maxout Networks". In: Proceedings of the 30th International Conference on Machine Learning, ICML 2013, Atlanta, GA, USA, 16-21 June 2013, pp. 1319–1327. URL : [jmlr.org](http://jmlr.org/proceedings/papers/v28/goodfellow13.html).

Drees, Martin (2013). "Implementierung und Analyse von tiefen Architekturen
in R". German. Master's thesis. Fachhochschule Dortmund.

Rueckert, Johannes (2015). "Extending the Darch library for deep
architectures". Project thesis. Fachhochschule Dortmund.
URL: [saviola.de](http://static.saviola.de/publications/rueckert_2015.pdf).
