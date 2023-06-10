import cfbuild
import sys

    

path_to_file = sys.argv[1]
path_to_ncml = sys.argv[2]


print(path_to_file)

############## If the ncml file needs to be generated ########################

# Build a dataset object
ds = cfbuild.Dataset(path_to_file, conventions='CF-1.9')


# Generate the ncml file from a dataset
ncml = ds.to_ncml(path_to_ncml)


# Stop and update the ncml file
# Generate the new netCDF dataset and file
#ncml.to_nc(path_to_updated_file)

############## If the the ncml file has already be created ###################

# Build a dataset object
#ds = cfbuild.Dataset(path_to_file, conventions='CF-1.9')

# Build an ncml object
#ncml = cfbuild.NCML(path_to_ncml, ds)

# Generate the new netCDF dataset and file
#ncml.to_nc(path_to_updated_file)
