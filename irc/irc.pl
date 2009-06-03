#!/usr/local/bin/perl -w
# irc.pl
# A simple IRC robot.
# Usage: perl irc.pl

# Found at http://oreilly.com/pub/h/1964

use strict;

# We will use a raw socket to connect to the IRC server.
use IO::Socket;

my ($nick, $pass, $channel, $login) = @ARGV;

die "Usage: perl irc.pl nick password \\#channel optional_username" unless defined $nick and defined $pass and defined $channel;

$login = $nick unless defined $login;

# The server to connect to and our details.
my $server = "irc.freenode.net";

# Connect to the IRC server.
my $sock = new IO::Socket::INET(PeerAddr => $server,
                                PeerPort => 6667,
                                Proto => 'tcp') or
                                    die "Can't connect\n";

# Log on to the server.
print $sock "NICK $nick\r\n";
print $sock "USER $login 8 * :Perl IRC Hacks Robot\r\n";

#print $sock "PASS $pass";

# Read lines from the server until it tells us we have connected.
while (my $input = <$sock>) {
    # Check the numerical responses from the server.
    if ($input =~ /004/) {
        # We are now logged in.
        last;
    }
    elsif ($input =~ /433/) {
        die "Nickname is already in use.";
    }
}

# Authenticate to nickserv
print $sock "PRIVMSG nickserv : identify $nick $pass \r\n";

# Join the channel.
print $sock "JOIN " . $channel . "\r\n";

# Read the input until we get a line with [channel name] in it, which is the names list.
# At that point we're done with welcome messages, so we should start logging.
while (my $input = <$sock>) {
    #print $input . "\n";
  if ($input =~ m/\[$channel\]/) {
    last;
    #die;
  }
}

# print $sock "PRIVMSG " . $channel . " :isnull: !fortune \r\n";

# Keep reading lines from the server.
while (my $input = <$sock>) {
  #do this for each line of input we get from the IRC channel
    chop $input;
    if ($input =~ /^PING(.*)$/i) {
        # We must respond to PINGs to avoid being disconnected.
        # not sure if this is really true --NS
        print $sock "PONG $1\r\n";
    }
    else {
      # Print the raw line received by the bot.
      print "$input\n";
    }
}
