From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited against
	NULL dma_mask
Date: Mon, 22 Jul 2019 17:46:00 +0200
Message-ID: <e1e02286-ccf9-3335-28c8-0c6b122b05a1__27564.4663766556$1563810421$gmane$org@redhat.com>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-2-eric.auger@redhat.com>
	<20190722152637.GA3780@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190722152637.GA3780@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Christoph,

On 7/22/19 5:26 PM, Christoph Hellwig wrote:
>>  static inline bool dma_addressing_limited(struct device *dev)
>>  {
>> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
>> -		dma_get_required_mask(dev);
>> +	return WARN_ON_ONCE(!dev->dma_mask) ? false :
>> +		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
>> +			dma_get_required_mask(dev);
> 
> This should really use a separate if statement, but I can fix that
> up when applying it.
> 
Just wondering why we don't use the dma_get_mask() accessor which
returns DMA_BIT_MASK(32) in case the dma_mask is not set.

Do you foresee any issue and would it still mandate to add dma_mask
checks on each call sites?

Thanks

Eric
