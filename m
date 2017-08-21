From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v14 4/5] mm: support reporting free page blocks
Date: Mon, 21 Aug 2017 08:18:12 +0200
Message-ID: <20170821061812.GB13724__3501.1678039611$1503296304$gmane$org@dhcp22.suse.cz>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
	<20170818201946-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170818201946-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri 18-08-17 20:23:05, Michael S. Tsirkin wrote:
> On Thu, Aug 17, 2017 at 11:26:55AM +0800, Wei Wang wrote:
[...]
> > +void walk_free_mem_block(void *opaque1,
> > +			 unsigned int min_order,
> > +			 void (*visit)(void *opaque2,
> 
> You can just avoid opaque2 completely I think, then opaque1 can
> be renamed opaque.
> 
> > +				       unsigned long pfn,
> > +				       unsigned long nr_pages))
> > +{
> > +	struct zone *zone;
> > +	struct page *page;
> > +	struct list_head *list;
> > +	unsigned int order;
> > +	enum migratetype mt;
> > +	unsigned long pfn, flags;
> > +
> > +	for_each_populated_zone(zone) {
> > +		for (order = MAX_ORDER - 1;
> > +		     order < MAX_ORDER && order >= min_order; order--) {
> > +			for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> > +				spin_lock_irqsave(&zone->lock, flags);
> > +				list = &zone->free_area[order].free_list[mt];
> > +				list_for_each_entry(page, list, lru) {
> > +					pfn = page_to_pfn(page);
> > +					visit(opaque1, pfn, 1 << order);
> 
> My only concern here is inability of callback to
> 1. break out of list
> 2. remove page from the list

As I've said before this has to be a read only API. You cannot simply
fiddle with the page allocator internals under its feet.

> So I would make the callback bool, and I would use
> list_for_each_entry_safe.

If a bool would tell to break out of the loop then I agree. This sounds
useful.
-- 
Michal Hocko
SUSE Labs
