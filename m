From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Wed, 25 May 2016 14:29:35 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E041A720C__22267.8152997561$1464186643$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
	<20160520120038.GA28757@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A4BFD@shsmsx102.ccr.corp.intel.com>
	<20160524130041-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6C67@shsmsx102.ccr.corp.intel.com>
	<20160525115419-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6CF9@shsmsx102.ccr.corp.intel.com>
	<20160525123546-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6D89@shsmsx102.ccr.corp.intel.com>
	<20160525131716-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160525131716-mutt-send-email-mst@redhat.com>
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > > Interesting. How about instead of tell host, we do multiple scans,
> > > each time ignoring pages out of range?
> > >
> > > 	for (pfn = min pfn; pfn < max pfn; pfn += 1G) {
> > > 		foreach page
> > > 			if page pfn < pfn || page pfn >= pfn + 1G
> > > 				continue
> > > 			set bit
> > > 		tell host
> > > 	}
> > >
> >
> > That means we have to allocate/free all the requested pages first, and then
> tell the host.
> > It works fine for inflating, but for deflating, because the page has
> > been deleted from the vb-> vb_dev_info->pages, so, we have to use a
> > struct to save the dequeued pages before calling
> > release_pages_balloon(),
> 
> struct list_head?  I think you can just replace set_page_pfns with
>         list_add(&page->lru, &page_list);
> 
> 

That's is fine, I will retry and get back to you.

Thanks!

Liang
> 
> >  I think a page bitmap is the best struct to save these pages, because it
> consumes less memory.
> > And that bitmap should be large enough to save pfn 0 to max_pfn.
> >
> > If the above is true, then we are back to the square one. we really need a
> large page bitmap. Right?
> >
> > Liang
> 
> These look like implementation issues to me.
> 
> I think the below might be helpful (completely untested), your work can go
> on top.
> 
> --->
> 
> virtio-balloon: rework deflate to add page to a tmp list
> 
> Will allow faster notifications using a bitmap down the road.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 476c0e3..44050a3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -195,8 +195,9 @@ static void release_pages_balloon(struct
> virtio_balloon *vb)  static unsigned leak_balloon(struct virtio_balloon *vb,
> size_t num)  {
>  	unsigned num_freed_pages;
> -	struct page *page;
> +	struct page *page, *next;
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
> +	LIST_HEAD(pages);		/* Pages dequeued for handing to
> Host */
> 
>  	/* We can only do one array worth at a time. */
>  	num = min(num, ARRAY_SIZE(vb->pfns));
> @@ -207,10 +208,13 @@ static unsigned leak_balloon(struct virtio_balloon
> *vb, size_t num)
>  		page = balloon_page_dequeue(vb_dev_info);
>  		if (!page)
>  			break;
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +		list_add(&page->lru, &pages);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
> 
> +	list_for_each_entry_safe(page, next, &pages, lru)
> +		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +
>  	num_freed_pages = vb->num_pfns;
>  	/*
>  	 * Note that if
> --
> MST
