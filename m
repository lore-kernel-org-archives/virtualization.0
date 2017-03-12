From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Sun, 12 Mar 2017 02:07:14 +0200
Message-ID: <20170312020638-mutt-send-email-mst__35949.8972342864$1489277245$gmane$org@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<58C3E6A3.1000000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <58C3E6A3.1000000@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Liang Li <liang.z.li@intel.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liliang324@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 11, 2017 at 07:59:31PM +0800, Wei Wang wrote:
> On 03/11/2017 01:11 AM, Matthew Wilcox wrote:
> > On Fri, Mar 10, 2017 at 05:58:28PM +0200, Michael S. Tsirkin wrote:
> > > One of the issues of current balloon is the 4k page size
> > > assumption. For example if you free a huge page you
> > > have to split it up and pass 4k chunks to host.
> > > Quite often host can't free these 4k chunks at all (e.g.
> > > when it's using huge tlb fs).
> > > It's even sillier for architectures with base page size >4k.
> > I completely agree with you that we should be able to pass a hugepage
> > as a single chunk.  Also we shouldn't assume that host and guest have
> > the same page size.  I think we can come up with a scheme that actually
> > lets us encode that into a 64-bit word, something like this:
> > 
> > bit 0 clear => bits 1-11 encode a page count, bits 12-63 encode a PFN, page size 4k.
> > bit 0 set, bit 1 clear => bits 2-12 encode a page count, bits 13-63 encode a PFN, page size 8k
> > bits 0+1 set, bit 2 clear => bits 3-13 for page count, bits 14-63 for PFN, page size 16k.
> > bits 0-2 set, bit 3 clear => bits 4-14 for page count, bits 15-63 for PFN, page size 32k
> > bits 0-3 set, bit 4 clear => bits 5-15 for page count, bits 16-63 for PFN, page size 64k
> > 
> > That means we can always pass 2048 pages (of whatever page size) in a single chunk.  And
> > we support arbitrary power of two page sizes.  I suggest something like this:
> > 
> > u64 page_to_chunk(struct page *page)
> > {
> > 	u64 chunk = page_to_pfn(page) << PAGE_SHIFT;
> > 	chunk |= (1UL << compound_order(page)) - 1;
> > }
> > 
> > (note this is a single page of order N, so we leave the page count bits
> > set to 0, meaning one page).
> > 
> 
> I'm thinking what if the guest needs to transfer these much physically
> continuous
> memory to host: 1GB+2MB+64KB+32KB+16KB+4KB.
> Is it going to use Six 64-bit chunks? Would it be simpler if we just
> use the 128-bit chunk format (we can drop the previous normal 64-bit
> format)?
> 
> Best,
> Wei

I think I prefer that as a more straightforward approach, but
I can live with either approach.


-- 
MST
