#!/usr/bin/bash
seq 1 100000 | xargs -I{} uuidgen | xargs -I{} mcli cp ~/Downloads/外出申请信息-425.xlsx dkm1/test/{}
