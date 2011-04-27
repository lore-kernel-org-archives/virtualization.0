From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH TRIVIAL] Reading the virtio code...
Date: Wed, 27 Apr 2011 14:59:27 +0930
Message-ID: <87aafcl0so.fsf@rustcorp.com.au>
References: <4DB35D1E.3030509@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DB35D1E.3030509@parallels.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Landley <rlandley@parallels.com>, virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 23 Apr 2011 18:13:34 -0500, Rob Landley <rlandley@parallels.com> wrote:
> From: Rob Landley <rlandley@parallels.com>
> 
> Going indirect for only two buffers isn't likely to be a performance win
> because the kmalloc/kfree overhead for the indirect block can't be cheaper
> than one extra linked list traversal.

Unfortunately it's not completely clear.  QEMU sets fairly small rings,
and the virtio-net driver uses 2 descriptors minimum.  The effect can be
a real bottleneck for small packets.

Now, virtio-net could often stuff the virtio_net_hdr in the space before
the packet data (saving a descriptor) but I think that will need a
feature bit since qemu (incorrectly) used to insist on a separate
descriptor for that header.

> Properly "tuning" the threshold would probably be workload-specific.
> (One big downside of not going indirect is extra pressure on the table
> entries, and table size varies.)  But I think that in the general case,
> 2 is a defensible minimum?

I'd be tempted to say that once we fill the ring, we should drop the
threshold.

Michael?

Thanks,
Rusty.
