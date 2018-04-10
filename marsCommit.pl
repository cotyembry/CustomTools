
# if (not defined $argument1) {}
# if (defined $argument1) {}
if(-d "perlUtils/" && -f "perlUtils/convertProductionXMLToFiles.pl") {  #make sure I'm in the correct directory and the .pl script exists to run on the HealthPic XML export
    system "git push origin master";
}
else {
    print "`marsCommit` or `marscommit` issue: make sure the folder perlUtils/ is in the same path where you are at within the terminal and also make sure perlUtils/convertProductionXMLToFiles.pl exists inside it\n";
}

