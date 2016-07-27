From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 repost 6/7] mm: add the related functions to get free
	page info
Date: Thu, 28 Jul 2016 01:05:12 +0300
Message-ID: <20160728010030-mutt-send-email-mst__43440.2620922357$1469657140$gmane$org@kernel.org>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-7-git-send-email-liang.z.li@intel.com>
	<5798E418.7080608@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5798E418.7080608@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Liang Li <liang.z.li@intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 27, 2016 at 09:40:56AM -0700, Dave Hansen wrote:
> On 07/26/2016 06:23 PM, Liang Li wrote:
> > +	for_each_migratetype_order(order, t) {
> > +		list_for_each(curr, &zone->free_area[order].free_list[t]) {
> > +			pfn = page_to_pfn(list_entry(curr, struct page, lru));
> > +			if (pfn >= start_pfn && pfn <= end_pfn) {
> > +				page_num = 1UL << order;
> > +				if (pfn + page_num > end_pfn)
> > +					page_num = end_pfn - pfn;
> > +				bitmap_set(bitmap, pfn - start_pfn, page_num);
> > +			}
> > +		}
> > +	}
> 
> Nit:  The 'page_num' nomenclature really confused me here.  It is the
> number of bits being set in the bitmap.  Seems like calling it nr_pages
> or num_pages would be more appropriate.
> 
> Isn't this bitmap out of date by the time it's send up to the
> hypervisor?  Is there something that makes the inaccuracy OK here?

Yes. Calling these free pages is unfortunate. It's likely to confuse
people thinking they can just discard these pages.

Hypervisor sends a request. We respond with this list of pages, and
the guarantee hypervisor needs is that these were free sometime between request
and response, so they are safe to free if they are unmodified
since the request. hypervisor can detect modifications so
it can detect modifications itself and does not need guest help.

Maybe just call these "free if unmodified" and reflect this
everywhere - verbose but hey. Better naming suggestions would be
welcome.

-- 
MST
