#!/bin/bash

xmlFile=$1

grep "sample" $xmlFile|grep "processed>false"|grep "downloaded>true"|sed 's/<sample><name>//g'|sed 's=</name><downloaded>true</downloaded><processed>false</processed>==g'
