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
    print color('bold red'), "WEB BRUTE FORCER"
    print color('bold white'), "FOR WordPress , Joomla , DruPal , OpenCart , Magento"
}