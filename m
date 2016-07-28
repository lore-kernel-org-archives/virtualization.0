From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 28 Jul 2016 04:45:52 +0300
Message-ID: <20160728044000-mutt-send-email-mst__17099.2580395707$1469670373$gmane$org@kernel.org>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<5798DB49.7030803@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E04213CCB@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E04213CCB@shsmsx102.ccr.corp.intel.com>
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

On Thu, Jul 28, 2016 at 01:13:35AM +0000, Li, Liang Z wrote:
> > Subject: Re: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
> > process
> > 
> > On 07/26/2016 06:23 PM, Liang Li wrote:
> > > +	vb->pfn_limit = VIRTIO_BALLOON_PFNS_LIMIT;
> > > +	vb->pfn_limit = min(vb->pfn_limit, get_max_pfn());
> > > +	vb->bmap_len = ALIGN(vb->pfn_limit, BITS_PER_LONG) /
> > > +		 BITS_PER_BYTE + 2 * sizeof(unsigned long);
> > > +	hdr_len = sizeof(struct balloon_bmap_hdr);
> > > +	vb->bmap_hdr = kzalloc(hdr_len + vb->bmap_len, GFP_KERNEL);
> > 
> > This ends up doing a 1MB kmalloc() right?  That seems a _bit_ big.  How big
> > was the pfn buffer before?
> 
> Yes, it is if the max pfn is more than 32GB.
> The size of the pfn buffer use before is 256*4 = 1024 Bytes, it's too small, 
> and it's the main reason for bad performance.
> Use the max 1MB kmalloc is a balance between performance and flexibility,
> a large page bitmap covers the range of all the memory is no good for a system
> with huge amount of memory. If the bitmap is too small, it means we have
> to traverse a long list for many times, and it's bad for performance.
> 
> Thanks!
> Liang   

There are all your implementation decisions though.

If guest memory is so fragmented that you only have order 0 4k pages,
then allocating a huge 1M contigious chunk is very problematic
in and of itself.

Most people rarely migrate and do not care how fast that happens.
Wasting a large chunk of memory (and it's zeroed for no good reason, so you
actually request host memory for it) for everyone to speed it up
when it does happen is not really an option.

-- 
MST
