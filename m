From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Wed, 8 Feb 2017 18:41:40 +0100
Message-ID: <240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 08/02/2017 04:20, Michael S. Tsirkin wrote:
> * Scatter/gather support
> 
> We can use 1 bit to chain s/g entries in a request, same as virtio 1.0:
> 
> /* This marks a buffer as continuing via the next field. */
> #define VRING_DESC_F_NEXT       1
> 
> Unlike virtio 1.0, all descriptors must have distinct ID values.
> 
> Also unlike virtio 1.0, use of this flag will be an optional feature
> (e.g. VIRTIO_F_DESC_NEXT) so both devices and drivers can opt out of it.

I would still prefer that we had  _either_ single-direct or
multiple-indirect descriptors, i.e. no VRING_DESC_F_NEXT.  I can propose
my idea for this in a separate message.

> * Batching descriptors:
> 
> virtio 1.0 allows passing a batch of descriptors in both directions, by
> incrementing the used/avail index by values > 1.  We can support this by
> chaining a list of descriptors through a bit the flags field.
> To allow use together with s/g, a different bit will be used.
> 
> #define VRING_DESC_F_BATCH_NEXT 0x0010
> 
> Batching works for both driver and device descriptors.

I'm still not sure how this would be useful.  It cannot be mandatory to
set the bit, I think, because you don't know when the host/guest is
going to read descriptors.  So both host and guest always have to look
ahead one element in any case.

> * Non power-of-2 ring sizes
> 
> As the ring simply wraps around, there's no reason to
> require ring size to be power of two.
> It can be made a separate feature though.

Power of 2 ring sizes are required in order to ignore the high bits of
the indices.  With non-power-of-2 sizes you are forced to keep the
indices less than the ring size.  Alternatively you can do this:

> * Event index would be in the range 0 to 2 * Queue Size
> (to detect wrap arounds) and wrap to 0 after that.
> 
> The assumption is that each side maintains an internal
> descriptor counter 0 to 2 * Queue Size that wraps to 0.
> In that case, interrupt triggers when counter reaches
> the given value.

but it seems more complicated than just forcing power-of-2 and ignoring
the high bits.

Thanks,

Paolo
