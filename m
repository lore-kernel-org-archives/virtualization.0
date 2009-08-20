From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 3/4] qemu-kvm: vhost-net implementation
Date: Thu, 20 Aug 2009 20:14:32 +0200
Message-ID: <200908202014.32599.arnd__19036.7052368403$1250792269$gmane$org@arndb.de>
References: <cover.1250512448.git.mst@redhat.com>
	<20090817123724.GD10700@redhat.com>
	<1250791027.3080.130.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1250791027.3080.130.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: virtualization@lists.linux-foundation.org, avi@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 20 August 2009, Mark McLoughlin wrote:
>   - I had expected this to be available as:
> 
>       -net raw,ifname=eth2 -net nic,model=virtio
> 
>     I'd prefer it this way, because it means you can use this mode even 
>     without vhost and it's ties in better with the way all other qemu 
>     networking modes work.

Agreed, I made a similar comment in the thread on the kernel interface.

>   - CAP_NET_ADMIN is needed for raw sockets, so for e.g. libvirt I 
>     think we need to be able to support passing the raw socket fd via 
>     the command line and the monitor interface. I don't think we need 
>     that for the vhost fd, it should be safe to allow unprivileged 
>     users access to that, I think.

Agreed on both points. The raw packet socket patch for qemu from
Or Gerlitz addresses the option of passing in a file descriptor for
the socket, IIRC.

>   - I think /dev/vhost makes more sense - we shouldn't need to add
>     another character device if we implement kernel backends for other
>     virtio devices

I believe we should separate them the way that Michael has done.
A character device per logical interface is much more straightforward
that one for different interfaces that you first need to select and
probe. You might also want to give permissions for one kind of
interface to a user or group, but not for another interface.
 
>   - I'd really like vhost to support a 'tap' mode, so that we can still 
>     use a bridge if a NIC isn't available to be assigned. It would 
>     result in this stuff getting much more testing. Options I see:
> 
>        1) Add tap-like functionality to vhost
>        2) Add VHOST_NET_SET_TAP
>        3) Just tell people to set up a tap and bind a raw socket too it
> 
>      IMHO, (2) makes the most sense - it should be much less exta kernel
>     code than (1), and it would be much more convenient than (3)

Yes, see the thread between Michael and me about this. I suggested a
variation of VHOST_NET_SET_TAP, Michael suggested a TAP_GET_SOCKET
ioctl addition to the tap driver.

>     What would be nicer is if loading the kvm module could cause vhost 
>     to be loaded. It's nice that vhost can be used without kvm, but I 
>     think if kvm is loaded it's just very convenient to load vhost too. 

You can do that with modprobe.conf rules.
 
> On Mon, 2009-08-17 at 15:37 +0300, Michael S. Tsirkin wrote:
> > This adds support for vhost-net virtio kernel backend.
> > To enable (assuming device eth2):
> > 1. enable promisc mode or program guest mac in device eth2
> 
> Why can't vhost do this itself?

I think it should not. You might want to extend the interface
to allow passing in UDP and TCP sockets in addition to the
raw sockets, so we can use the same driver for doing in-kernel
handling for the other qemu network options. The kernel should
assume as little as possible about the sockets.
 
> > 2. disable tso, gso, lro, jumbo frames on the card
> >    (disabling lro + jumbo frames should be sufficient,
> >     haven't tested this)
> 
> And this.
> 
> If we leave that up to the user or the management app, we need to expose
> to them what features vhost supports so that they can know in future to
> stop disabling them.

Yes, but it still seems cleaner to do it this in user space for the
reason I mention above.

	Arnd <><
