From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Qemu-devel] Guest bridge setup variations
Date: Thu, 10 Dec 2009 10:19:58 +0100
Message-ID: <200912101019.58555.arnd@arndb.de>
References: <200912081707.42660.arnd@arndb.de> <4B1FFC30.40904@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B1FFC30.40904@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 09 December 2009, Anthony Liguori wrote:
> While we go over all of these things one thing is becoming clear to me.  
> We need to get qemu out of the network configuration business.  There's 
> too much going on here.

Agreed.

> What I'd like to see is the following interfaces supported:
> 
> 1) given an fd, make socket calls to send packets.  Could be used with a 
> raw socket, a multicast or tcp socket.
> 2) given an fd, use tap-style read/write calls to send packets*

yes.

> 3) given an fd, treat a vhost-style interface

This could mean two things, not sure which one you mean. Either the
file descriptor could be the vhost file descriptor, or the socket or tap file
descriptor from above, with qemu operating on the vhost interface itself.

Either option has its advantages, but I guess we should only implement
one of the two to keep it simple.

> I believe we should continue supporting the mechanisms we support 
> today.  However, for people that invoke qemu directly from the command 
> line, I believe we should provide a mechanism like the tap helper that 
> can be used to call out to a separate program to create these initial 
> file descriptors.  We'll have to think about how we can make this 
> integrate well so that the syntax isn't clumsy.

Right. I wonder if this helper should integrate with netcf as an abstraction,
or if we should rather do something generic. It may also be a good idea
to let the helper decide which of the three options you listed to use
and pass that back to qemu unless the user overrides it. The decision
probably needs to be host specific, depending e.g. on the availability
and version of tools (brctl, iproute, maybe tunctl, ...), the respective
kernel modules (vhost, macvlan, bridge, tun, ...) and policy (VEPA, vlan,
ebtables). Ideally the approach should be generic enough to work on
other platforms (BSD, Solaris, Windows, ...).

One thing I realized the last time we discussed the helper approach is
that qemu should not need to know or care about the arguments passed
to the helper, otherwise you get all the complexity back in qemu that
you're trying to avoid. Maybe for 0.13 we can convert -net socket and
-net tap to just pass all their options to the helper and move that code
out of qemu, along with introducting the new syntax.

Another unrelated issue that I think needs to be addressed in a
network code cleanup is adding better support for multi-queue
transmit and receive. I've prepared macvtap for that by letting you
open the chardev multiple times to get one queue per guest CPU,
but that needs to be supported by qemu and virtio-net as well
to actually parallelize network operation. Ideally, two guest CPUs
should be able to transmit and receive on separate queues of the
adapter without ever having to access any shared resources.

	Arnd
