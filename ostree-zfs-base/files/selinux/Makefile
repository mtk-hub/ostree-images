twiest-zfs.pp.bz2: twiest-zfs.pp
	bash -c "bzip2 -f --keep twiest-zfs.pp -c > twiest-zfs.pp.bz2"

twiest-zfs.pp: twiest-zfs---audit.log
	bash -c "cat twiest-zfs---audit.log | audit2allow -M twiest-zfs"

clean:
	/bin/rm -f twiest-zfs.pp twiest-zfs.pp.bz2 twiest-zfs.te
