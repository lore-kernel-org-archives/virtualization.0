From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Thu, 25 Jul 2019 15:04:16 +0200
Message-ID: <20190725130416.GA4992__24833.1088035897$1564059875$gmane$org@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
	<e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
	<20190723153851.GE720@lst.de>
	<fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Auger Eric <eric.auger@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 25, 2019 at 01:53:49PM +0200, Auger Eric wrote:
> I am confused: if vring_use_dma_api() returns false if the dma_mask is
> unset (ie. vring_use_dma_api() returns false), the virtio-blk-pci device
> will not be able to get translated addresses and won't work properly.
> 
> The patch above allows the dma api to be used and only influences the
> max_segment_size and it works properly.
> 
> So is it normal the dma_mask is unset in my case?

Its not normal.  I assume you use virtio-nmio?  Due to the mess with
the dma_mask being a pointer a lot of subsystems forgot to set a dma
mask up, and oddly enough seem to mostly get away with it.
