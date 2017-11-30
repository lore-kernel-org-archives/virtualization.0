From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v18 07/10] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Thu, 30 Nov 2017 16:25:09 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739376336__44802.1019845784$1512059147$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-8-git-send-email-wei.w.wang@intel.com>
	<201711301935.EHF86450.MSFLOOHFJtFOQV@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201711301935.EHF86450.MSFLOOHFJtFOQV@I-love.SAKURA.ne.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "willy@infradead.org" <willy@infradead.org>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amit.shah@red
List-Id: virtualization@lists.linuxfoundation.org

On Thursday, November 30, 2017 6:36 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
> > +static inline int xb_set_page(struct virtio_balloon *vb,
> > +			       struct page *page,
> > +			       unsigned long *pfn_min,
> > +			       unsigned long *pfn_max)
> > +{
> > +	unsigned long pfn = page_to_pfn(page);
> > +	int ret;
> > +
> > +	*pfn_min = min(pfn, *pfn_min);
> > +	*pfn_max = max(pfn, *pfn_max);
> > +
> > +	do {
> > +		ret = xb_preload_and_set_bit(&vb->page_xb, pfn,
> > +					     GFP_NOWAIT | __GFP_NOWARN);
> 
> It is a bit of pity that __GFP_NOWARN here is applied to only xb_preload().
> Memory allocation by xb_set_bit() will after all emit warnings. Maybe
> 
>   xb_init(&vb->page_xb);
>   vb->page_xb.gfp_mask |= __GFP_NOWARN;
> 
> is tolerable? Or, unconditionally apply __GFP_NOWARN at xb_init()?
> 



Please have a check this one: radix_tree_node_alloc()

In our case, I think the code path goes to 

if (!gfpflags_allow_blocking(gfp_mask) && !in_interrupt()) {
...
ret = kmem_cache_alloc(radix_tree_node_cachep,
                                       gfp_mask | __GFP_NOWARN);
...
goto out;
}

So I think the __GFP_NOWARN is already there.



>   static inline void xb_init(struct xb *xb)
>   {
>           INIT_RADIX_TREE(&xb->xbrt, IDR_RT_MARKER | GFP_NOWAIT);
>   }
> 
> > +	} while (unlikely(ret == -EAGAIN));
> > +
> > +	return ret;
> > +}
> > +
> 
> 
> 
> > @@ -172,11 +283,18 @@ static unsigned fill_balloon(struct virtio_balloon
> *vb, size_t num)
> >  	vb->num_pfns = 0;
> >
> >  	while ((page = balloon_page_pop(&pages))) {
> > +		if (use_sg) {
> > +			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
> > +				__free_page(page);
> > +				break;
> 
> You cannot "break;" without consuming all pages in "pages".


Right, I think it should be "continue" here. Thanks. 

> 
> > +			}
> > +		} else {
> > +			set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> > +		}
> > +
> >  		balloon_page_enqueue(&vb->vb_dev_info, page);
> >
> >  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
> > -
> > -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> >  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> >  		if (!virtio_has_feature(vb->vdev,
> >
> 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> 
> 
> 
> > @@ -212,9 +334,12 @@ static unsigned leak_balloon(struct virtio_balloon
> *vb, size_t num)
> >  	struct page *page;
> >  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
> >  	LIST_HEAD(pages);
> > +	bool use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG);
> 
> You can pass use_sg as an argument to leak_balloon(). Then, you won't need
> to define leak_balloon_sg_oom(). Since xbitmap allocation does not use
> __GFP_DIRECT_RECLAIM, it is safe to reuse leak_balloon() for OOM path.
> Just be sure to pass use_sg == false because memory allocation for use_sg ==
> true likely fails when called from OOM path. (But trying use_sg == true for
> OOM path and then fallback to use_sg == false is not bad?)
> 


But once the SG mechanism is in use, we cannot use the non-SG mechanism, because the interface between the guest and host is not the same for SG and non-SG. Methods to make the host support both mechanisms at the same time would complicate the interface and implementation. 

I also think the old non-SG mechanism should be deprecated to use since its implementation isn't perfect in some sense, e.g. it balloons pages using outbuf which implies that no changes are allowed to the balloon pages and this isn't true for ballooning. The new mechanism (SG) has changed it to use inbuf.

So I think using leak_balloon_sg_oom() would be better. Is there any reason that we couldn't use it?

Best,
Wei
