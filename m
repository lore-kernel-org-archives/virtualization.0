From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Date: Thu, 31 Jan 2019 11:41:29 +0100
Message-ID: <20190131104129.GA9241__6023.01285123161$1548967498$gmane$org@lst.de>
References: <20190130164007.26497-1-joro@8bytes.org>
	<20190130164007.26497-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190130164007.26497-4-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jens Axboe <axboe@kernel.dk>, Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, jroedel@suse.de, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

> +static inline size_t dma_max_mapping_size(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	size_t size = SIZE_MAX;
> +
> +	if (dma_is_direct(ops))
> +		size = dma_direct_max_mapping_size(dev);
> +	else if (ops && ops->max_mapping_size)
> +		size = ops->max_mapping_size(dev);
> +
> +	return size;
> +}

Sorry for not noticing last time, but since 5.0 we keep all non-fast
path DMA mapping interfaces out of line, so this should move to
kernel/dma/mapping.c.

> +EXPORT_SYMBOL(dma_direct_max_mapping_size);

And then there is no need to export this one.

The dma_max_mapping_size export should be EXPORT_SYMBOL_GPL like all
new dma-mapping interfaces.
