\name{autoencode}
\alias{autoencode}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Train a sparse autoencoder using unlabeled data
}
\description{
\code{autoencode} implements the sparse autoencoder (described in Andrew Ng's lecture notes \url{http://www.stanford.edu/class/archive/cs/cs294a/cs294a.1104/sparseAutoencoder.pdf}). The features learned by the autoencoder trained on unlabeled data are available through weights of the trained autoencoder object. These automatically learned features are useful, e.g., in constructing deep belief networks.
}
\usage{
autoencode(X.train, X.test = NULL, nl = 3, N.hidden, unit.type = c("logistic", "tanh"), 
lambda, beta, rho, epsilon, optim.method = c("BFGS", "L-BFGS-B", "CG"), 
rel.tol=sqrt(.Machine$double.eps), max.iterations = 2000, 
rescale.flag = c(F, T), rescaling.offset = 0.001)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X.train}{
%%     ~~Describe \code{X.train} here~~
a matrix of training data, with rows corresponding to training examples, and columns corresponding to input channels. For example, if training data consists of 10x10-pixel images, then X.train has 100 columns corresponding to each pixel.
}
  \item{X.test}{
%%     ~~Describe \code{X.test} here~~
an optional matrix of test data in the same format as \code{X.train}, used for testing of the trained autoencoder by evaluating the squared error for the test data set.
}
  \item{nl}{
%%     ~~Describe \code{nl} here~~
number of layers in the autoencoder (default is 3 layers: input, hidden, output).
}
  \item{N.hidden}{
%%     ~~Describe \code{N.hidden} here~~
a vector of numbers of units (neurons) in each of the hidden layers. For \code{nl=3} (default architecture) this is just the number of units in the single hidden layer of the autoencoder.
}
  \item{unit.type}{
%%     ~~Describe \code{unit.type} here~~
type of units used in the autoencoder, defined by the activation function of the units ('logistic' or 'tanh').
}
  \item{lambda}{
%%     ~~Describe \code{lambda} here~~
weight decay parameter controlling the relative importance of the regularization term in the autoencoder's cost function.
}
  \item{beta}{
%%     ~~Describe \code{beta} here~~
weight of sparsity penalty term.
}
  \item{rho}{
%%     ~~Describe \code{rho} here~~
sparsity parameter, constrains the average (over training examples) activation of hidden units. Typically should be a small value close to zero (hence sparse autoencoder).
}
  \item{epsilon}{
%%     ~~Describe \code{epsilon} here~~
a small parameter for initialization of autoencoder weights as small gaussian random numbers sampled from the normal distribution N(0,epsilon^2).
}
  \item{optim.method}{
%%     ~~Describe \code{optim.method} here~~
the optimization method to be used for searching the minimum of the cost function. See \code{method} in \code{help('optim')} for details.
}
  \item{rel.tol}{
%%     ~~Describe \code{rel.tol} here~~
relative convergence tolerance determining the convergence of \code{optim()} optimizer. The algorithm stops if it is unable to reduce the value by a factor of \code{reltol * (abs(value) + reltol)} at a step. Defaults to \code{sqrt(.Machine$double.eps)}, typically about \code{1e-8}. 
}
  \item{max.iterations}{
%%     ~~Describe \code{max.iterations} here~~
maximum number of iterations in searching for cost function minimum. Defaults to 2000.
}
  \item{rescale.flag}{
%%     ~~Describe \code{rescale.flag} here~~
a logical flag indicating whether to uniformly rescale the training matrix to make sure the values of all input channels are within the range of unit outputs (the range is [0,1] for \code{'logistic'} units, and [-1,1] for \code{'tanh'} units).
}
  \item{rescaling.offset}{
%%     ~~Describe \code{rescaling.offset} here~~
a small non-negative value used in rescaling to \code{[offset,1-offset]} for \code{'logistic'} units, and to \code{[-1+offset,1-offset]} for \code{'tanh'} units. Defaults to 0.001.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
An autoencoder neural network is an unsupervised learning algorithm that applies backpropagation to adjust its weights, attempting to learn to make its target values (outputs) to be equal to its inputs. In other words, it is trying to learn an approximation to the identity function, so as its output is similar to its input, for all training examples. With the sparsity constraint enforced (requiring that the average, over training set, activation of hidden units be small), such autoencoder automatically learns useful features of the unlabeled training data, which can be used for, e.g., data compression (with losses), or as features in deep belief networks.

The training is performed by optimizing the autoencoder's cost function \code{J(W,b)} that depends on the autoencoder's weights W and biases b. The optimization (searching for a local minimum) is performed with the \code{\link{optim}} function using one of the three methods: 'BFGS', 'L-BFGS-B', or 'CG' (see details in \code{help(optim)}).

After the optimization converges, the mean squared error between the output and input matrix (either the training matrix, or a test matrix) is evaluated as a measure of goodness of fit of the autoencoder.

For the autoencoder to work well, one must rescale, if necessary, the training matrix to make sure all the input channels (and hence all the output channels) have values within the range of unit activation function values: [0,1] for 'logistic' units, [-1,1] for 'tanh' units. If rescaling flag is true (\code{rescale.flag=TRUE}), the input matrix is rescaled uniformly using its minimum and maximum elements \code{min(X.train)} and \code{max(X.train)} as

\code{X.train.rescaled=(X.train-min(X.train))/(max(X.train)-min(X.train))} for 'logistic' units,
and \code{X.train.rescaled=2*(X.train-min(X.train))/(max(X.train)-min(X.train))-1} for 'tanh' units.

The minimum and maximum elements of the training matrix are then passed to the object returned by the function, to be used for rescaling input data in \code{predict.autoencode} function, for compatibility with the rescaling of the data used for training the autoencoder. 
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
An object of class \code{autoencoder}, containing a list with the following components:
\item{W}{ a list of weight matrices in the format \code{W[[l]][i,j]}, where \code{l} is the number of the layer, \code{i} and \code{j} are the row and column indices. An element \code{W[[l]][i,j]} is the weight associated with a connection between unit \code{j} in layer \code{l} and unit \code{i} in layer \code{l+1}. }
\item{b}{ a list of biases; \code{b[[l]][i]} is the bias associated with unit \code{i} in layer \code{l+1}. }
\item{unit.type}{type of units used in the autoencoder, the value if the same as \code{unit.type} argument.}
\item{rescaling}{a list with elements \code{rescale.flag} (a logical flag indicating whether rescaling was applied to the training matrix before training the autoencoder), \code{rescaling.min}, and \code{rescaling.max} (the minimum and maximum elements of the training matrix used for rescaling - see 'Details').}
\item{mean.error.training.set}{average, over all training matrix rows (training examples), sum of \code{(X.output-X.train)^2}, where \code{X.output} is the matrix of autoencoder outputs corresponding to the training matrix \code{X.train} (i.e., each row in \code{X.output} is a result of the feed-forward pass of the corresponding training example through the trained autoencoder).}
\item{mean.error.test.set}{average, over all test matrix rows (test examples), sum of \code{(X.output-X.test)^2}, where \code{X.output} is the matrix of autoencoder outputs corresponding to the test matrix \code{X.test}(i.e., each row in \code{X.output} is a result of the feed-forward pass of the corresponding test example through the trained autoencoder).}
}
\references{
%% ~put references to the literature/web site here ~
See Andrew Ng's lecture notes at \url{http://www.stanford.edu/class/archive/cs/cs294a/cs294a.1104/sparseAutoencoder.pdf}
}
\author{
%%  ~~who you are~~
Eugene Dubossarsky (project leader, chief designer), Yuriy Tyshetskiy (design, implementation, testing)
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{predict.autoencoder}}
}
\examples{
## Train the autoencoder on unlabeled set of 5000 image patches of 
## size Nx.patch by Ny.patch, randomly cropped from 10 nature photos:
## Load a training matrix with rows corresponding to training examples, 
## and columns corresponding to input channels (e.g., pixels in images):
data('training_matrix_N=5e3_Ninput=100')  ## the matrix contains 5e3 image 
                                          ## patches of 10 by 10 pixels

## Set up the autoencoder architecture:
nl=3                          ## number of layers (default is 3: input, hidden, output)
unit.type = "logistic"        ## specify the network unit type, i.e., the unit's 
                              ## activation function ("logistic" or "tanh")
Nx.patch=10                   ## width of training image patches, in pixels
Ny.patch=10                   ## height of training image patches, in pixels
N.input = Nx.patch*Ny.patch   ## number of units (neurons) in the input layer (one unit per pixel)
N.hidden = 10*10                ## number of units in the hidden layer
lambda = 0.0002               ## weight decay parameter     
beta = 6                      ## weight of sparsity penalty term 
rho = 0.01                    ## desired sparsity parameter
epsilon <- 0.001              ## a small parameter for initialization of weights 
                              ## as small gaussian random numbers sampled from N(0,epsilon^2)
max.iterations = 2000         ## number of iterations in optimizer

## Train the autoencoder on training.matrix using BFGS optimization method 
## (see help('optim') for details):
## WARNING: the training can take a long time (~1 hour) for this dataset!

\dontrun{
autoencoder.object <- autoencode(X.train=training.matrix,nl=nl,N.hidden=N.hidden,
          unit.type=unit.type,lambda=lambda,beta=beta,rho=rho,epsilon=epsilon,
          optim.method="BFGS",max.iterations=max.iterations,
          rescale.flag=TRUE,rescaling.offset=0.001)
          }
## N.B.: Training this autoencoder takes a long time, so in this example we do not run the above 
## autoencode function, but instead load the corresponding pre-trained autoencoder.object.
\dontshow{data('autoencoder_Ninput=100_Nhidden=100_rho=1e-2')}

## Report mean squared error for training and test sets:
cat("autoencode(): mean squared error for training set: ",
round(autoencoder.object$mean.error.training.set,3),"\n")

## Extract weights W and biases b from autoencoder.object:
W <- autoencoder.object$W
b <- autoencoder.object$b
## Visualize hidden units' learned features:
visualize.hidden.units(autoencoder.object,Nx.patch,Ny.patch)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~autoencoder }
\keyword{ ~sparse autoencoder}
\keyword{ ~deep learning }% __ONLY ONE__ keyword per line
