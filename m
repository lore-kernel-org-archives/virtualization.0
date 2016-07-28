From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 28 Jul 2016 01:13:35 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213CCB@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<5798DB49.7030803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5798DB49.7030803@intel.com>
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

> Subject: Re: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
> process
> 
> On 07/26/2016 06:23 PM, Liang Li wrote:
> > +	vb->pfn_limit = VIRTIO_BALLOON_PFNS_LIMIT;
> > +	vb->pfn_limit = min(vb->pfn_limit, get_max_pfn());
> > +	vb->bmap_len = ALIGN(vb->pfn_limit, BITS_PER_LONG) /
> > +		 BITS_PER_BYTE + 2 * sizeof(unsigned long);
> > +	hdr_len = sizeof(struct balloon_bmap_hdr);
> > +	vb->bmap_hdr = kzalloc(hdr_len + vb->bmap_len, GFP_KERNEL);
> 
> This ends up doing a 1MB kmalloc() right?  That seems a _bit_ big.  How big
> was the pfn buffer before?

Yes, it is if the max pfn is more than 32GB.
The size of the pfn buffer use before is 256*4 = 1024 Bytes, it's too small, 
and it's the main reason for bad performance.
Use the max 1MB kmalloc is a balance between performance and flexibility,
a large page bitmap covers the range of all the memory is no good for a system
with huge amount of memory. If the bitmap is too small, it means we have
to traverse a long list for many times, and it's bad for performance.

Thanks!
Liang   
