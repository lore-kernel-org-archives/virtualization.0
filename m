From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Date: Tue, 15 Jan 2019 14:37:54 +0100
Message-ID: <20190115133754.GB29225__42662.4684747823$1547692358$gmane$org@lst.de>
References: <20190115132257.6426-1-joro@8bytes.org>
	<20190115132257.6426-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190115132257.6426-3-joro@8bytes.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, jroedel@suse.de, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

> +size_t dma_direct_max_mapping_size(struct device *dev)
> +{
> +	/*
> +	 * Return the minimum of the direct DMA limit and the SWIOTLB limit.
> +	 * Since direct DMA has no limit, it is fine to just return the SWIOTLB
> +	 * limit.
> +	 */
> +	return swiotlb_max_mapping_size(dev);

Well, if we don't actually use the swiotlb buffers despite it being
compiled in or even allocated we don't need the limit.
