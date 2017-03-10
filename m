From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Fri, 10 Mar 2017 21:10:53 +0200
Message-ID: <20170310211037-mutt-send-email-mst__35548.4680542306$1489173065$gmane$org@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170310171143.GA16328@bombadil.infradead.org>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org, Amit Shah <amit.shah@redhat.com>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Liang Li <liliang324@gmail.com>, linux-mm@kvack.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 10, 2017 at 09:11:44AM -0800, Matthew Wilcox wrote:
> On Fri, Mar 10, 2017 at 05:58:28PM +0200, Michael S. Tsirkin wrote:
> > One of the issues of current balloon is the 4k page size
> > assumption. For example if you free a huge page you
> > have to split it up and pass 4k chunks to host.
> > Quite often host can't free these 4k chunks at all (e.g.
> > when it's using huge tlb fs).
> > It's even sillier for architectures with base page size >4k.
> 
> I completely agree with you that we should be able to pass a hugepage
> as a single chunk.  Also we shouldn't assume that host and guest have
> the same page size.  I think we can come up with a scheme that actually
> lets us encode that into a 64-bit word, something like this:
> 
> bit 0 clear => bits 1-11 encode a page count, bits 12-63 encode a PFN, page size 4k.
> bit 0 set, bit 1 clear => bits 2-12 encode a page count, bits 13-63 encode a PFN, page size 8k
> bits 0+1 set, bit 2 clear => bits 3-13 for page count, bits 14-63 for PFN, page size 16k.
> bits 0-2 set, bit 3 clear => bits 4-14 for page count, bits 15-63 for PFN, page size 32k
> bits 0-3 set, bit 4 clear => bits 5-15 for page count, bits 16-63 for PFN, page size 64k

huge page sizes go up to gigabytes.

> That means we can always pass 2048 pages (of whatever page size) in a single chunk.  And
> we support arbitrary power of two page sizes.  I suggest something like this:
> 
> u64 page_to_chunk(struct page *page)
> {
> 	u64 chunk = page_to_pfn(page) << PAGE_SHIFT;
> 	chunk |= (1UL << compound_order(page)) - 1;
> }
> 
> (note this is a single page of order N, so we leave the page count bits
> set to 0, meaning one page).
> 
> > Two things to consider:
> > - host should pass its base page size to guest
> >   this can be a separate patch and for now we can fall back on 12 bit if not there
> 
> With this encoding scheme, I don't think we need to do this?  As long as
> it's *at least* 12 bit, then we're fine.
> 
> > - guest should pass full huge pages to host
> >   this should be done correctly to avoid breaking up huge pages
> >   I would say yes let's use a single format but drop the "normal chunk"
> >   and always use the extended one.
> >   Also, size is in units of 4k, right? Please document that low 12 bit
> >   are reserved, they will be handy as e.g. flags.
> 
> What per-chunk flags are you thinking would be useful?
