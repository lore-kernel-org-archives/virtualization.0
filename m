From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 8/8] virtio: console: struct ports for multiple ports
	per device.
Date: Tue, 10 Nov 2009 12:54:14 +0530
Message-ID: <20091110072414.GA17361@amit-x200.redhat.com>
References: <1257834450..rusty@rustcorp.com.au>
	<200911101727.03491.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911101727.03491.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Nov 10 2009 [17:27:03], Rusty Russell wrote:
> On Tue, 10 Nov 2009 04:57:30 pm Rusty Russell wrote:
> > 
> > Rather than assume a single port, add a 'struct ports' with an array
> > of ports.  Currently, there's always only one, but that will change.
> 
> Now, from here we need several more patches.  At least:

Hey Rusty,

Thanks. I'll look through these.

I've split up my code as well, have put it up at

http://git.kernel.org/?p=linux/kernel/git/amit/virtio-console.git


> 1) Generalize the output path so we can sleep, rather than spinning.
>    This means a non-NULL callback, a 'done' flag and a struct completion.

Instead of the buffer pool? I think we can go with the buffer pool of
fixed-sized buffers, but a lot lesser than the 1024 I had.

(Also meshes with the vnc comment below)

On the other hand, performance isn't critical, so we could do away with
the pool.

> 2) Do we really need more than input buffer at a time?  If not, it's easy to
>    generalize the input callback.  This will be slow, but shouldn't be a
>    problem.

In my testing of a vnc clipboard copy/paste, the vnc client only sent the
clipboard data once and didn't bother about retransmitting if write()
returned < len. It's a problem with the vnc client I used (tigervnc, which is
based off tightvnc) though but adding that support would hurt?

> 3) Add a header.  I suggest we change your proposed format a little, rather
>    than an explicit length use a "continues" bit:
> 
> 	struct virtio_console_header {
> 		/* Port number */
> 		__u32 id;
> 		/* VIRTIO_CONSOLE_HDR_CONTROLMSG, VIRTIO_CONSOLE_HDR_CONTINUES. */
> 		__u32 flags;
> 	} __attribute__((packed));

Good idea.
 
>    This should be really easy to construct, and for input in the !multiport
>    path we can fake one up.  We ignore CONTINUES on input since we don't have
>    a userspace API which understands framing (we'd need recvmsg).

The header should only be sent (and expected) in the multiport case, so
this won't matter when the .._F_MULTIPORT feature is not found.

> 4) Hook it all together with the new feature bit.

I've actually split it into 4 feature bits:
MULTIPORT means multiple ports and a header
THROTTLE to save host and guest from OOM
CACHING to allow ports to buffer data even after the char device is
  closed
UNPLUG to allow port unplug

(I added these as part of the splitting effort because they're now in
individual patches)

> 5) Add the debugfs and sysfs stuff in stages.

Agreed (and have done in my scratch series).

> 6) See if we really need throttling now we're only allowing 1 buffer at a
>    time.

That also depends if we cache data per port -- the throttling I had was
for the per-port unconsumed buffers.

Thanks again,

		Amit
