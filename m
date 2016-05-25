From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Wed, 25 May 2016 13:37:54 +0300
Message-ID: <20160525131716-mutt-send-email-mst__20765.667098067$1464172693$gmane$org@redhat.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
	<20160520120038.GA28757@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A4BFD@shsmsx102.ccr.corp.intel.com>
	<20160524130041-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6C67@shsmsx102.ccr.corp.intel.com>
	<20160525115419-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6CF9@shsmsx102.ccr.corp.intel.com>
	<20160525123546-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6D89@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E041A6D89@shsmsx102.ccr.corp.intel.com>
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

On Wed, May 25, 2016 at 10:10:47AM +0000, Li, Liang Z wrote:
> > > > >
> > > > > Hi MST,
> > > > >
> > > > > I have measured the performance when using a 32K page bitmap,
> > > >
> > > > Just to make sure. Do you mean a 32Kbyte bitmap?
> > > > Covering 1Gbyte of memory?
> > > Yes.
> > >
> > > >
> > > > > and inflate the balloon to 3GB
> > > > > of an idle guest with 4GB RAM.
> > > >
> > > > Should take 3 requests then, right?
> > > >
> > >
> > > No,  we can't assign the PFN when allocating page in balloon driver,
> > > So the PFNs of pages allocated may be across a large range,  we will
> > > tell the host once the pfn_max -pfn_min >= 0x40000(1GB range), so the
> > > requests count is most likely to be more than 3.
> > >
> > > > > Now:
> > > > > total inflating time: 338ms
> > > > > the count of virtio data transmission:  373
> > > >
> > > > Why was this so high? I would expect 3 transmissions.
> > >
> > > I follow your suggestion:
> > > ----------------------------------------------------------------------
> > > -------------- Suggestion to address all above comments:
> > > 	1. allocate a bunch of pages and link them up,
> > > 	   calculating the min and the max pfn.
> > > 	   if max-min exceeds the allocated bitmap size,
> > > 	   tell host.
> > > 	2. limit allocated bitmap size to something reasonable.
> > > 	   How about 32Kbytes? This is 256kilo bit in the map, which comes
> > > 	   out to 1Giga bytes of memory in the balloon.
> > > ----------------------------------------------------------------------
> > > --------------- Because the PFNs of the allocated pages are not linear
> > > increased, so 3 transmissions are  impossible.
> > >
> > >
> > > Liang
> > 
> > Interesting. How about instead of tell host, we do multiple scans, each time
> > ignoring pages out of range?
> > 
> > 	for (pfn = min pfn; pfn < max pfn; pfn += 1G) {
> > 		foreach page
> > 			if page pfn < pfn || page pfn >= pfn + 1G
> > 				continue
> > 			set bit
> > 		tell host
> > 	}
> > 
> 
> That means we have to allocate/free all the requested pages first, and then tell the host.
> It works fine for inflating, but for deflating, because the page has been deleted from the vb-> vb_dev_info->pages,
> so, we have to use a struct to save the dequeued pages before calling release_pages_balloon(),

struct list_head?  I think you can just replace set_page_pfns with
        list_add(&page->lru, &page_list);



>  I think a page bitmap is the best struct to save these pages, because it consumes less memory.
> And that bitmap should be large enough to save pfn 0 to max_pfn.
> 
> If the above is true, then we are back to the square one. we really need a large page bitmap. Right?
> 
> Liang

These look like implementation issues to me.

I think the below might be helpful (completely untested),
your work can go on top.

--->

virtio-balloon: rework deflate to add page to a tmp list

Will allow faster notifications using a bitmap down the road.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 476c0e3..44050a3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -195,8 +195,9 @@ static void release_pages_balloon(struct virtio_balloon *vb)
 static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned num_freed_pages;
-	struct page *page;
+	struct page *page, *next;
 	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
+	LIST_HEAD(pages);		/* Pages dequeued for handing to Host */
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
@@ -207,10 +208,13 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 		page = balloon_page_dequeue(vb_dev_info);
 		if (!page)
 			break;
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+		list_add(&page->lru, &pages);
 		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
+	list_for_each_entry_safe(page, next, &pages, lru)
+		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+
 	num_freed_pages = vb->num_pfns;
 	/*
 	 * Note that if
-- 
MST
