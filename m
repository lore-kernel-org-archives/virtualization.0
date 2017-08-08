From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v13 4/5] mm: support reporting free page blocks
Date: Tue, 08 Aug 2017 14:12:56 +0800
Message-ID: <59895668.9090104__19386.4651061178$1502172655$gmane$org@intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
	<1501742299-4369-5-git-send-email-wei.w.wang@intel.com>
	<20170803091151.GF12521@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170803091151.GF12521@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, amit.shah@redhat.com, liliang.opensource@gmail.com, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/03/2017 05:11 PM, Michal Hocko wrote:
> On Thu 03-08-17 14:38:18, Wei Wang wrote:
> This is just too ugly and wrong actually. Never provide struct page
> pointers outside of the zone->lock. What I've had in mind was to simply
> walk free lists of the suitable order and call the callback for each one.
> Something as simple as
>
> 	for (i = 0; i < MAX_NR_ZONES; i++) {
> 		struct zone *zone = &pgdat->node_zones[i];
>
> 		if (!populated_zone(zone))
> 			continue;

Can we directly use for_each_populated_zone(zone) here?


> 		spin_lock_irqsave(&zone->lock, flags);
> 		for (order = min_order; order < MAX_ORDER; ++order) {


This appears to be covered by for_each_migratetype_order(order, mt) below.


> 			struct free_area *free_area = &zone->free_area[order];
> 			enum migratetype mt;
> 			struct page *page;
>
> 			if (!free_area->nr_pages)
> 				continue;
>
> 			for_each_migratetype_order(order, mt) {
> 				list_for_each_entry(page,
> 						&free_area->free_list[mt], lru) {
>
> 					pfn = page_to_pfn(page);
> 					visit(opaque2, prn, 1<<order);
> 				}
> 			}
> 		}
>
> 		spin_unlock_irqrestore(&zone->lock, flags);
> 	}
>
> [...]
>

What do you think if we further simply the above implementation like this:

for_each_populated_zone(zone) {
                 for_each_migratetype_order_decend(1, order, mt) {
                         spin_lock_irqsave(&zone->lock, flags);
                         list_for_each_entry(page,
&zone->free_area[order].free_list[mt], lru) {
                                 pfn = page_to_pfn(page);
                                 visit(opaque1, pfn, 1 << order);
                         }
                         spin_unlock_irqrestore(&zone->lock, flags);
                 }
         }


Best,
Wei
