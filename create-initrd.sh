mkdir tmp-initrd
( cd tmp-initrd && find . | cpio -o -H newc ) | gzip > initrd.gz
