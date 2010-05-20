From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Thu, 20 May 2010 14:31:50 +0930
Message-ID: <201005201431.51142.rusty__48916.8232110844$1274331757$gmane$org@rustcorp.com.au>
References: <20100505205814.GA7090@redhat.com>
	<201005191709.16401.rusty@rustcorp.com.au>
	<4BF39C12.7090407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4BF39C12.7090407@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 19 May 2010 05:36:42 pm Avi Kivity wrote:
> > Note that this is a exclusive->shared->exclusive bounce only, too.
> >    
> 
> A bounce is a bounce.

I tried to measure this to show that you were wrong, but I was only able
to show that you're right.  How annoying.  Test code below.

> Virtio is already way too bouncy due to the indirection between the 
> avail/used rings and the descriptor pool.

I tried to do a more careful analysis below, and I think this is an
overstatement.

> A device with out of order 
> completion (like virtio-blk) will quickly randomize the unused 
> descriptor indexes, so every descriptor fetch will require a bounce.
> 
> In contrast, if the rings hold the descriptors themselves instead of 
> pointers, we bounce (sizeof(descriptor)/cache_line_size) cache lines for 
> every descriptor, amortized.

We already have indirect, this would be a logical next step.  So let's
think about it. The avail ring would contain 64 bit values, the used ring
would contain indexes into the avail ring.

So client writes descriptor page and adds to avail ring, then writes to
index.  Server reads index, avail ring, descriptor page (3).  Writes used
entry (1).  Updates last_used (1).  Client reads used (1), derefs avail (1),
updates last_used (1), cleans descriptor page (1).

That's 9 cacheline transfers, worst case.  Best case of a half-full ring
in steady state, assuming 128-byte cache lines, the avail ring costs are
1/16, the used entry is 1/64.  This drops it to 6 and 9/64 transfers.

(Note, the current scheme adds 2 more cacheline transfers, for the descriptor
table, worst case.  Assuming indirect, we get 2/8 xfer best case.  Either way,
it's not the main source of cacheline xfers).

Can we do better?  The obvious idea is to try to get rid of last_used and
used, and use the ring itself.  We would use an invalid entry to mark the
head of the ring.

Any other thoughts?
Rusty.
