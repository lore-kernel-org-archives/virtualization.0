From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 28 Jul 2016 00:39:14 +0300
Message-ID: <20160728003644-mutt-send-email-mst__20899.0084742711$1469655581$gmane$org@kernel.org>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<5798DB49.7030803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5798DB49.7030803@intel.com>
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

On Wed, Jul 27, 2016 at 09:03:21AM -0700, Dave Hansen wrote:
> On 07/26/2016 06:23 PM, Liang Li wrote:
> > +	vb->pfn_limit = VIRTIO_BALLOON_PFNS_LIMIT;
> > +	vb->pfn_limit = min(vb->pfn_limit, get_max_pfn());
> > +	vb->bmap_len = ALIGN(vb->pfn_limit, BITS_PER_LONG) /
> > +		 BITS_PER_BYTE + 2 * sizeof(unsigned long);
> > +	hdr_len = sizeof(struct balloon_bmap_hdr);
> > +	vb->bmap_hdr = kzalloc(hdr_len + vb->bmap_len, GFP_KERNEL);
> 
> This ends up doing a 1MB kmalloc() right?  That seems a _bit_ big.  How
> big was the pfn buffer before?


Yes I would limit this to 1G memory in a go, will result
in a 32KByte bitmap.

-- 
MST
