use Win32::Clipboard;
use MIME::Base64;

$CLIP = Win32::Clipboard();


$CLIP->Set("some text to copy into the clipboard");

print "Clipboard contains: ", $CLIP->Get(), "\n";
$CLIP->Empty();

$CLIP->WaitForChange();
print "Clipboard has changed!\n";


#bring up the snipping dialogue
#now the contents of what is cropped should be in the clipboard
print "Clipboard contains: ", $CLIP->Get(), "\n";

# $CLIP->WaitForChange();

system "snippingtool.exe /clip";




print "Clipboard contains: ", $CLIP->Get(), "\n";


$pathString = "./temp.jpg";

open jceFH, ">", "$pathString" or die "Cannot open file: $pathString\n";


$clipboardContents = $CLIP->Get();

$decoded = decode_base64($clipboardContents);	
binmode jceFH;
print jceFH $decoded;

