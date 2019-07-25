From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Thu, 25 Jul 2019 18:32:14 +0200
Message-ID: <11b7b5e4-2de7-2089-57d2-d0a138f94376__17580.0285347336$1564072357$gmane$org@redhat.com>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
	<e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
	<20190723153851.GE720@lst.de>
	<fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
	<20190725130416.GA4992@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190725130416.GA4992@lst.de>
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
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Christoph, Michael,

On 7/25/19 3:04 PM, Christoph Hellwig wrote:
> On Thu, Jul 25, 2019 at 01:53:49PM +0200, Auger Eric wrote:
>> I am confused: if vring_use_dma_api() returns false if the dma_mask is
>> unset (ie. vring_use_dma_api() returns false), the virtio-blk-pci device
>> will not be able to get translated addresses and won't work properly.
>>
>> The patch above allows the dma api to be used and only influences the
>> max_segment_size and it works properly.
>>
>> So is it normal the dma_mask is unset in my case?
> 
> Its not normal.  I assume you use virtio-nmio?  Due to the mess with
> the dma_mask being a pointer a lot of subsystems forgot to set a dma
> mask up, and oddly enough seem to mostly get away with it.
> 

No the issue is encountered with virtio-blk-pci

I think the problem is virtio_max_dma_size() is called from
virtblk_probe (virtio_blk.c) on the virtio<n> device and not the actual
virtio_pci_device which has a dma_mask set. I don't think the virtio<n>
device ever has a dma_mask set.

We do not hit the guest crash on the virtio-net-pci device as the
virtio-net driver does not call virtio_max_dma_size() on the virtio<n>
device.

Does fd1068e1860e ("virtio-blk: Consider virtio_max_dma_size() for
maximum segment size") call virtio_max_dma_size() on the right device?

Thanks

Eric
