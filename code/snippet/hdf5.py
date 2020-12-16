# https://cyrille.rossant.net/moving-away-hdf5/
# http://www.pytables.org/usersguide/optimization.html

# h5py
import h5py
with h5py.File('path', 'a', libver='latest') as f:
  # ...
