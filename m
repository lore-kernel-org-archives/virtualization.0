From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
	against NULL dma_mask
Date: Mon, 22 Jul 2019 17:26:38 +0200
Message-ID: <20190722152637.GA3780__28009.7125609004$1563809220$gmane$org@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-2-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190722145509.1284-2-eric.auger@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Auger <eric.auger@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return WARN_ON_ONCE(!dev->dma_mask) ? false :
> +		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> +			dma_get_required_mask(dev);

This should really use a separate if statement, but I can fix that
up when applying it.
