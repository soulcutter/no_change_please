No Change Please
================

Given a file `menu.txt` containing:

```
$15.05
mixed fruit,$2.15
french fries,$2.75
side salad,$3.35
hot wings,$3.55
mozzarella sticks,$4.20
sampler plate,$5.80
```

This script will try to find a combination of menu items that will result in exact change for the first line.

```
$ script/solve.rb menu.txt
The following combination of items equals $15.05 exactly:
sampler plate,$5.80
hot wings,$3.55
hot wings,$3.55
mixed fruit,$2.15
```

#### Legal Stuff ####
Copyright © Bradley Schaefer. MIT License (see LICENSE file).