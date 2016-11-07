From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH kernel v4 7/7] virtio-balloon: tell host vm's unused
	page info
Date: Mon, 7 Nov 2016 03:37:58 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A106DAA__26878.7982211963$1478489895$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1478067447-24654-1-git-send-email-liang.z.li@intel.com>
	<1478067447-24654-8-git-send-email-liang.z.li@intel.com>
	<b25eac6e-3744-3874-93a8-02f814549adf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b25eac6e-3744-3874-93a8-02f814549adf@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

> Please squish this and patch 5 together.  It makes no sense to separate them.
> 

OK.

> > +static void send_unused_pages_info(struct virtio_balloon *vb,
> > +				unsigned long req_id)
> > +{
> > +	struct scatterlist sg_in;
> > +	unsigned long pfn = 0, bmap_len, pfn_limit, last_pfn, nr_pfn;
> > +	struct virtqueue *vq = vb->req_vq;
> > +	struct virtio_balloon_resp_hdr *hdr = vb->resp_hdr;
> > +	int ret = 1, used_nr_bmap = 0, i;
> > +
> > +	if (virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_PAGE_BITMAP) &&
> > +		vb->nr_page_bmap == 1)
> > +		extend_page_bitmap(vb);
> > +
> > +	pfn_limit = PFNS_PER_BMAP * vb->nr_page_bmap;
> > +	mutex_lock(&vb->balloon_lock);
> > +	last_pfn = get_max_pfn();
> > +
> > +	while (ret) {
> > +		clear_page_bitmap(vb);
> > +		ret = get_unused_pages(pfn, pfn + pfn_limit, vb-
> >page_bitmap,
> > +			 PFNS_PER_BMAP, vb->nr_page_bmap);
> 
> This changed the underlying data structure without changing the way that
> the structure is populated.
> 
> This algorithm picks a "PFNS_PER_BMAP * vb->nr_page_bmap"-sized set of
> pfns, allocates a bitmap for them, the loops through all zones looking for
> pages in any free list that are in that range.
> 
> Unpacking all the indirection, it looks like this:
> 
> for (pfn = 0; pfn < get_max_pfn(); pfn += BITMAP_SIZE_IN_PFNS)
> 	for_each_populated_zone(zone)
> 		for_each_migratetype_order(order, t)
> 			list_for_each(..., &zone->free_area[order])...
> 
> Let's say we do a 32k bitmap that can hold ~1M pages.  That's 4GB of RAM.
> On a 1TB system, that's 256 passes through the top-level loop.
> The bottom-level lists have tens of thousands of pages in them, even on my
> laptop.  Only 1/256 of these pages will get consumed in a given pass.
> 
Your description is not exactly.
A 32k bitmap is used only when there is few free memory left in the system and when 
the extend_page_bitmap() failed to allocate more memory for the bitmap. Or dozens of 
32k split bitmap will be used, this version limit the bitmap count to 32, it means we can use
at most 32*32 kB for the bitmap, which can cover 128GB for RAM. We can increase the bitmap
count limit to a larger value if 32 is not big enough.

> That's an awfully inefficient way of doing it.  This patch essentially changed
> the data structure without changing the algorithm to populate it.
> 
> Please change the *algorithm* to use the new data structure efficiently.
>  Such a change would only do a single pass through each freelist, and would
> choose whether to use the extent-based (pfn -> range) or bitmap-based
> approach based on the contents of the free lists.

Save the free page info to a raw bitmap first and then process the raw bitmap to
get the proper ' extent-based ' and  'bitmap-based' is the most efficient way I can 
come up with to save the virtio data transmission.  Do you have some better idea?


In the QEMU, no matter how we encode the bitmap, the raw format bitmap will be
used in the end.  But what I did in this version is:
   kernel: get the raw bitmap  --> encode the bitmap
   QEMU: decode the bitmap --> get the raw bitmap

Is it worth to do this kind of job here? we can save the virtio data transmission, but at the
same time, we did extra work.

It seems the benefit we get for this feature is not as big as that in fast balloon inflating/deflating.
> 
> You should not be using get_max_pfn().  Any patch set that continues to use
> it is not likely to be using a proper algorithm.

Do you have any suggestion about how to avoid it?

Thanks!
Liang
