From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v33 1/4] mm: add a function to get free page blocks
Date: Sun, 17 Jun 2018 00:07:40 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A6415@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
	<20180616045005.GA14936@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180616045005.GA14936@bombadil.infradead.org>
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
To: 'Matthew Wilcox' <willy@infradead.org>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday, June 16, 2018 12:50 PM, Matthew Wilcox wrote:
> On Fri, Jun 15, 2018 at 12:43:10PM +0800, Wei Wang wrote:
> > +/**
> > + * get_from_free_page_list - get free page blocks from a free page
> > +list
> > + * @order: the order of the free page list to check
> > + * @buf: the array to store the physical addresses of the free page
> > +blocks
> > + * @size: the array size
> > + *
> > + * This function offers hints about free pages. There is no guarantee
> > +that
> > + * the obtained free pages are still on the free page list after the
> > +function
> > + * returns. pfn_to_page on the obtained free pages is strongly
> > +discouraged
> > + * and if there is an absolute need for that, make sure to contact MM
> > +people
> > + * to discuss potential problems.
> > + *
> > + * The addresses are currently stored to the array in little endian.
> > +This
> > + * avoids the overhead of converting endianness by the caller who
> > +needs data
> > + * in the little endian format. Big endian support can be added on
> > +demand in
> > + * the future.
> > + *
> > + * Return the number of free page blocks obtained from the free page list.
> > + * The maximum number of free page blocks that can be obtained is
> > +limited to
> > + * the caller's array size.
> > + */
> 
> Please use:
> 
>  * Return: The number of free page blocks obtained from the free page list.
> 
> Also, please include a
> 
>  * Context: Any context.
> 
> or
> 
>  * Context: Process context.
> 
> or whatever other conetext this function can be called from.  Since you're
> taking the lock irqsafe, I assume this can be called from any context, but I
> wonder if it makes sense to have this function callable from interrupt context.
> Maybe this should be callable from process context only.

Thanks, sounds better to make it process context only.

> 
> > +uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t
> > +size) {
> > +	struct zone *zone;
> > +	enum migratetype mt;
> > +	struct page *page;
> > +	struct list_head *list;
> > +	unsigned long addr, flags;
> > +	uint32_t index = 0;
> > +
> > +	for_each_populated_zone(zone) {
> > +		spin_lock_irqsave(&zone->lock, flags);
> > +		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> > +			list = &zone->free_area[order].free_list[mt];
> > +			list_for_each_entry(page, list, lru) {
> > +				addr = page_to_pfn(page) << PAGE_SHIFT;
> > +				if (likely(index < size)) {
> > +					buf[index++] = cpu_to_le64(addr);
> > +				} else {
> > +					spin_unlock_irqrestore(&zone->lock,
> > +							       flags);
> > +					return index;
> > +				}
> > +			}
> > +		}
> > +		spin_unlock_irqrestore(&zone->lock, flags);
> > +	}
> > +
> > +	return index;
> > +}
> 
> I wonder if (to address Michael's concern), you shouldn't instead use the first
> free chunk of pages to return the addresses of all the pages.
> ie something like this:
> 
> 	__le64 *ret = NULL;
> 	unsigned int max = (PAGE_SIZE << order) / sizeof(__le64);
> 
> 	for_each_populated_zone(zone) {
> 		spin_lock_irq(&zone->lock);
> 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> 			list = &zone->free_area[order].free_list[mt];
> 			list_for_each_entry_safe(page, list, lru, ...) {
> 				if (index == size)
> 					break;
> 				addr = page_to_pfn(page) << PAGE_SHIFT;
> 				if (!ret) {
> 					list_del(...);

Thanks for sharing. But probably we would not take this approach for the reasons below:

1) I'm not sure if getting a block of free pages to use could be that simple (just pluck it from the list as above). I think it is more prudent to let the callers allocate the array via the regular allocation functions. 

2) Callers may need to use this with their own defined protocols, and they want the header and payload (i.e. the obtained hints) to locate in physically continuous memory (there are tricks they can use to make it work with non-physically continuous memory, but that would just complicate all the things) . In this case, it is better to have callers allocate the memory on their own, and pass the payload part memory to this API to get the payload filled.

Best,
Wei
