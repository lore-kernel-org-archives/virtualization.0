From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [virtio-dev] Re: [PATCH v2 repost 4/7] virtio-balloon: speed up
	inflate/deflate process
Date: Tue, 2 Aug 2016 00:28:19 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04216308__338.438622611825$1470097713$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<5798DB49.7030803@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E04213CCB@shsmsx102.ccr.corp.intel.com>
	<20160728044000-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E04214103@shsmsx102.ccr.corp.intel.com>
	<20160729003759-mutt-send-email-mst@kernel.org>
	<579BB30B.2040704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <579BB30B.2040704@intel.com>
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

> > It's only small because it makes you rescan the free list.
> > So maybe you should do something else.
> > I looked at it a bit. Instead of scanning the free list, how about
> > scanning actual page structures? If page is unused, pass it to host.
> > Solves the problem of rescanning multiple times, does it not?
> 
> FWIW, I think the new data structure needs some work.
> 
> Before, we had a potentially very long list of 4k areas.  Now, we've just got a
> very large bitmap.  The bitmap might not even be very dense if we are
> ballooning relatively few things.
> 
> Can I suggest an alternate scheme?  I think you actually need a hybrid
> scheme that has bitmaps but also allows more flexibility in the pfn ranges.
> The payload could be a number of records each containing 3 things:
> 
> 	pfn, page order, length of bitmap (maybe in powers of 2)
> 
> Each record is followed by the bitmap.  Or, if the bitmap length is 0,
> immediately followed by another record.  A bitmap length of 0 implies a
> bitmap with the least significant bit set.  Page order specifies how many
> pages each bit represents.
> 
> This scheme could easily encode the new data structure you are proposing
> by just setting pfn=0, order=0, and a very long bitmap length.  But, it could
> handle sparse bitmaps much better *and* represent large pages much more
> efficiently.
> 
> There's plenty of space to fit a whole record in 64 bits.

I like your idea and it's more flexible, and it's very useful if we want to optimize the
page allocating stage further. I believe the memory fragmentation will not be very
serious, so the performance won't be too bad in the worst case.

Thanks!
Liang
