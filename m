From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 7/7] virtio-balloon: tell host vm's free page
	info
Date: Thu, 28 Jul 2016 07:50:52 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E042141EE__16977.6511648253$1469692289$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-8-git-send-email-liang.z.li@intel.com>
	<20160728004606-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728004606-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> >  }
> >
> > +static void update_free_pages_stats(struct virtio_balloon *vb,
> 
> why _stats?

Will change.

> > +	max_pfn = get_max_pfn();
> > +	mutex_lock(&vb->balloon_lock);
> > +	while (pfn < max_pfn) {
> > +		memset(vb->page_bitmap, 0, vb->bmap_len);
> > +		ret = get_free_pages(pfn, pfn + vb->pfn_limit,
> > +			vb->page_bitmap, vb->bmap_len * BITS_PER_BYTE);
> > +		hdr->cmd = cpu_to_virtio16(vb->vdev,
> BALLOON_GET_FREE_PAGES);
> > +		hdr->page_shift = cpu_to_virtio16(vb->vdev, PAGE_SHIFT);
> > +		hdr->req_id = cpu_to_virtio64(vb->vdev, req_id);
> > +		hdr->start_pfn = cpu_to_virtio64(vb->vdev, pfn);
> > +		bmap_len = vb->pfn_limit / BITS_PER_BYTE;
> > +		if (!ret) {
> > +			hdr->flag = cpu_to_virtio16(vb->vdev,
> > +
> 	BALLOON_FLAG_DONE);
> > +			if (pfn + vb->pfn_limit > max_pfn)
> > +				bmap_len = (max_pfn - pfn) /
> BITS_PER_BYTE;
> > +		} else
> > +			hdr->flag = cpu_to_virtio16(vb->vdev,
> > +
> 	BALLOON_FLAG_CONT);
> > +		hdr->bmap_len = cpu_to_virtio64(vb->vdev, bmap_len);
> > +		sg_init_one(&sg_out, hdr,
> > +			 sizeof(struct balloon_bmap_hdr) + bmap_len);
> 
> Wait a second. This adds the same buffer multiple times in a loop.
> We will overwrite the buffer without waiting for hypervisor to process it.
> What did I miss?

I am no quite sure about this part, I though the virtqueue_kick(vq) will prevent
the buffer from overwrite, I realized it's wrong.

> > +
> > +		virtqueue_add_outbuf(vq, &sg_out, 1, vb, GFP_KERNEL);
> 
> this can fail. you want to maybe make sure vq has enough space before you
> use it or check error and wait.
> 
> > +		virtqueue_kick(vq);
> 
> why kick here within loop? wait until done. in fact kick outside lock is better
> for smp.

I will change this part in v3.

> 
> > +		pfn += vb->pfn_limit;
> > +	static const char * const names[] = { "inflate", "deflate", "stats",
> > +						 "misc" };
> >  	int err, nvqs;
> >
> >  	/*
> >  	 * We expect two virtqueues: inflate and deflate, and
> >  	 * optionally stat.
> >  	 */
> > -	nvqs = virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
> > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_MISC_VQ))
> > +		nvqs = 4;
> 
> Does misc vq depend on stats vq feature then? if yes please validate that.

Yes, what's you mean by 'validate' that?

> 
> 
> > +	else
> > +		nvqs = virtio_has_feature(vb->vdev,
> > +					  VIRTIO_BALLOON_F_STATS_VQ) ? 3 :
> 2;
> 
> Replace that ? with else too pls.

Will change.

Thanks!
Liang
