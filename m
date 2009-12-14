From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Qemu-devel] Guest bridge setup variations
Date: Mon, 14 Dec 2009 13:09:22 +0100
Message-ID: <200912141309.22472.arnd@arndb.de>
References: <200912081707.42660.arnd@arndb.de>
	<200912101019.58555.arnd@arndb.de> <4B218A10.6000904@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B218A10.6000904@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 11 December 2009, Anthony Liguori wrote:
> Arnd Bergmann wrote:
> >> 3) given an fd, treat a vhost-style interface
> >
> > This could mean two things, not sure which one you mean. Either the
> > file descriptor could be the vhost file descriptor, or the socket or tap file
> > descriptor from above, with qemu operating on the vhost interface itself.
> >
> > Either option has its advantages, but I guess we should only implement
> > one of the two to keep it simple.
> >   
> 
> I was thinking the socket/tap descriptor.

ok.

> > Right. I wonder if this helper should integrate with netcf as an abstraction,
> > or if we should rather do something generic. It may also be a good idea
> > to let the helper decide which of the three options you listed to use
> > and pass that back to qemu unless the user overrides it. The decision
> > probably needs to be host specific, depending e.g. on the availability
> > and version of tools (brctl, iproute, maybe tunctl, ...), the respective
> > kernel modules (vhost, macvlan, bridge, tun, ...) and policy (VEPA, vlan,
> > ebtables). Ideally the approach should be generic enough to work on
> > other platforms (BSD, Solaris, Windows, ...).
> 
> For helpers, I think I'd like to stick with what we currently support, 
> and then allow for a robust way for there to be independent projects 
> that implement their own helpers.   For instance, I would love it if 
> netcf had a qemu network "plugin" helper.

Moving netcf specific qemu helpers into the netcf project sounds good.
I'm not sure what you mean with 'stick to what we currently support',
do you mean with helpers that ship with qemu itself? That sounds
reasonable, though I'd obviously like to make sure they also work
with macvtap, which is currently not supported unless you pass an
open file descriptor into -net tap,fd.

> There's just too much in the networking space all wrapped up in layers 
> of policy decisions.  I think it's time to move it out of qemu.

Yes.

	Arnd
