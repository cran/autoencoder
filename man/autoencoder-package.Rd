\name{autoencoder-package}
\alias{autoencoder-package}
\alias{autoencoder}
\docType{package}
\title{
Implementation of sparse autoencoder for automatic learning of representative features from unlabeled data. 
}
\description{
The package implements a sparse autoencoder, descibed in Andrew Ng's notes (see the reference below), that can be used to automatically learn features from unlabeled data. These features can then be used, e.g., for weight initialization in hidden layers of deep-belief neural networks.
}
\details{
\tabular{ll}{
Package: \tab autoencoder\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-03-05\cr
License: \tab GPL-2\cr
}
The current version of the package consists of two main functions: autoencode() and predict(). See help for autoencode() and predict.autoencoder() for more details on how to use them.
}
\author{
Eugene Dubossarsky (project leader, chief designer), 
Yuriy Tyshetskiy (design, implementation, testing)

Maintainer: Yuriy Tyshetskiy <y.tyshetskiy@usask.ca>
}
\references{
Andrew Ng, Sparse autoencoder (Lecture notes) \url{http://www.stanford.edu/class/archive/cs/cs294a/cs294a.1104/sparseAutoencoder.pdf}
}
\seealso{
\code{\link{autoencode}}, \code{\link{predict.autoencoder}}
}
\keyword{ deep learning, autoencoder, deep belief network }
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
N.hidden = 5*5                ## number of units in the hidden layer
lambda = 0.0002               ## weight decay parameter     
beta = 6                      ## weight of sparsity penalty term 
rho = 0.01                    ## desired sparsity parameter
epsilon <- 0.001              ## a small parameter for initialization of weights 
                              ## as small gaussian random numbers sampled from N(0,epsilon^2)
max.iterations = 2000         ## number of iterations in optimizer

## Train the autoencoder on training.matrix using BFGS optimization method 
## (see help('optim') for details):
## WARNING: the training can take as long as 20 minutes for this dataset!

\dontrun{
autoencoder.object <- autoencode(X.train=training.matrix,nl=nl,N.hidden=N.hidden,
          unit.type=unit.type,lambda=lambda,beta=beta,rho=rho,epsilon=epsilon,
          optim.method="BFGS",max.iterations=max.iterations,
          rescale.flag=TRUE,rescaling.offset=0.001)
          }
## N.B.: Training this autoencoder takes a long time, so in this example we do not run the above 
## autoencode function, but instead load the corresponding pre-trained autoencoder.object.
\dontshow{data('autoencoder_Ninput=100_Nhidden=25_rho=1e-2')}

## Report mean squared error for training and test sets:
cat("autoencode(): mean squared error for training set: ",
round(autoencoder.object$mean.error.training.set,3),"\n")

## Visualize hidden units' learned features:
visualize.hidden.units(autoencoder.object,Nx.patch,Ny.patch)

## Compare the output and input images (the autoencoder learns to approximate 
## inputs in outputs using features learned by the hidden layer):
## Evaluate the output matrix corresponding to the training matrix 
## (rows are examples, columns are input channels, i.e., pixels)
X.output <- predict(autoencoder.object, X.input=training.matrix, hidden.output=FALSE)$X.output 

## Compare outputs and inputs for 3 image patches (patches 7,26,16 from 
## the training set) - outputs should be similar to inputs:
op <- par(no.readonly = TRUE)  ## save the whole list of settable par's.
par(mfrow=c(3,2),mar=c(2,2,2,2))
for (n in c(7,26,16)){
## input image:
  image(matrix(training.matrix[n,],nrow=Ny.patch,ncol=Nx.patch),axes=FALSE,main="Input image",
  col=gray((0:32)/32))
## output image:
  image(matrix(X.output[n,],nrow=Ny.patch,ncol=Nx.patch),axes=FALSE,main="Output image",
  col=gray((0:32)/32))
}
par(op)  ## restore plotting par's
}
