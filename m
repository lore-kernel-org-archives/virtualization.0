From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RESEND PATCH v3 kernel 4/7] virtio-balloon: speed up
	inflate/deflate process
Date: Tue, 25 Oct 2016 09:46:33 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A0FBCDC__5547.11787631295$1477388985$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<1477031080-12616-5-git-send-email-liang.z.li@intel.com>
	<20161025091821-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161025091821-mutt-send-email-mst@kernel.org>
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "Hansen,
	Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > +static inline void init_pfn_range(struct virtio_balloon *vb) {
> > +	vb->min_pfn = ULONG_MAX;
> > +	vb->max_pfn = 0;
> > +}
> > +
> > +static inline void update_pfn_range(struct virtio_balloon *vb,
> > +				 struct page *page)
> > +{
> > +	unsigned long balloon_pfn = page_to_balloon_pfn(page);
> > +
> > +	if (balloon_pfn < vb->min_pfn)
> > +		vb->min_pfn = balloon_pfn;
> > +	if (balloon_pfn > vb->max_pfn)
> > +		vb->max_pfn = balloon_pfn;
> > +}
> > +
> 
> rename to hint these are all bitmap related.

Will change in v4.

> 
> 
> >  static void tell_host(struct virtio_balloon *vb, struct virtqueue
> > *vq)  {
> > -	struct scatterlist sg;
> > -	unsigned int len;
> > +	struct scatterlist sg, sg2[BALLOON_BMAP_COUNT + 1];
> > +	unsigned int len, i;
> > +
> > +	if (virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_PAGE_BITMAP)) {
> > +		struct balloon_bmap_hdr *hdr = vb->bmap_hdr;
> > +		unsigned long bmap_len;
> > +		int nr_pfn, nr_used_bmap, nr_buf;
> > +
> > +		nr_pfn = vb->end_pfn - vb->start_pfn + 1;
> > +		nr_pfn = roundup(nr_pfn, BITS_PER_LONG);
> > +		nr_used_bmap = nr_pfn / PFNS_PER_BMAP;
> > +		bmap_len = nr_pfn / BITS_PER_BYTE;
> > +		nr_buf = nr_used_bmap + 1;
> > +
> > +		/* cmd, reserved and req_id are init to 0, unused here */
> > +		hdr->page_shift = cpu_to_virtio16(vb->vdev, PAGE_SHIFT);
> > +		hdr->start_pfn = cpu_to_virtio64(vb->vdev, vb->start_pfn);
> > +		hdr->bmap_len = cpu_to_virtio64(vb->vdev, bmap_len);
> > +		sg_init_table(sg2, nr_buf);
> > +		sg_set_buf(&sg2[0], hdr, sizeof(struct balloon_bmap_hdr));
> > +		for (i = 0; i < nr_used_bmap; i++) {
> > +			unsigned int  buf_len = BALLOON_BMAP_SIZE;
> > +
> > +			if (i + 1 == nr_used_bmap)
> > +				buf_len = bmap_len - BALLOON_BMAP_SIZE
> * i;
> > +			sg_set_buf(&sg2[i + 1], vb->page_bitmap[i],
> buf_len);
> > +		}
> >
> > -	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> > +		while (vq->num_free < nr_buf)
> > +			msleep(2);
> 
> 
> What's going on here? Who is expected to update num_free?
> 

I just want to wait until the vq have enough space to write the bitmap, I thought qemu
side will update the vq->num_free, is it wrong?

> 
> 
> > +		if (virtqueue_add_outbuf(vq, sg2, nr_buf, vb, GFP_KERNEL)
> == 0)
> > +			virtqueue_kick(vq);
> >
> > -	/* We should always be able to add one buffer to an empty queue.
> */
> > -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > -	virtqueue_kick(vq);
> > +	} else {
> > +		sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb-
> >num_pfns);
> > +
> > +		/* We should always be able to add one buffer to an empty
> > +		 * queue. */
> 
> Pls use a multiple comment style consistent with kernel coding style.

Will change in next version.

> 
> > +		virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > +		virtqueue_kick(vq);
> > +	}
> >
> >  	/* When host has read buffer, this completes via balloon_ack */
> >  	wait_event(vb->acked, virtqueue_get_buf(vq, &len)); @@ -138,13
> > +199,93 @@ static void set_page_pfns(struct virtio_balloon *vb,
> >  					  page_to_balloon_pfn(page) + i);  }
> >
> > -static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
> > +static void extend_page_bitmap(struct virtio_balloon *vb) {
> > +	int i;
> > +	unsigned long bmap_len, bmap_count;
> > +
> > +	bmap_len = ALIGN(get_max_pfn(), BITS_PER_LONG) /
> BITS_PER_BYTE;
> > +	bmap_count = bmap_len / BALLOON_BMAP_SIZE;
> > +	if (bmap_len % BALLOON_BMAP_SIZE)
> > +		bmap_count++;
> > +	if (bmap_count > BALLOON_BMAP_COUNT)
> > +		bmap_count = BALLOON_BMAP_COUNT;
> > +
> 
> This is doing simple things in tricky ways.
> Please use macros such as ALIGN and max instead of if.
> 

Will change.

> 
> > +	for (i = 1; i < bmap_count; i++) {
> 
> why 1?

In probe stage, already allocated one bitmap.

> 
> > +		vb->page_bitmap[i] = kmalloc(BALLOON_BMAP_SIZE,
> GFP_ATOMIC);
> 
> why GFP_ATOMIC?

Yes, GFP_ATOMIC is not necessary.

> and what will free the previous buffer?

The previous buffer will not be freed.

> 
> 
> > +		if (vb->page_bitmap[i])
> > +			vb->nr_page_bmap++;
> > +		else
> > +			break;
> 
> and what will happen then?

I plan to use the previous allocated buffer to save the bitmap, need more code for kmalloc failure?

> > -static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
> > +static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num,
> > +				bool use_bmap)
> 
> this is just a feature bit - why not get it internally?

Indeed.

> > @@ -218,8 +374,14 @@ static unsigned leak_balloon(struct virtio_balloon
> *vb, size_t num)
> >  	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
> >  	 * is true, we *have* to do it in this order
> >  	 */
> > -	if (vb->num_pfns != 0)
> > -		tell_host(vb, vb->deflate_vq);
> > +	if (vb->num_pfns != 0) {
> > +		if (use_bmap)
> > +			set_page_bitmap(vb, &pages, vb->deflate_vq);
> > +		else
> > +			tell_host(vb, vb->deflate_vq);
> > +
> > +		release_pages_balloon(vb, &pages);
> > +	}
> >  	release_pages_balloon(vb, &pages);
> >  	mutex_unlock(&vb->balloon_lock);
> >  	return num_freed_pages;
> > @@ -354,13 +516,15 @@ static int virtballoon_oom_notify(struct
> notifier_block *self,
> >  	struct virtio_balloon *vb;
> >  	unsigned long *freed;
> >  	unsigned num_freed_pages;
> > +	bool use_bmap;
> >
> >  	vb = container_of(self, struct virtio_balloon, nb);
> >  	if (!virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> >  		return NOTIFY_OK;
> >
> >  	freed = parm;
> > -	num_freed_pages = leak_balloon(vb, oom_pages);
> > +	use_bmap = virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_PAGE_BITMAP);
> > +	num_freed_pages = leak_balloon(vb, oom_pages, use_bmap);
> >  	update_balloon_size(vb);
> >  	*freed += num_freed_pages;
> >
> > @@ -380,15 +544,19 @@ static void update_balloon_size_func(struct
> > work_struct *work)  {
> >  	struct virtio_balloon *vb;
> >  	s64 diff;
> > +	bool use_bmap;
> >
> >  	vb = container_of(work, struct virtio_balloon,
> >  			  update_balloon_size_work);
> >  	diff = towards_target(vb);
> > +	use_bmap = virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_PAGE_BITMAP);
> > +	if (use_bmap && diff && vb->nr_page_bmap == 1)
> > +		extend_page_bitmap(vb);
> 
> So you allocate it on first use, then keep it around until device remove?
> Seems ugly.

Yes, this version behave like this.

> Needs comments explaining the motivation for this.
> Can't we free it immediately when it becomes unused?
> 

Yes, it can be freed immediately, will change in v4.

Thanks for your time and your valuable comments! I will send out the v4 soon.

Liang
