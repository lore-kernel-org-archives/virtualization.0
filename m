From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] packed (virtio-net) headers
Date: Wed, 1 Mar 2017 03:28:25 +0200
Message-ID: <20170301030815-mutt-send-email-mst__15905.2242445343$1488332020$gmane$org@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170228054719.GJ18844@yliu-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170228054719.GJ18844@yliu-dev.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 28, 2017 at 01:47:19PM +0800, Yuanhan Liu wrote:
> Hi,
> 
> For virtio-net, we use 2 descs for representing a (small) pkt. One for
> virtio-net header and another one for the pkt data. And it has two issues:
> 
> - the desc buffer for storing pkt data is halfed
> 
>   Though we later introduced 2 more options to overcome this: ANYLAY_OUT
>   and indirect desc. The indirect desc has another issue: it introdues
>   an extra cache line visit.

So if we don't care about this part, we could maybe just add
a descriptor flag that puts the whole header in the descriptor.

> - virtio-net header could be scattered
> 
>   Assume the ANYLAY_OUT case, whereas the headered is prepened before
>   each mbuf (or skb in kernel). In DPDK, a burst recevice in vhost pmd
>   means 32 different cache visit for virtio header.
> 
>   For the legacy layout and indirect desc, the cache issue could somehone
>   diminished a bit: we could arrange the virtio header in a same memory
>   block and let the header desc point to the right one.
> 
>   But it's still not good enough: the virtio-net headers aren't accessed
>   in batch: they have to be accessed one by one (by reading the desc).
>   That said, it's still not that good for cache utilization.
> 
> 
> And I'm proposing packed header:
> 
> - put all virtio-net header in a memory block.
> 
>   A burst size of 32 pkts need only access (32 * 12) / 64 = 6 cache lines.
>   While before, it could be 32 cache lines.
> 
> - introduce a header desc to reference above memory block.
> 
>   desc->addr = starting addr of net headers mem block
>   desc->len  = size of all net virtio net headers (burst size * header size)
> 
> Thus, in a burst size of 32, we only need 33 descs: one for headers and
> others for store corresponding pkt data. More importantly, we could use
> the "len" field for computing the batch size. We then could load the
> virtio net headers at once; we could also prefetch all the descs at once.
> 
> Note it could also be adapted to virtio 0.95 and 1.0. I also made a simple
> prototype with DPDK (yet again, it's Tx path only), I saw an impressive
> boost (about 30%) in a mirco benchmark.
> 
> I think such proposal may should also help other devices, too, if they
> also have a small header for each data.
> 
> Thoughts?
> 
> 	--yliu

That's great. An alternative might be to add an array of headers parallel
to array of descriptors and indexed by head. A bit in the descriptor
would then be enough to mark such a header as valid.

It's also an alternative way to pass in batches for virtio 1.1.

This has an advantage that it helps non-batched workloads as well
if enough packets end up in the ring, but maybe this
predicts on the CPU in a worse way. Worth benchmarking?

I hope above thoughts are helpful, but -

code walks - if you can show real gains I'd be inclined
to say let's go with it. You don't necessarily need to implement and
benchmark all possible ideas others can come up with :)
(though that's just me not speaking for anyone else -
 we'll have to put it on the TC ballot of course)

--  
MST
