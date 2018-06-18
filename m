From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Date: Mon, 18 Jun 2018 05:16:02 +0300
Message-ID: <20180618051145-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
	<20180616045005.GA14936@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180616045005.GA14936@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 15, 2018 at 09:50:05PM -0700, Matthew Wilcox wrote:
> I wonder if (to address Michael's concern), you shouldn't instead use
> the first free chunk of pages to return the addresses of all the pages.
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
> 					ret = addr;
> 				}
> 				ret[index++] = cpu_to_le64(addr);
> 			}
> 		}
> 		spin_unlock_irq(&zone->lock);
> 	}
> 
> 	return ret;
> }
> 
> You'll need to return the page to the freelist afterwards, but free_pages()
> should take care of that.

Yes Wei already came up with the idea to stick this data into a
MAX_ORDER allocation. Are you sure just taking an entry off
the list like that has no bad side effects?
I have a vague memory someone complained that everyone
most go through get free pages/kmalloc, but I can't
find that anymore.


-- 
MST
