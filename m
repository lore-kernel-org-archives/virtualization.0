From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lhype booting debootstrapped debian image over nfsroot,
	partial success
Date: Tue, 09 Jan 2007 17:34:16 +1100
Message-ID: <1168324456.19646.104.camel@localhost.localdomain>
References: <20070107224644.GA1521@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070107224644.GA1521@outpost.ds9a.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-01-07 at 23:46 +0100, bert hubert wrote:
> When it does work, things sort of work, but it looks like timing is
> seriously off:
> =

> intel:~# uptime
>  01:52:22 up -24855 days, -3:-14,  1 user,  load average: nan, nan, 0.03
> =

> The clock appears to run around 5 times too slow.

OK, a one-character typo meant I was returning "usec" not "sec" through
the "get_wallclock" hypercall.  Hence time was completely random; I'm
amazed it booted!

I've also made the guest use the TSC, and now time runs at normal speed.
ssh still does not install due to lack of randomness; the next patch
will fix this (the host will tell us which devices are capable of
supplying randomness, ie. not ones connecting to other guests).

Thanks!
Rusty.
