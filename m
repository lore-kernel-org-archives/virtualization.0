From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 8 Mar 2019 14:48:45 -0500
Message-ID: <20190308194845.GC26923__48353.3486885548$1552074541$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
	<20190307191622.GP23850@redhat.com>
	<e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Jeson,

On Fri, Mar 08, 2019 at 04:50:36PM +0800, Jason Wang wrote:
> Just to make sure I understand here. For boosting through huge TLB, do 
> you mean we can do that in the future (e.g by mapping more userspace 
> pages to kenrel) or it can be done by this series (only about three 4K 
> pages were vmapped per virtqueue)?

When I answered about the advantages of mmu notifier and I mentioned
guaranteed 2m/gigapages where available, I overlooked the detail you
were using vmap instead of kmap. So with vmap you're actually doing
the opposite, it slows down the access because it will always use a 4k
TLB even if QEMU runs on THP or gigapages hugetlbfs.

If there's just one page (or a few pages) in each vmap there's no need
of vmap, the linearity vmap provides doesn't pay off in such
case.

So likely there's further room for improvement here that you can
achieve in the current series by just dropping vmap/vunmap.

You can just use kmap (or kmap_atomic if you're in preemptible
section, should work from bh/irq).

In short the mmu notifier to invalidate only sets a "struct page *
userringpage" pointer to NULL without calls to vunmap.

In all cases immediately after gup_fast returns you can always call
put_page immediately (which explains why I'd like an option to drop
FOLL_GET from gup_fast to speed it up).

Then you can check the sequence_counter and inc/dec counter increased
by _start/_end. That will tell you if the page you got and you called
put_page to immediately unpin it or even to free it, cannot go away
under you until the invalidate is called.

If sequence counters and counter tells that gup_fast raced with anyt
mmu notifier invalidate you can just repeat gup_fast. Otherwise you're
done, the page cannot go away under you, the host virtual to host
physical mapping cannot change either. And the page is not pinned
either. So you can just set the "struct page * userringpage = page"
where "page" was the one setup by gup_fast.

When later the invalidate runs, you can just call set_page_dirty if
gup_fast was called with "write = 1" and then you clear the pointer
"userringpage = NULL".

When you need to read/write to the memory
kmap/kmap_atomic(userringpage) should work.

In short because there's no hardware involvement here, the established
mapping is just the pointer to the page, there is no need of setting
up any pagetables or to do any TLB flushes (except on 32bit archs if
the page is above the direct mapping but it never happens on 64bit
archs).

Thanks,
Andrea
