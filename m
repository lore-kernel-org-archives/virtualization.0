From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH kernel v4 7/7] virtio-balloon: tell host vm's unused
	page info
Date: Tue, 8 Nov 2016 05:50:22 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A108196@shsmsx102.ccr.corp.intel.com>
References: <1478067447-24654-1-git-send-email-liang.z.li@intel.com>
	<1478067447-24654-8-git-send-email-liang.z.li@intel.com>
	<b25eac6e-3744-3874-93a8-02f814549adf@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A106DAA@shsmsx102.ccr.corp.intel.com>
	<281acd8d-fd94-6318-35e5-9eb130303dc6@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <281acd8d-fd94-6318-35e5-9eb130303dc6@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

> On 11/06/2016 07:37 PM, Li, Liang Z wrote:
> >> Let's say we do a 32k bitmap that can hold ~1M pages.  That's 4GB of RAM.
> >> On a 1TB system, that's 256 passes through the top-level loop.
> >> The bottom-level lists have tens of thousands of pages in them, even
> >> on my laptop.  Only 1/256 of these pages will get consumed in a given pass.
> >>
> > Your description is not exactly.
> > A 32k bitmap is used only when there is few free memory left in the
> > system and when the extend_page_bitmap() failed to allocate more
> > memory for the bitmap. Or dozens of 32k split bitmap will be used,
> > this version limit the bitmap count to 32, it means we can use at most
> > 32*32 kB for the bitmap, which can cover 128GB for RAM. We can increase
> the bitmap count limit to a larger value if 32 is not big enough.
> 
> OK, so it tries to allocate a large bitmap.  But, if it fails, it will try to work with a
> smaller bitmap.  Correct?
> 
Yes.

> So, what's the _worst_ case?  It sounds like it is even worse than I was
> positing.
> 

Only a  32KB bitmap can be allocated, and there are a huge amount of low order (<3) free pages is the worst case. 

> >> That's an awfully inefficient way of doing it.  This patch
> >> essentially changed the data structure without changing the algorithm to
> populate it.
> >>
> >> Please change the *algorithm* to use the new data structure efficiently.
> >>  Such a change would only do a single pass through each freelist, and
> >> would choose whether to use the extent-based (pfn -> range) or
> >> bitmap-based approach based on the contents of the free lists.
> >
> > Save the free page info to a raw bitmap first and then process the raw
> > bitmap to get the proper ' extent-based ' and  'bitmap-based' is the
> > most efficient way I can come up with to save the virtio data transmission.
> Do you have some better idea?
> 
> That's kinda my point.  This patch *does* processing to try to pack the
> bitmaps full of pages from the various pfn ranges.  It's a form of processing
> that gets *REALLY*, *REALLY* bad in some (admittedly obscure) cases.
> 
> Let's not pretend that making an essentially unlimited number of passes over
> the free lists is not processing.
> 
> 1. Allocate as large of a bitmap as you can. (what you already do) 2. Iterate
> from the largest freelist order.  Store those pages in the
>    bitmap.
> 3. If you can no longer fit pages in the bitmap, return the list that
>    you have.
> 4. Make an approximation about where the bitmap does not make any more,
>    and fall back to listing individual PFNs.  This would make sens, for
>    instance in a large zone with very few free order-0 pages left.
> 
Sounds good.  Should we ignore some of the order-0 pages in step 4 if the bitmap is full?
Or should retry to get a complete list of order-0 pages?

> 
> > It seems the benefit we get for this feature is not as big as that in fast
> balloon inflating/deflating.
> >>
> >> You should not be using get_max_pfn().  Any patch set that continues
> >> to use it is not likely to be using a proper algorithm.
> >
> > Do you have any suggestion about how to avoid it?
> 
> Yes: get the pfns from the page free lists alone.  Don't derive them from the
> pfn limits of the system or zones.

The ' get_max_pfn()' can be avoid in this patch, but I think we can't avoid it completely.
We need it as a hint for allocating a proper size bitmap. No?

Thanks!
Liang
