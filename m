From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 repost 6/7] mm: add the related functions to get free
	page info
Date: Thu, 28 Jul 2016 03:17:00 +0300
Message-ID: <20160728031629-mutt-send-email-mst__42157.6906148859$1469665040$gmane$org@kernel.org>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-7-git-send-email-liang.z.li@intel.com>
	<5798E418.7080608@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E04213C27@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E04213C27@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 28, 2016 at 12:10:16AM +0000, Li, Liang Z wrote:
> > Subject: Re: [PATCH v2 repost 6/7] mm: add the related functions to get free
> > page info
> > 
> > On 07/26/2016 06:23 PM, Liang Li wrote:
> > > +	for_each_migratetype_order(order, t) {
> > > +		list_for_each(curr, &zone->free_area[order].free_list[t]) {
> > > +			pfn = page_to_pfn(list_entry(curr, struct page, lru));
> > > +			if (pfn >= start_pfn && pfn <= end_pfn) {
> > > +				page_num = 1UL << order;
> > > +				if (pfn + page_num > end_pfn)
> > > +					page_num = end_pfn - pfn;
> > > +				bitmap_set(bitmap, pfn - start_pfn,
> > page_num);
> > > +			}
> > > +		}
> > > +	}
> > 
> > Nit:  The 'page_num' nomenclature really confused me here.  It is the
> > number of bits being set in the bitmap.  Seems like calling it nr_pages or
> > num_pages would be more appropriate.
> > 
> 
> You are right,  will change.
> 
> > Isn't this bitmap out of date by the time it's send up to the hypervisor?  Is
> > there something that makes the inaccuracy OK here?
> 
> Yes. The dirty page logging will be used to correct the inaccuracy.
> The dirty page logging should be started before getting the free page bitmap, then if some of the free pages become no free for writing, these pages will be tracked by the dirty page logging mechanism.
> 
> Thanks!
> Liang

Right but this should be clear from code and naming.
