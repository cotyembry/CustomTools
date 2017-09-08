#login

use DateTime;

my $dt = DateTime->today;
$dateTimeString = $dt->date . "__" . time;

#normalize the arguments passed in as a string to throw to the commit message
$ARGVString = "";
for($i = 0; $i < scalar @ARGV; $i++) {
	$ARGVString	= $ARGVString . $ARGV[$i] . " ";
}


$x = qx(echo "hi: $dateTimeString" > D:/Developer/CustomTools/AppData/loginLogoutStore/timesheet.md);
#capture the output of the command into a variable after its done
$x = qx(git --git-dir=D:/Developer/CustomTools/AppData/loginLogoutStore/.git --work-tree=D:/Developer/CustomTools/AppData/loginLogoutStore/ add -A);
$secondCommand = 'git --git-dir=D:/Developer/CustomTools/AppData/loginLogoutStore/.git --work-tree=D:/Developer/CustomTools/AppData/loginLogoutStore/ commit -m "logging in: ' . $ARGVString . '"';
$x = qx($secondCommand);
print "3: $x\n";
$x = qx(git --git-dir=D:/Developer/CustomTools/AppData/loginLogoutStore/.git --work-tree=D:/Developer/CustomTools/AppData/loginLogoutStore/ push origin master);
