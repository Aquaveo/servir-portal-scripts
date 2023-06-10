import cfbuild
import sys

    

path_to_file = sys.argv[1]
path_to_ncml = sys.argv[2]
path_to_updated_file = sys.argv[3]

############## If the the ncml file has already be created ###################

# Build a dataset object
ds = cfbuild.Dataset(path_to_file, conventions='CF-1.9')

# Build an ncml object
ncml = cfbuild.NCML(path_to_ncml, ds)

# Generate the new netCDF dataset and file
ncml.to_nc(path_to_updated_file)
