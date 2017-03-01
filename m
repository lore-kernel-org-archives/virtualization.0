From: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Wed, 1 Mar 2017 12:57:09 +0800
Message-ID: <20170301045709.GQ18844__27073.7676452429$1488675876$gmane$org@yliu-dev.sh.intel.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170228050218.GI18844@yliu-dev.sh.intel.com>
	<20170301024951-mutt-send-email-mst@kernel.org>
	<20170301035715.GP18844@yliu-dev.sh.intel.com>
	<20170301060913-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170301060913-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 01, 2017 at 06:14:21AM +0200, Michael S. Tsirkin wrote:
> > > > That said, if it's "16: 16" and if we use only 8 bits for batch, we
> > > > could still have another 8 bit for anything else, say the number of
> > > > desc for a single pkt. With that, the num_buffers of mergeable Rx
> > > > header could be replaced.  More importantly, we could reduce a cache
> > > > line write if non offload are supported in mergeable Rx path. 
> > > 
> > > Why do you bother with mergeable Rx without offloads?
> > 
> > Oh, my bad. I actually meant "without offloads __being used__". Just
> > assume the pkt size is 64B and no offloads are used. When mergeable
> > Rx is negotiated (which is the default case), num_buffers has to be
> > set 1. That means an extra cache line write. For the case of non
> > mergeable, the cache line write could be avoid by a trick like what
> > the following patch did:
> > 
> >    http://dpdk.org/browse/dpdk/commit/?id=c9ea670c1dc7e3f111d8139f915082b60c9c1ffe
> > 
> > It basically tries to avoid writing 0 if the value is already 0:
> > the case when no offloads are used.
> > So while writing this email, I was thinking maybe we could not set
> > num_buffers to 1 when there is only one desc (let it be 0 and let
> > num_buffers == 0 imply num_buffers = 1). I'm not quite sure we can
> > do that now, thus I checked the DPDK code and found it's Okay.
> > 
> >     896                 seg_num = header->num_buffers;
> >     897
> >     898                 if (seg_num == 0)
> >     899                         seg_num = 1;
> > 
> > 
> > I then also checked linux kernel code, and found it's not okay as
> > the code depends on the value being set correctly:
> > 
> > ==> 365         u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >     366         struct page *page = virt_to_head_page(buf);
> >     367         int offset = buf - page_address(page);
> >     368         unsigned int truesize = max(len, mergeable_ctx_to_buf_truesize(ctx));
> >     369
> >     370         struct sk_buff *head_skb = page_to_skb(vi, rq, page, offset, len,
> >     371                                                truesize);
> >     372         struct sk_buff *curr_skb = head_skb;
> >     373
> >     374         if (unlikely(!curr_skb))
> >     375                 goto err_skb;
> > ==> 376         while (--num_buf) {
> > 
> > That means, if we want to do that, it needs an extra feature flag
> > (either a global feature flag or a desc flag), something like
> > ALLOW_ZERO_NUM_BUFFERS. Or even, make it allowable in virtio 1.1
> > (virtio 0.95/1.0 won't benifit from it though).
> > 
> > Does it make sense to you?
> 
> Right and then we could use a descriptor flag "header is all 0s".
> For virtio 1.0 we could put these in the used ring instead.

Great.

	--yliu
