From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 8/8] virtio: console: struct ports for multiple ports per
	device.
Date: Tue, 10 Nov 2009 17:27:03 +1030
Message-ID: <200911101727.03491.rusty@rustcorp.com.au>
References: <1257834450..rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257834450..rusty@rustcorp.com.au>
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Nov 2009 04:57:30 pm Rusty Russell wrote:
> 
> Rather than assume a single port, add a 'struct ports' with an array
> of ports.  Currently, there's always only one, but that will change.

Now, from here we need several more patches.  At least:

1) Generalize the output path so we can sleep, rather than spinning.
   This means a non-NULL callback, a 'done' flag and a struct completion.

2) Do we really need more than input buffer at a time?  If not, it's easy to
   generalize the input callback.  This will be slow, but shouldn't be a
   problem.

3) Add a header.  I suggest we change your proposed format a little, rather
   than an explicit length use a "continues" bit:

	struct virtio_console_header {
		/* Port number */
		__u32 id;
		/* VIRTIO_CONSOLE_HDR_CONTROLMSG, VIRTIO_CONSOLE_HDR_CONTINUES. */
		__u32 flags;
	} __attribute__((packed));

   This should be really easy to construct, and for input in the !multiport
   path we can fake one up.  We ignore CONTINUES on input since we don't have
   a userspace API which understands framing (we'd need recvmsg).

4) Hook it all together with the new feature bit.

5) Add the debugfs and sysfs stuff in stages.

6) See if we really need throttling now we're only allowing 1 buffer at a
   time.

Cheers,
Rusty.
