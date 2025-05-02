import sys
import os

if len(sys.argv) < 3:
    print( "ERROR give inputPath and outputpath")
    print( "eg: python scpEOS.py /store/user/johnda/condor/nominal/data2018_b0p60p3/hists_b0p60p3.root . ")
    print( " \t exiting... ")
    sys.exit(-1)

print(sys.argv)
inFileFullPAth = sys.argv[1]
outFileFullPAth = sys.argv[2]
fileName = inFileFullPAth.split("/")[-1]
tempPath = "/uscms/home/jda102/nobackup/forSCP/"

#LPC = "jda102@cmslpc-sl7.fnal.gov"
LPC = "jda102@cmslpc-el9.fnal.gov"
EOSPath = "root://cmseos.fnal.gov/"
cmd = "ssh "+LPC+"  xrdcp "+EOSPath+inFileFullPAth+" "+tempPath
print(cmd)
os.system(cmd)

cmd = "scp "+LPC+":"+tempPath+fileName+" "+outFileFullPAth
print( cmd)
os.system(cmd)

cmd = "ssh "+LPC+" rm "+tempPath+fileName
print( cmd)
os.system(cmd)
