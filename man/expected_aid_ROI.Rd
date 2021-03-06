% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geoSIMEX.R
\name{expected_aid_ROI}
\alias{expected_aid_ROI}
\title{Expected Value Aid}
\usage{
expected_aid_ROI(aidData, roiData, probAidAssume, aid.project.amount, aid.precision.code="precision.code", roi.pc1.name="pc1.id", roi.pc2.name="pc2.id", roi.pc3.name="pc3.id", roi.pc4.name="pc4.id", roi.pc5.name="pc5.id", roi.pc6.name="pc6.id", aid.pc1.centroid.name="centroid.pc1.id")
}
\arguments{
\item{aidData}{name of dataframe of aid project data}

\item{roiData}{name of dataframe of ROI data}

\item{roi.prob.aid}{character containing the name of the variable in the ROI dataset which contains areas of ROIs. "area" is the default name in datasets produced by AidData's data extraction tool}

\item{aid.project.amount}{character containing the name of the variable in the aidData dataset which contains aid amounts (e.g., commitment, disbursement). Set value to 1 if interested in number of aid projects rather than dollars.}

\item{aid.precision.code}{character containing the name of the variable in the aidData dataset which contains precision codes for each project. "pc1.id" is the default name in datasets produced by AidData's data extraction tool}

\item{roi.pc1.name}{character containing the name of the variable in the ROI dataset which contains names or IDs of the precision code 1 spatial area that each ROI falls within. "pc1.id" is the default name in datasets produced by AidData's data extraction tool}

\item{roi.pc2.name}{character containing the name of the variable in the ROI dataset which contains names or IDs of the precision code 1 spatial area that each ROI falls within. "pc2.id" is the default name in datasets produced by AidData's data extraction tool}

\item{roi.pc3.name}{character containing the name of the variable in the ROI dataset which contains names or IDs of the precision code 1 spatial area that each ROI falls within. "pc3.id" is the default name in datasets produced by AidData's data extraction tool}

\item{roi.pc4.name}{character containing the name of the variable in the ROI dataset which contains names or IDs of the precision code 1 spatial area that each ROI falls within. "pc4.id" is the default name in datasets produced by AidData's data extraction tool}

\item{roi.pc6.name}{character containing the name of the variable in the ROI dataset which contains names or IDs of the precision code 1 spatial area that each ROI falls within. "pc6.id" is the default name in datasets produced by AidData's data extraction tool}

\item{aid.pc1.centroid.name}{character containing the name of the variable in the aidData dataset which contains names or IDs of a precision code 1 spatial area that the aid project falls within. "centroid.pc1.id" is the default name in datasets produced by AidData's data extraction tool}
}
\description{
\code{expected_aid_ROI} Calculates expected value of aid.
}
\details{
Calculates expected value of aid for each ROI
}
\note{
The function is built to work with data from AidData's data extration tool. The extraction tool can be accessed here: [provide website].
}
\examples{
library(devtools)
install_github("itpir/geoSIMEX")

set.seed(42)

##### Generating Country-Level Dataset #####
numSubcounties <- 120
numSubcountyInCounty <- 2 
numCountyInDistrict <- 3
numDistrictInRegion <- 2

N <- numSubcounties
subcounty <- 1:N
county <- rep(1:(N/numSubcountyInCounty), each=numSubcountyInCounty)
district <- rep(1:(N/(numSubcountyInCounty*numCountyInDistrict)), each=(numSubcountyInCounty*numCountyInDistrict))
region <- rep(1:(N/(numSubcountyInCounty*numCountyInDistrict*numDistrictInRegion)), each=(numSubcountyInCounty*numCountyInDistrict*numDistrictInRegion))
country <- 1

subcountyArea <- runif(N)
probAid_assumed <- runif(N)

subcountyData <- as.data.frame(cbind(subcounty,county,district,region,country,probAid_assumed,subcountyArea))

##### Creating Aid Dataset #####
numberProjects = 50
aidData <- as.data.frame(matrix(NA,nrow=numberProjects,ncol=3))
names(aidData) <- c("aid","trueSubcounty","PC")
aidData$aid <- runif(nrow(aidData)) * 100
probAid_true <- runif(N)
aidData$trueSubcounty <- sample(size=numberProjects,x=c(1:N), prob=probAid_true, replace=TRUE)
aidData$PC  <- sample(size=numberProjects, x=c(1,2,3,4,6), prob=runif(5), replace=TRUE)

##### Calculating Expected Aid #####
subcountyData$expectedAid <- expected_aid_ROI(aidData=aidData, 
                                             aid.project.amount="aid", 
                                             aid.precision.code="PC", 
                                             aid.pc1.centroid.name="trueSubcounty",
                                             roiData=subcountyData, 
                                             roi.prob.aid="probAid_assumed", 
                                             roi.pc1.name="subcounty", 
                                             roi.pc2.name="county", 
                                             roi.pc3.name="district", 
                                             roi.pc4.name="region", 
                                             roi.pc5.name="region", 
                                             roi.pc6.name="country")
}
\author{
AidData
}
