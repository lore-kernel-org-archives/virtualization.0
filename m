From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 6/7] mm: add the related functions to get free
	page info
Date: Thu, 28 Jul 2016 00:10:16 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213C27__29796.0456963212$1469664638$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-7-git-send-email-liang.z.li@intel.com>
	<5798E418.7080608@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5798E418.7080608@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH v2 repost 6/7] mm: add the related functions to get free
> page info
> 
> On 07/26/2016 06:23 PM, Liang Li wrote:
> > +	for_each_migratetype_order(order, t) {
> > +		list_for_each(curr, &zone->free_area[order].free_list[t]) {
> > +			pfn = page_to_pfn(list_entry(curr, struct page, lru));
> > +			if (pfn >= start_pfn && pfn <= end_pfn) {
> > +				page_num = 1UL << order;
> > +				if (pfn + page_num > end_pfn)
> > +					page_num = end_pfn - pfn;
> > +				bitmap_set(bitmap, pfn - start_pfn,
> page_num);
> > +			}
> > +		}
> > +	}
> 
> Nit:  The 'page_num' nomenclature really confused me here.  It is the
> number of bits being set in the bitmap.  Seems like calling it nr_pages or
> num_pages would be more appropriate.
> 

You are right,  will change.

> Isn't this bitmap out of date by the time it's send up to the hypervisor?  Is
> there something that makes the inaccuracy OK here?

Yes. The dirty page logging will be used to correct the inaccuracy.
The dirty page logging should be started before getting the free page bitmap, then if some of the free pages become no free for writing, these pages will be tracked by the dirty page logging mechanism.

Thanks!
Liang
