$output = qx(ipconfig 2>&1); 
# print "$output";
@lines = split /\n/, $output;
$ipaddressFinal = "";
# for($i = 0; i < scalar @lines)
$outputLength = scalar @lines;
$foundSection = 0;
for($i = 0; $i < $outputLength; $i++) {								#this for loop gets the ipaddress
	print "$lines[$i]\n";
	if($lines[$i] =~ m/Wireless LAN adapter Wi-Fi 2/gi) {
		$foundSection++;
		print "$lines[$i]\n";
	}
	if($foundSection == 1 && $lines[$i] =~ m/IPv4 Address/gi) {
		@ipaddress = split ": ", $lines[$i];
		# print "$ipaddress[1]";
		$ipaddressFinal = @ipaddress[1];
		print "$ipaddressFinal\n\n";
		$foundSection = 2;
	}
}


#now edit the package.json file to use the ipaddress
open $packagejson, "./package.json" or die "Cannot open: $!\n";
open $new, ">", "./package.jsonjce" or die "Cannot open: $!\n";
$foundWebserverLine = 0;
while(<$packagejson>) {
	# if($_ =~ m/host\=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/gi) {						#this matches the host/ipaddress flag
	# 	$_ =~ s/host\=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/host=$ipaddressFinal/;
	# 	print $new $_;
	# 	$foundWebserverLine = 1;
	# }
	if($_ =~ m/\"start\"\:[ ]*\"webpack\-dev\-server/gi) {						#this matches the host/ipaddress flag
		if($_ =~ m/host\=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/gi) {
			$_ =~ s/host\=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/host=$ipaddressFinal/;
		}
		elsif($_ =~ m/webpack\-dev\-server/gi) {
			$_ =~ s/webpack\-dev\-server/webpack\-dev\-server \-\-host=$ipaddressFinal/;	#pass in the --host=n.n.n.n ipaddress

			if($_ =~ m/port\=[0-9]+/gi) {}
			else {																		#if --port=nnnn was not passed in add as default port=8080
				$_ =~ s/webpack\-dev\-server/webpack\-dev\-server \-\-port\=8080 /;
			}
		}

		print $new $_;
		$foundWebserverLine = 1;
	}
	else {
		print $new $_;
	}
}
close $packagejson;
close $new;
#all the above block just did was create a new ./package.jsonjce file that has my current --host=... command line flag set for webpack :/

# system "rm package.jsonjce";

#I couldn't figure out a better way, so I'm just getting it to work for now...I really need to come back and make these two while loops be only 1...and these two times for opening the file to only be once per file...oh well for now
open $packagejson, ">", "./package.json" or die "Cannot open, ./package.json: $!\n";
open $new, "./package.jsonjce" or die "Cannot open: $!\n";

while(<$new>) {
	# print $packagejson $_;
	# print "umm: \n\t:$_\n";
	print $packagejson $_;
}

close $new;
close $packagejson;


if($foundWebserverLine == 0) {
	print "Error: did not find webserver line - in nrs.pl\n\n";
}

# system "type package.jsonjce";

system "npm run start";	#this patches back in my usual `nrs` routine/habit
