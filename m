From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Tue, 8 Apr 2008 08:34:55 +1000
Message-ID: <200804080834.56943.rusty__23132.3831867941$1207620378$gmane$org@rustcorp.com.au>
References: <12555.1207590874@vena.lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12555.1207590874@vena.lwn.net>
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
To: Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 08 April 2008 03:54:34 Jonathan Corbet wrote:
> Hey, Rusty,
>
> > For virtualization, we've developed virtio_ring for efficient
> > communication. This would also work well for userspace-kernel
> > communication, particularly for things like the tun device.  By using the
> > same ABI, we can join guests to the host kernel trivially.
>
> I'm *sure* you meant to document that somewhat non-trivial proposed new
> kernel API as soon as you got a moment.

Actually, yes.  But I wanted to get it out there before I start the treck 
across to the virtualization summit.

A few points:
'The page alignment for the used array is important - that array might be 
mapped separately into kernel space.'
   Well, the used array is written by one side only, so it's possible to split 
the ring here and make each part r/o to the other side.  More importantly, a 
page boundary is almost certainly a cacheline boundary, and we already have a 
userspace interface for it.

'Note that the flags fields in the vring_avail and vring_used structures 
appear to be unused.'
   virtio uses these for wakeup/interrupt suppression.  It's a cheap way to 
avoid hypercalls, and we can use them the same way to avoid system calls (you 
set the suppression bit while you're actually looking at the ring).

The need for the kmap (and hence the atomic horror) has now been alleviated: I 
changed the shinfo destructor code to allow the destructor to hold onto the 
skb data so it can queue it and free it later.

BTW, the only place currently where both output and input buffers are used is 
the virtio_blk driver doing a read, where the header describes the operation, 
and the other buffers are overwritten with the data.

Thanks!
Rusty.
