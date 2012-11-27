From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v11 4/7] mm: introduce compaction and migration for
	ballooned pages
Date: Tue, 27 Nov 2012 09:59:10 -0200
Message-ID: <20121127115910.GA1812__5741.18958688832$1354017604$gmane$org@t510.redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
	<08be4346b620ae9344691cc6c2ad0bc51f492e01.1352256088.git.aquini@redhat.com>
	<20121109121602.GQ3886@csn.ul.ie>
	<20121120153324.7119bd3b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121120153324.7119bd3b.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 20, 2012 at 03:33:24PM -0800, Andrew Morton wrote:
> On Fri, 9 Nov 2012 12:16:02 +0000
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
> > On Wed, Nov 07, 2012 at 01:05:51AM -0200, Rafael Aquini wrote:
> > > Memory fragmentation introduced by ballooning might reduce significantly
> > > the number of 2MB contiguous memory blocks that can be used within a guest,
> > > thus imposing performance penalties associated with the reduced number of
> > > transparent huge pages that could be used by the guest workload.
> > > 
> > > This patch introduces the helper functions as well as the necessary changes
> > > to teach compaction and migration bits how to cope with pages which are
> > > part of a guest memory balloon, in order to make them movable by memory
> > > compaction procedures.
> > > 
> >
> > ...
> >
> > > --- a/mm/compaction.c
> > > +++ b/mm/compaction.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/backing-dev.h>
> > >  #include <linux/sysctl.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/balloon_compaction.h>
> > >  #include "internal.h"
> > >  
> > >  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
> > > @@ -565,9 +566,24 @@ isolate_migratepages_range(struct zone *zone, struct compact_control *cc,
> > >  			goto next_pageblock;
> > >  		}
> > >  
> > > -		/* Check may be lockless but that's ok as we recheck later */
> > > -		if (!PageLRU(page))
> > > +		/*
> > > +		 * Check may be lockless but that's ok as we recheck later.
> > > +		 * It's possible to migrate LRU pages and balloon pages
> > > +		 * Skip any other type of page
> > > +		 */
> > > +		if (!PageLRU(page)) {
> > > +			if (unlikely(balloon_page_movable(page))) {
> > 
> > Because it's lockless, it really seems that the barrier stuck down there
> > is unnecessary. At worst you get a temporarily incorrect answer that you
> > recheck later under page lock in balloon_page_isolate.
> 

Sorry for the late reply.

> What happened with this?
> 
This Mel's concern were addressed by the last submitted review (v12)


> Also: what barrier?

Mel was refering to these barriers, at balloon_compaction.h:
---8<---
+/*
+ * balloon_page_insert - insert a page into the balloon's page list and make
+ *                      the page->mapping assignment accordingly.
+ * @page    : page to be assigned as a 'balloon page'
+ * @mapping : allocated special 'balloon_mapping'
+ * @head    : balloon's device page list head
+ */
+static inline void balloon_page_insert(struct page *page,
+                                      struct address_space *mapping,
+                                      struct list_head *head)
+{
+       list_add(&page->lru, head);
+       /*
+        * Make sure the page is already inserted on balloon's page list
+        * before assigning its ->mapping.
+        */
+       smp_wmb();
+       page->mapping = mapping;
+}
+
+/*
+ * balloon_page_delete - clear the page->mapping and delete the page from
+ *                      balloon's page list accordingly.
+ * @page    : page to be released from balloon's page list
+ */
+static inline void balloon_page_delete(struct page *page)
+{
+       page->mapping = NULL;
+       /*
+        * Make sure page->mapping is cleared before we proceed with
+        * balloon's page list deletion.
+        */
+       smp_wmb();
+       list_del(&page->lru);
+}
+
+/*
+ * __is_movable_balloon_page - helper to perform @page mapping->flags tests
+ */
+static inline bool __is_movable_balloon_page(struct page *page)
+{
+       /*
+        * we might attempt to read ->mapping concurrently to other
+        * threads trying to write to it.
+        */
+       struct address_space *mapping = ACCESS_ONCE(page->mapping);
+       smp_read_barrier_depends();
+       return mapping_balloon(mapping);
+}
---8<---

The last review got rid of them to stick with Mel's ACK.


Cheers!
--Rafael
