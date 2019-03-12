From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Tue, 12 Mar 2019 17:11:17 -0400
Message-ID: <20190312211117.GB25147__22717.0351239451$1552425094$gmane$org@redhat.com>
References: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
	<20190311095405-mutt-send-email-mst@kernel.org>
	<20190311.111413.1140896328197448401.davem@davemloft.net>
	<6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
	<20190311235140-mutt-send-email-mst@kernel.org>
	<76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
	<20190312075033-mutt-send-email-mst@kernel.org>
	<1552405610.3083.17.camel@HansenPartnership.com>
	<20190312200450.GA25147@redhat.com>
	<1552424017.14432.11.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1552424017.14432.11.camel@HansenPartnership.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> I've got to say: optimize what?  What code do we ever have in the
> kernel that kmap's a page and then doesn't do anything with it? You can
> guarantee that on kunmap the page is either referenced (needs
> invalidating) or updated (needs flushing). The in-kernel use of kmap is
> always
> 
> kmap
> do something with the mapped page
> kunmap
> 
> In a very short interval.  It seems just a simplification to make
> kunmap do the flush if needed rather than try to have the users
> remember.  The thing which makes this really simple is that on most
> architectures flush and invalidate is the same operation.  If you
> really want to optimize you can use the referenced and dirty bits on
> the kmapped pte to tell you what operation to do, but if your flush is
> your invalidate, you simply assume the data needs flushing on kunmap
> without checking anything.

Except other archs like arm64 and sparc do the cache flushing on
copy_to_user_page and copy_user_page, not on kunmap.

#define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, vaddr)
void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vaddr)
{
	struct page *page = virt_to_page(kto);
	copy_page(kto, kfrom);
	flush_dcache_page(page);
}
#define copy_user_page(to, from, vaddr, page)	\
	do {	copy_page(to, from);		\
		sparc_flush_page_to_ram(page);	\
	} while (0)

And they do nothing on kunmap:

static inline void kunmap(struct page *page)
{
	BUG_ON(in_interrupt());
	if (!PageHighMem(page))
		return;
	kunmap_high(page);
}
void kunmap_high(struct page *page)
{
	unsigned long vaddr;
	unsigned long nr;
	unsigned long flags;
	int need_wakeup;
	unsigned int color = get_pkmap_color(page);
	wait_queue_head_t *pkmap_map_wait;

	lock_kmap_any(flags);
	vaddr = (unsigned long)page_address(page);
	BUG_ON(!vaddr);
	nr = PKMAP_NR(vaddr);

	/*
	 * A count must never go down to zero
	 * without a TLB flush!
	 */
	need_wakeup = 0;
	switch (--pkmap_count[nr]) {
	case 0:
		BUG();
	case 1:
		/*
		 * Avoid an unnecessary wake_up() function call.
		 * The common case is pkmap_count[] == 1, but
		 * no waiters.
		 * The tasks queued in the wait-queue are guarded
		 * by both the lock in the wait-queue-head and by
		 * the kmap_lock.  As the kmap_lock is held here,
		 * no need for the wait-queue-head's lock.  Simply
		 * test if the queue is empty.
		 */
		pkmap_map_wait = get_pkmap_wait_queue_head(color);
		need_wakeup = waitqueue_active(pkmap_map_wait);
	}
	unlock_kmap_any(flags);

	/* do wake-up, if needed, race-free outside of the spin lock */
	if (need_wakeup)
		wake_up(pkmap_map_wait);
}
static inline void kunmap(struct page *page)
{
}

because they already did it just above.


> > Which means after we fix vhost to add the flush_dcache_page after
> > kunmap, Parisc will get a double hit (but it also means Parisc was
> > the only one of those archs needed explicit cache flushes, where
> > vhost worked correctly so far.. so it kinds of proofs your point of
> > giving up being the safe choice).
> 
> What double hit?  If there's no cache to flush then cache flush is a
> no-op.  It's also a highly piplineable no-op because the CPU has the L1
> cache within easy reach.  The only event when flush takes a large
> amount time is if we actually have dirty data to write back to main
> memory.

The double hit is in parisc copy_to_user_page:

#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
do { \
	flush_cache_page(vma, vaddr, page_to_pfn(page)); \
	memcpy(dst, src, len); \
	flush_kernel_dcache_range_asm((unsigned long)dst, (unsigned long)dst + len); \
} while (0)

That is executed just before kunmap:

static inline void kunmap(struct page *page)
{
	flush_kernel_dcache_page_addr(page_address(page));
}

Can't argue about the fact your "safer" kunmap is safer, but we cannot
rely on common code unless we remove some optimization from the common
code abstractions and we make all archs do kunmap like parisc.

Thanks,
Andrea
