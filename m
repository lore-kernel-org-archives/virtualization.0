From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 28 Jul 2016 03:06:37 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213E1D@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<20160728002243-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728002243-mutt-send-email-mst@kernel.org>
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

> > + * VIRTIO_BALLOON_PFNS_LIMIT is used to limit the size of page bitmap
> > + * to prevent a very large page bitmap, there are two reasons for this:
> > + * 1) to save memory.
> > + * 2) allocate a large bitmap may fail.
> > + *
> > + * The actual limit of pfn is determined by:
> > + * pfn_limit = min(max_pfn, VIRTIO_BALLOON_PFNS_LIMIT);
> > + *
> > + * If system has more pages than VIRTIO_BALLOON_PFNS_LIMIT, we will
> > +scan
> > + * the page list and send the PFNs with several times. To reduce the
> > + * overhead of scanning the page list. VIRTIO_BALLOON_PFNS_LIMIT
> > +should
> > + * be set with a value which can cover most cases.
> 
> So what if it covers 1/32 of the memory? We'll do 32 exits and not 1, still not a
> big deal for a big guest.
> 

The issue here is the overhead is too high for scanning the page list for 32 times.
Limit the page bitmap size to a fixed value is better for a big guest?

> > + */
> > +#define VIRTIO_BALLOON_PFNS_LIMIT ((32 * (1ULL << 30)) >>
> PAGE_SHIFT)
> > +/* 32GB */
> 
> I already said this with a smaller limit.
> 
> 	2<< 30  is 2G but that is not a useful comment.
> 	pls explain what is the reason for this selection.
> 
> Still applies here.
> 

I will add the comment for this.

> > -	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> > +	if (virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_PAGE_BITMAP)) {
> > +		struct balloon_bmap_hdr *hdr = vb->bmap_hdr;
> > +		unsigned long bmap_len;
> > +
> > +		/* cmd and req_id are not used here, set them to 0 */
> > +		hdr->cmd = cpu_to_virtio16(vb->vdev, 0);
> > +		hdr->page_shift = cpu_to_virtio16(vb->vdev, PAGE_SHIFT);
> > +		hdr->reserved = cpu_to_virtio16(vb->vdev, 0);
> > +		hdr->req_id = cpu_to_virtio64(vb->vdev, 0);
> 
> no need to swap 0, just fill it in. in fact you allocated all 0s so no need to touch
> these fields at all.
> 

Will change in v3.

> > @@ -489,7 +612,7 @@ static int virtballoon_migratepage(struct
> > balloon_dev_info *vb_dev_info,  static int virtballoon_probe(struct
> > virtio_device *vdev)  {
> >  	struct virtio_balloon *vb;
> > -	int err;
> > +	int err, hdr_len;
> >
> >  	if (!vdev->config->get) {
> >  		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> @@
> > -508,6 +631,18 @@ static int virtballoon_probe(struct virtio_device *vdev)
> >  	spin_lock_init(&vb->stop_update_lock);
> >  	vb->stop_update = false;
> >  	vb->num_pages = 0;
> > +	vb->pfn_limit = VIRTIO_BALLOON_PFNS_LIMIT;
> > +	vb->pfn_limit = min(vb->pfn_limit, get_max_pfn());
> > +	vb->bmap_len = ALIGN(vb->pfn_limit, BITS_PER_LONG) /
> > +		 BITS_PER_BYTE + 2 * sizeof(unsigned long);
> 
> What are these 2 longs in aid of?
> 
The rounddown(vb->start_pfn,  BITS_PER_LONG) and roundup(vb->end_pfn, BITS_PER_LONG) 
may cause (vb->end_pfn - vb->start_pfn) > vb->pfn_limit, so we need extra space to save the
bitmap for this case. 2 longs are enough.

> > +	hdr_len = sizeof(struct balloon_bmap_hdr);
> > +	vb->bmap_hdr = kzalloc(hdr_len + vb->bmap_len, GFP_KERNEL);
> 
> So it can go up to 1MByte but adding header size etc you need a higher order
> allocation. This is a waste, there is no need to have a power of two allocation.
> Start from the other side. Say "I want to allocate 32KBytes for the bitmap".
> Subtract the header and you get bitmap size.
> Calculate the pfn limit from there.
> 

Indeed, will change. Thanks a lot!

Liang
