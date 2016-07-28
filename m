From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 28 Jul 2016 03:30:09 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213E5D__19106.0278135867$1469676654$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<5798DB49.7030803@intel.com>
	<20160728003644-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728003644-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
> process
> 
> On Wed, Jul 27, 2016 at 09:03:21AM -0700, Dave Hansen wrote:
> > On 07/26/2016 06:23 PM, Liang Li wrote:
> > > +	vb->pfn_limit = VIRTIO_BALLOON_PFNS_LIMIT;
> > > +	vb->pfn_limit = min(vb->pfn_limit, get_max_pfn());
> > > +	vb->bmap_len = ALIGN(vb->pfn_limit, BITS_PER_LONG) /
> > > +		 BITS_PER_BYTE + 2 * sizeof(unsigned long);
> > > +	hdr_len = sizeof(struct balloon_bmap_hdr);
> > > +	vb->bmap_hdr = kzalloc(hdr_len + vb->bmap_len, GFP_KERNEL);
> >
> > This ends up doing a 1MB kmalloc() right?  That seems a _bit_ big.
> > How big was the pfn buffer before?
> 
> 
> Yes I would limit this to 1G memory in a go, will result in a 32KByte bitmap.
> 
> --
> MST

Limit to 1G is bad for the performance, I sent you the test result several weeks ago.

Paste it bellow:
------------------------------------------------------------------------------------------------------------------------
About the size of page bitmap, I have test the performance of filling the balloon to 15GB with a
 16GB RAM VM.

===============================
32K Byte (cover 1GB of RAM)

Time spends on inflating: 2031ms
---------------------------------------------
64K Byte (cover 2GB of RAM)

Time spends on inflating: 1507ms
--------------------------------------------
512K Byte (cover 16GB of RAM)

Time spends on inflating: 1237ms
================================

If possible, a big bitmap is better for performance.

Liang
