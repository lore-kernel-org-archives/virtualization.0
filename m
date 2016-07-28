From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 6/7] mm: add the related functions to get free
	page info
Date: Thu, 28 Jul 2016 04:36:46 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213EBF__27487.9598677673$1469680642$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-7-git-send-email-liang.z.li@intel.com>
	<5798E418.7080608@intel.com>
	<20160728010030-mutt-send-email-mst@kernel.org>
	<579932D9.6000106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <579932D9.6000106@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On 07/27/2016 03:05 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 27, 2016 at 09:40:56AM -0700, Dave Hansen wrote:
> >> On 07/26/2016 06:23 PM, Liang Li wrote:
> >>> +	for_each_migratetype_order(order, t) {
> >>> +		list_for_each(curr, &zone->free_area[order].free_list[t]) {
> >>> +			pfn = page_to_pfn(list_entry(curr, struct page, lru));
> >>> +			if (pfn >= start_pfn && pfn <= end_pfn) {
> >>> +				page_num = 1UL << order;
> >>> +				if (pfn + page_num > end_pfn)
> >>> +					page_num = end_pfn - pfn;
> >>> +				bitmap_set(bitmap, pfn - start_pfn,
> page_num);
> >>> +			}
> >>> +		}
> >>> +	}
> >>
> >> Nit:  The 'page_num' nomenclature really confused me here.  It is the
> >> number of bits being set in the bitmap.  Seems like calling it
> >> nr_pages or num_pages would be more appropriate.
> >>
> >> Isn't this bitmap out of date by the time it's send up to the
> >> hypervisor?  Is there something that makes the inaccuracy OK here?
> >
> > Yes. Calling these free pages is unfortunate. It's likely to confuse
> > people thinking they can just discard these pages.
> >
> > Hypervisor sends a request. We respond with this list of pages, and
> > the guarantee hypervisor needs is that these were free sometime
> > between request and response, so they are safe to free if they are
> > unmodified since the request. hypervisor can detect modifications so
> > it can detect modifications itself and does not need guest help.
> 
> Ahh, that makes sense.
> 
> So the hypervisor is trying to figure out: "Which pages do I move?".  It wants
> to know which pages the guest thinks have good data and need to move.
> But, the list of free pages is (likely) smaller than the list of pages with good
> data, so it asks for that instead.
> 
> A write to a page means that it has valuable data, regardless of whether it
> was in the free list or not.
> 
> The hypervisor only skips moving pages that were free *and* were never
> written to.  So we never lose data, even if this "get free page info"
> stuff is totally out of date.
> 
> The patch description and code comments are, um, a _bit_ light for this level
> of subtlety. :)

I will add more description about this in v3.

Thanks!
Liang
