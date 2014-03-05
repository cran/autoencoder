\name{visualize.hidden.units}
\alias{visualize.hidden.units}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Visualize features learned by a sparse autoencoder
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Visualizes features learned by a sparse autoencoder, by plotting (norm bounded) input images that maximally activate each of the hidden units of the trained autoencoder. Here it is assumed that the autoencoder is trained on a set of images of size Nx.patch by Ny.patch (in pixels).
}
\usage{
visualize.hidden.units(object, Nx.patch, Ny.patch)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
%%     ~~Describe \code{object} here~~
an object of class \code{autoencoder} produced by the \code{autoencode} function, and containing information (architecture, weights, biases, unit type, etc.) about the autoencoder network.
}
  \item{Nx.patch}{
%%     ~~Describe \code{Nx.patch} here~~
width (in pixels) of images in data set used for training the autoencoder. See 'Examples'.
}
  \item{Ny.patch}{
%%     ~~Describe \code{Ny.patch} here~~
height (in pixels) of images in data set used for training the autoencoder. See 'Examples'.
}
}

\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
A figure in which each square shows the (norm bounded) input image of size Nx.patch by Ny.patch (in pixels) that maximally activates each of the hidden units. These squares represent the features learned by the autoencoder from the unlabeled data used for its training.
}

\author{
%%  ~~who you are~~
Yuriy Tyshetskiy
}

\examples{
## Load a pre-trained autoencoder object with N.input=100 and N.hidden=10*10,
## trained on unlabeled set of 5000 image patches of size 
## Nx.patch=10 by Ny.patch=10 pixels, 
## randomly cropped from 10 nature photos, and visualize the features 
## learned by its hidden units:

data('autoencoder_Ninput=100_Nhidden=100_rho=1e-2')          

## Visualize hidden units' learned features:
visualize.hidden.units(autoencoder.object,Nx.patch=10,Ny.patch=10)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~autoencoder }
\keyword{ ~sparse autoencoder}
\keyword{ ~features visualization}
\keyword{ ~deep learning }% __ONLY ONE__ keyword per line
