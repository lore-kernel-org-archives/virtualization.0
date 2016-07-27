From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Wed, 27 Jul 2016 09:03:21 -0700
Message-ID: <5798DB49.7030803__23568.7761487954$1469899221$gmane$org@intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1469582616-5729-5-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, linux-mm@kvack.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On 07/26/2016 06:23 PM, Liang Li wrote:
> +	vb->pfn_limit = VIRTIO_BALLOON_PFNS_LIMIT;
> +	vb->pfn_limit = min(vb->pfn_limit, get_max_pfn());
> +	vb->bmap_len = ALIGN(vb->pfn_limit, BITS_PER_LONG) /
> +		 BITS_PER_BYTE + 2 * sizeof(unsigned long);
> +	hdr_len = sizeof(struct balloon_bmap_hdr);
> +	vb->bmap_hdr = kzalloc(hdr_len + vb->bmap_len, GFP_KERNEL);

This ends up doing a 1MB kmalloc() right?  That seems a _bit_ big.  How
big was the pfn buffer before?
