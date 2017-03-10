From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Fri, 10 Mar 2017 13:18:25 -0800
Message-ID: <20170310211825.GB16328__42068.8452585184$1490017498$gmane$org@bombadil.infradead.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<20170310211037-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170310211037-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org, Amit Shah <amit.shah@redhat.com>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Liang Li <liliang324@gmail.com>, linux-mm@kvack.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 10, 2017 at 09:10:53PM +0200, Michael S. Tsirkin wrote:
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
> 
> huge page sizes go up to gigabytes.

There was supposed to be a '...' there.  For a 16GB hugepage (largest
size I know of today), that'd be:

bits 0-21 set, 22 clear, 23-33 page count, 34-63 PFN, page size 16G
