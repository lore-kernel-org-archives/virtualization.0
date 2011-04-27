From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH TRIVIAL] Reading the virtio code...
Date: Wed, 27 Apr 2011 09:26:48 +0300
Message-ID: <20110427062648.GA15788@redhat.com>
References: <4DB35D1E.3030509@parallels.com> <87aafcl0so.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87aafcl0so.fsf@rustcorp.com.au>
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
Cc: Rob Landley <rlandley@parallels.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 27, 2011 at 02:59:27PM +0930, Rusty Russell wrote:
> On Sat, 23 Apr 2011 18:13:34 -0500, Rob Landley <rlandley@parallels.com> wrote:
> > From: Rob Landley <rlandley@parallels.com>
> > 
> > Going indirect for only two buffers isn't likely to be a performance win
> > because the kmalloc/kfree overhead for the indirect block can't be cheaper
> > than one extra linked list traversal.
> 
> Unfortunately it's not completely clear.  QEMU sets fairly small rings,
> and the virtio-net driver uses 2 descriptors minimum.  The effect can be
> a real bottleneck for small packets.
> 
> Now, virtio-net could often stuff the virtio_net_hdr in the space before
> the packet data (saving a descriptor) but I think that will need a
> feature bit since qemu (incorrectly) used to insist on a separate
> descriptor for that header.
> 
> > Properly "tuning" the threshold would probably be workload-specific.
> > (One big downside of not going indirect is extra pressure on the table
> > entries, and table size varies.)  But I think that in the general case,
> > 2 is a defensible minimum?
> 
> I'd be tempted to say that once we fill the ring, we should drop the
> threshold.
> 
> Michael?
> 
> Thanks,
> Rusty.

Yes, one idea is to use part of a ring (e.g. 1/4 of a ring) for direct
entries, and the rest for indirect. So we end up with a threshold like

	max(1, vq->num_free - in - out - vq->num * N)

(above is pseudo-code, must take care of unsigned vs signed etc)
and I think I'd try with N = 3/4 or maybe N = 1/2


-- 
MST
