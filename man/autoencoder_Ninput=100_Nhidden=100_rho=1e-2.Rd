\name{autoencoder_Ninput=100_Nhidden=100_rho=1e-2}
\alias{autoencoder.object}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
A trained autoencoder example with 100 hidden units
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
\code{autoencoder.object} is an example object of class \code{autoencoder} containing the weights, biases and
other parameter of a sparse autoencoder with \code{N.input=100}, \code{N.hidden=100}, with sparsity parameter
\code{rho=0.01}, trained on a dataset of 5000 image patches of 10 by 10 pixels, randomly cropped from decoloured nature photos.
}
\usage{data('autoencoder_Ninput=100_Nhidden=100_rho=1e-2')}
\format{
  The format is:
 chr "autoencoder_Ninput=100_Nhidden=100_rho=1e-2"
}
\examples{
## Load a pre-trained autoencoder object with N.input=100 and N.hidden=10*10,
## trained on unlabeled set of 5000 image patches of size Nx.patch by Ny.patch, 
## randomly picked from 10 nature photos, and visualize the features 
## learned by its hidden units:

data('autoencoder_Ninput=100_Nhidden=100_rho=1e-2')

## Visualize hidden units' learned features:
visualize.hidden.units(autoencoder.object,Nx.patch=10,Ny.patch=10)
}
\keyword{datasets}
