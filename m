From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [virtio-dev] Re: [PATCH v2 repost 6/7] mm: add the related
	functions to get free page info
Date: Thu, 28 Jul 2016 05:30:39 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213F20__26628.5414378673$1469683870$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-7-git-send-email-liang.z.li@intel.com>
	<20160728010921-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728010921-mutt-send-email-mst@kernel.org>
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

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c index 7da61ad..3ad8b10
> > 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4523,6 +4523,52 @@ unsigned long get_max_pfn(void)  }
> > EXPORT_SYMBOL(get_max_pfn);
> >
> > +static void mark_free_pages_bitmap(struct zone *zone, unsigned long
> start_pfn,
> > +	unsigned long end_pfn, unsigned long *bitmap, unsigned long len) {
> > +	unsigned long pfn, flags, page_num;
> > +	unsigned int order, t;
> > +	struct list_head *curr;
> > +
> > +	if (zone_is_empty(zone))
> > +		return;
> > +	end_pfn = min(start_pfn + len, end_pfn);
> > +	spin_lock_irqsave(&zone->lock, flags);
> > +
> > +	for_each_migratetype_order(order, t) {
> 
> Why not do each order separately? This way you can use a single bit to pass a
> huge page to host.
> 

I thought about that before, and did not that because of complexity and small benefits.
Use separated page bitmaps for each order won't help to reduce the data traffic, except
ignoring the pages with small order. 

> Not a requirement but hey.
> 
> Alternatively (and maybe that is a better idea0 if you wanted to, you could
> just skip lone 4K pages.
> It's not clear that they are worth bothering with.
> Add a flag to start with some reasonably large order and go from there.
> 
One of the main reason of this patch is to reduce the network traffic as much as possible,
it looks strange to skip the lone 4K pages. Skipping these pages can made live migration
faster? I think it depends on the amount of lone 4K pages.

In the other hand, it's faster to send one bit through virtio than that send 4K bytes 
through even 10Gps network, is that true?

Liang
