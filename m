From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Wed, 1 Mar 2017 06:14:21 +0200
Message-ID: <20170301060913-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170228050218.GI18844@yliu-dev.sh.intel.com>
	<20170301024951-mutt-send-email-mst@kernel.org>
	<20170301035715.GP18844@yliu-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170301035715.GP18844@yliu-dev.sh.intel.com>
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

On Wed, Mar 01, 2017 at 11:57:15AM +0800, Yuanhan Liu wrote:
> On Wed, Mar 01, 2017 at 03:02:29AM +0200, Michael S. Tsirkin wrote:
> > > > * Descriptor ring:
> > > > 
> > > > Guest adds descriptors with unique index values and DESC_HW set in flags.
> > > > Host overwrites used descriptors with correct len, index, and DESC_HW
> > > > clear.  Flags are always set/cleared last.
> > > 
> > > May I know what's the index intended for? Back referencing a pkt buffer?
> > 
> > Yes and generally identify which descriptor completed. Recall that
> > even though vhost net completes in order at the moment,
> > virtio rings serve devices (e.g. storage) that complete out of order.
> 
> I see, and thanks.
> 
> > > That said, if it's "16: 16" and if we use only 8 bits for batch, we
> > > could still have another 8 bit for anything else, say the number of
> > > desc for a single pkt. With that, the num_buffers of mergeable Rx
> > > header could be replaced.  More importantly, we could reduce a cache
> > > line write if non offload are supported in mergeable Rx path. 
> > 
> > Why do you bother with mergeable Rx without offloads?
> 
> Oh, my bad. I actually meant "without offloads __being used__". Just
> assume the pkt size is 64B and no offloads are used. When mergeable
> Rx is negotiated (which is the default case), num_buffers has to be
> set 1. That means an extra cache line write. For the case of non
> mergeable, the cache line write could be avoid by a trick like what
> the following patch did:
> 
>    http://dpdk.org/browse/dpdk/commit/?id=c9ea670c1dc7e3f111d8139f915082b60c9c1ffe
> 
> It basically tries to avoid writing 0 if the value is already 0:
> the case when no offloads are used.
> So while writing this email, I was thinking maybe we could not set
> num_buffers to 1 when there is only one desc (let it be 0 and let
> num_buffers == 0 imply num_buffers = 1). I'm not quite sure we can
> do that now, thus I checked the DPDK code and found it's Okay.
> 
>     896                 seg_num = header->num_buffers;
>     897
>     898                 if (seg_num == 0)
>     899                         seg_num = 1;
> 
> 
> I then also checked linux kernel code, and found it's not okay as
> the code depends on the value being set correctly:
> 
> ==> 365         u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>     366         struct page *page = virt_to_head_page(buf);
>     367         int offset = buf - page_address(page);
>     368         unsigned int truesize = max(len, mergeable_ctx_to_buf_truesize(ctx));
>     369
>     370         struct sk_buff *head_skb = page_to_skb(vi, rq, page, offset, len,
>     371                                                truesize);
>     372         struct sk_buff *curr_skb = head_skb;
>     373
>     374         if (unlikely(!curr_skb))
>     375                 goto err_skb;
> ==> 376         while (--num_buf) {
> 
> That means, if we want to do that, it needs an extra feature flag
> (either a global feature flag or a desc flag), something like
> ALLOW_ZERO_NUM_BUFFERS. Or even, make it allowable in virtio 1.1
> (virtio 0.95/1.0 won't benifit from it though).
> 
> Does it make sense to you?

Right and then we could use a descriptor flag "header is all 0s".
For virtio 1.0 we could put these in the used ring instead.

> 
> > Make each buffer
> > MTU sized and it'll fit without merging.  Linux used not to, it only
> > started doing this to save memory aggressively. I don't think
> > DPDK cares about this.
> > 
> > > 
> > > 	struct desc {
> > > 	        __le64 addr;
> > > 	        __le16 len;
> > > 	        __le8  batch;
> > > 	        __le8  num_buffers;
> > > 	        __le16 index;
> > > 	        __le16 flags;
> > > 	};
> > 
> > Interesting. How about a benchmark for these ideas?
> 
> Sure, I would like to benchmark it. It won't take long to me. But
> currently, I was still focusing on analysising the performance behaviour
> of virtio 0.95/1.0 (when I get some time), to see what's not good for
> performance and what's can be improved.
> 
> Besides that, as said, I often got interrupted. Moreoever, DPDK v17.05
> code freeze deadline is coming. So it's just a remind that I may don't
> have time for it recently. Sorry for that.
> 
> > > > * Device specific descriptor flags
> > > > We have a lot of unused space in the descriptor.  This can be put to
> > > > good use by reserving some flag bits for device use.
> > > > For example, network device can set a bit to request
> > > > that header in the descriptor is suppressed
> > > > (in case it's all 0s anyway). This reduces cache utilization.
> > > 
> > > Good proposal. But I think it could only work with Tx, where the driver
> > > knows whether the headers are all 0s while filling the desc. But for
> > > Rx, whereas the driver has to pre-fill the desc, it doesn't know. Thus
> > > it still requires filling an header desc for storing it.
> > 
> > I don't see why - I don't think drivers pre-fill buffers in header for RX
> > right now. Why would they start?
> 
> Again, my bad, I meant "prepare" but not "pre-fill". Let me try to explain
> it again. I'm thinking:
> 
> - For Tx, when the header is all 0s, the header could be discarded. We
>   could use one desc for transfering a packet (with a flag NO_HEADER
>   or HEADER_ALL_ZERO bit set)
> 
> - For Rx, the header is filled in the device (or vhost) side. And the
>   driver has to prepare the header desc for each pkt, because the Rx
>   driver has no idea whether it will be all 0s.
> 
>   That means, the header could not be discarded.
> 
> If such a global feature is negotiated, we could also discard the header
> desc as well.
> 
> 	--yliu

Right and again, flags could be added to the used ring to pass extra
info.

> > > Maybe we could introduce a global feature? When that's negotiated, no
> > > header desc need filled and processed? I'm thinking this could also
> > > help the vector implementation I mentioned in another email.
> > 
> > It's possible of course - it's a subset of what I said.
> > Though it makes it less useful in the general case.
> > 
> > > > Note: this feature can be supported in virtio 1.0 as well,
> > > > as we have unused bits in both descriptor and used ring there.
> > > 
> > > Agreed.
> > > 
> > > 	--yliu
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
