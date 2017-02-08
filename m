From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Wed, 8 Feb 2017 21:59:09 +0200
Message-ID: <20170208214435-mutt-send-email-mst__2849.75262261487$1486583957$gmane$org@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 08, 2017 at 06:41:40PM +0100, Paolo Bonzini wrote:
> 
> 
> On 08/02/2017 04:20, Michael S. Tsirkin wrote:
> > * Scatter/gather support
> > 
> > We can use 1 bit to chain s/g entries in a request, same as virtio 1.0:
> > 
> > /* This marks a buffer as continuing via the next field. */
> > #define VRING_DESC_F_NEXT       1
> > 
> > Unlike virtio 1.0, all descriptors must have distinct ID values.
> > 
> > Also unlike virtio 1.0, use of this flag will be an optional feature
> > (e.g. VIRTIO_F_DESC_NEXT) so both devices and drivers can opt out of it.
> 
> I would still prefer that we had  _either_ single-direct or
> multiple-indirect descriptors, i.e. no VRING_DESC_F_NEXT.  I can propose
> my idea for this in a separate message.

All it costs us spec-wise is a single bit :) 

The cost of indirect is an extra cache miss.

We couldn't decide what's better for everyone in 1.0 days and I doubt
we'll be able to now, but yes, benchmarking is needed to make
sire it's required. Very easy to remove or not to use/support in
drivers/devices though.

> > * Batching descriptors:
> > 
> > virtio 1.0 allows passing a batch of descriptors in both directions, by
> > incrementing the used/avail index by values > 1.  We can support this by
> > chaining a list of descriptors through a bit the flags field.
> > To allow use together with s/g, a different bit will be used.
> > 
> > #define VRING_DESC_F_BATCH_NEXT 0x0010
> > 
> > Batching works for both driver and device descriptors.
> 
> I'm still not sure how this would be useful.


So this is used at least by virtio-net mergeable buffers to combine
many buffers into a single packet.

Similarly, on transmit linux sometimes supplies packets in batches
(XMIT_MORE flag) if the other side processes them it seems nice to tell
it: there's more to come soon, if you see this it is wise to poll now.

That's why I kind of felt it's better as a standard bit.

>  It cannot be mandatory to
> set the bit, I think, because you don't know when the host/guest is
> going to read descriptors.  So both host and guest always have to look
> ahead one element in any case.

Right but the point is what to do if you find nothing there?
If you saw VRING_DESC_F_BATCH_NEXT it's a hint that
you should poll, there's more to come soon.

> > * Non power-of-2 ring sizes
> > 
> > As the ring simply wraps around, there's no reason to
> > require ring size to be power of two.
> > It can be made a separate feature though.
> 
> Power of 2 ring sizes are required in order to ignore the high bits of
> the indices.  With non-power-of-2 sizes you are forced to keep the
> indices less than the ring size.

Right. So

	if (unlikely(idx++ > size))
		idx = 0;

OTOH ring size that's twice larger than necessary
because of power of two requirements wastes cache.

>  Alternatively you can do this:
> 
> > * Event index would be in the range 0 to 2 * Queue Size
> > (to detect wrap arounds) and wrap to 0 after that.
> > 
> > The assumption is that each side maintains an internal
> > descriptor counter 0 to 2 * Queue Size that wraps to 0.
> > In that case, interrupt triggers when counter reaches
> > the given value.
> 
> but it seems more complicated than just forcing power-of-2 and ignoring
> the high bits.
> 
> Thanks,
> 
> Paolo

Absolutely power of 2 lets you save a branch.
At this stage I'm just recording all the ideas
and then as a next step we can micro-benchmark prototypes
and compare.

-- 
MST
