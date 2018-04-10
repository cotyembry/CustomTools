
#gp - I called it to stand for git push (and I wanted it to be super short to type)

# if (not defined $argument1) {}
# if (defined $argument1) {}
$argument1 = $ARGV[0];				#$argument1 will be the commit message\
$numberOfArguments = scalar @ARGV;
$commitMessage = "";
for($i = 0; $i < $numberOfArguments; $i++) {
	if($i == 0) {
		$commitMessage = "$ARGV[$i]";
	}
	else {
		$commitMessage = "$commitMessage $ARGV[$i]";
	}
}

if(defined $argument1) {
	#if here, this means at least one work was passed in to be put as the commit message
	system "git add -A";
	system "git commit -m \"$commitMessage\"";
	system "git push origin master";
}
else {
	system "git add -A";
	system "git commit -m \"updating files\"";
	system "git push origin master";
}
