From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Tue, 24 May 2016 14:11:35 +0300
Message-ID: <20160524111135.GA7392__3675.917935516$1464088317$gmane$org@redhat.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
	<20160520120038.GA28757@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A4BFD@shsmsx102.ccr.corp.intel.com>
	<20160524130041-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A4D21@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E041A4D21@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 24, 2016 at 10:38:43AM +0000, Li, Liang Z wrote:
> > > > >  {
> > > > > -	struct scatterlist sg;
> > > > >  	unsigned int len;
> > > > >
> > > > > -	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> > > > > +	if (virtio_has_feature(vb->vdev,
> > > > VIRTIO_BALLOON_F_PAGE_BITMAP)) {
> > > > > +		u32 page_shift = PAGE_SHIFT;
> > > > > +		unsigned long start_pfn, end_pfn, flags = 0, bmap_len;
> > > > > +		struct scatterlist sg[5];
> > > > > +
> > > > > +		start_pfn = rounddown(vb->start_pfn, BITS_PER_LONG);
> > > > > +		end_pfn = roundup(vb->end_pfn, BITS_PER_LONG);
> > > > > +		bmap_len = (end_pfn - start_pfn) / BITS_PER_LONG *
> > > > sizeof(long);
> > > > > +
> > > > > +		sg_init_table(sg, 5);
> > > > > +		sg_set_buf(&sg[0], &flags, sizeof(flags));
> > > > > +		sg_set_buf(&sg[1], &start_pfn, sizeof(start_pfn));
> > > > > +		sg_set_buf(&sg[2], &page_shift, sizeof(page_shift));
> > > > > +		sg_set_buf(&sg[3], &bmap_len, sizeof(bmap_len));
> > > > > +		sg_set_buf(&sg[4], vb->page_bitmap +
> > > > > +				 (start_pfn / BITS_PER_LONG), bmap_len);
> > > >
> > > > This can be pre-initialized, correct?
> > >
> > > pre-initialized? I am not quite understand your mean.
> > 
> > I think you can maintain sg as part of device state and init sg with the bitmap.
> > 
> 
> I got it.
> 
> > > > This is grossly inefficient if you only requested a single page.
> > > > And it's also allocating memory very aggressively without ever
> > > > telling the host what is going on.
> > >
> > > If only requested a single page, there is no need  to send the entire
> > > page bitmap, This RFC patch has already considered about this.
> > 
> > where's that addressed in code?
> > 
> 
> By record the start_pfn and end_pfn.
> 
> The start_pfn & end_pfn will be updated in set_page_bitmap()
> and will be used in the function tell_host():
> 
> ---------------------------------------------------------------------------------
> +static void set_page_bitmap(struct virtio_balloon *vb, struct page 
> +*page) {
> +	unsigned int i;
> +	unsigned long *bitmap = vb->page_bitmap;
> +	unsigned long balloon_pfn = page_to_balloon_pfn(page);
> +
> +	for (i = 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
> +		set_bit(balloon_pfn + i, bitmap);

BTW, there's a page size value in header so there
is no longer need to set multiple bits per page.

> +	if (balloon_pfn < vb->start_pfn)
> +		vb->start_pfn = balloon_pfn;
> +	if (balloon_pfn > vb->end_pfn)
> +		vb->end_pfn = balloon_pfn;
> +}

Sounds good, but you also need to limit by
allocated bitmap size.

> 
> +		unsigned long start_pfn, end_pfn, flags = 0, bmap_len;
> +		struct scatterlist sg[5];
> +
> +		start_pfn = rounddown(vb->start_pfn, BITS_PER_LONG);
> +		end_pfn = roundup(vb->end_pfn, BITS_PER_LONG);
> +		bmap_len = (end_pfn - start_pfn) / BITS_PER_LONG * sizeof(long);
> +
> +		sg_init_table(sg, 5);
> +		sg_set_buf(&sg[0], &flags, sizeof(flags));
> +		sg_set_buf(&sg[1], &start_pfn, sizeof(start_pfn));
> +		sg_set_buf(&sg[2], &page_shift, sizeof(page_shift));
> +		sg_set_buf(&sg[3], &bmap_len, sizeof(bmap_len));
> +		sg_set_buf(&sg[4], vb->page_bitmap +
> +				 (start_pfn / BITS_PER_LONG), bmap_len);

Looks wrong. start_pfn should start at offset 0 I think ...

> +		virtqueue_add_outbuf(vq, sg, 5, vb, GFP_KERNEL);
> -------------------------------------------------------------------------------------------
> > > But it can works very well if requesting several pages  which across a
> > > large range.
> > 
> > Some kind of limit on range would make sense though.
> > It need not cover max pfn.
> > 
> 
> Yes, agree.
> 
> > > > Suggestion to address all above comments:
> > > > 	1. allocate a bunch of pages and link them up,
> > > > 	   calculating the min and the max pfn.
> > > > 	   if max-min exceeds the allocated bitmap size,
> > > > 	   tell host.
> > >
> > > I am not sure if it works well in some cases, e.g. The allocated pages
> > > are across a wide range and the max-min > limit is very frequently to be
> > true.
> > > Then, there will be many times of virtio transmission and it's bad for
> > > performance improvement. Right?
> > 
> > It's a tradeoff for sure. Measure it, see what the overhead is.
> 
> OK, I will try and get back to you.
> 
> > 
> > >
> > > > 	2. limit allocated bitmap size to something reasonable.
> > > > 	   How about 32Kbytes? This is 256kilo bit in the map, which comes
> > > > 	   out to 1Giga bytes of memory in the balloon.
> > >
> > > So, even the VM has 1TB of RAM, the page bitmap will take 32MB of
> > memory.
> > > Maybe it's better to use a big page bitmap the save the pages
> > > allocated by balloon, and split the big page bitmap to 32K bytes unit, then
> > transfer one unit at a time.
> > 
> > How is this different from what I said?
> > 
> 
> It's good if it's the same as you said.
> 
> Thanks!
> Liang
> 
> > >
> > > Should we use a page bitmap to replace 'vb->pages' ?
> > >
> > > How about rolling back to use PFNs if the count of requested pages is a
> > small number?
> > >
> > > Liang
> > 
> > That's why we have start pfn. you can use that to pass even a single page
> > without a lot of overhead.
> > 
> > > > > --
> > > > > 1.9.1
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > > > the body of a message to majordomo@vger.kernel.org More majordomo
> > > > info at http://vger.kernel.org/majordomo-info.html
