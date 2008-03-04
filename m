From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] partial checksum and GSO support for tun/tap.
Date: Tue, 4 Mar 2008 18:47:45 +1100
Message-ID: <200803041847.45500.rusty__41821.552711963$1204617025$gmane$org@rustcorp.com.au>
References: <200801240107.38929.rusty@rustcorp.com.au>
	<200803041202.17202.rusty@rustcorp.com.au>
	<47CCD930.3040200@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47CCD930.3040200@qualcomm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 04 March 2008 16:08:00 Max Krasnyansky wrote:
> > The problem with this approach is that for what I'm doing, the packets
> > aren't nicely arranged somewhere; they're in random process memory.
>
> That's fine. RX/TX descriptors would not contain the data itself. They'd
> contain pointers to actual packets (ie just like the NIC takes physical
> memory address and DMAs data in/out).
> The allows for sending/receiving packets without syscalls and fits nicely
> with the async schemes like GSO.

Yes, yes it does.  That would be a very nice extension (it's orthogonal to 
this patch though, so should we get Dave to take these for 2.6.25?).

And as it happens, virtio already has such a structure: virtio_ring.  See 
linux/virtio_ring.h.

> > The structure is for virtio, I'm just borrowing it for tap because it's
> > already there.  We could rename it and move it out to its own header, but
> > if so we should do that before 2.6.25 is released.
>
> If we do the whole enchilada with the RX/TX rings then we probably do not
> even need it. I'm thinking that RX/TX descriptor would include everything
> you need for the GSO and stuff.
> I meant do not need it for the TUN/TAP driver that is. Is it used anywhere
> else ?

Just for the linux virtio drivers.  Reusing it for tun/tap was an 
afterthought.  It just meant I could pass the same structure straight thru, 
though, which is nice.

The userspace->kernel problem is very similar to the guest->host problem, so 
it doesn't surprise me if we end up with very similar (identical?) 
interfaces.

Take a look at virtio_ring.h, virtio_ring.c and Documentation/lguest/lguest.c 
to see how we use it...

Cheers,
Rusty.
