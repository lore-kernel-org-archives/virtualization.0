From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
	virtio_direct_dma_ops selectively
Date: Mon, 30 Jul 2018 02:25:51 -0700
Message-ID: <20180730092551.GB26245__12926.3251358227$1532942638$gmane$org@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-3-khandual@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

> +const struct dma_map_ops virtio_direct_dma_ops;

This belongs into a header if it is non-static.  If you only
use it in this file anyway please mark it static and avoid a forward
declaration.

> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (virtio_has_iommu_quirk(dev))
> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

This needs a big fat comment explaining what is going on here.

Also not new, but I find the existance of virtio_has_iommu_quirk and its
name horribly confusing.  It might be better to open code it here once
only a single caller is left.
