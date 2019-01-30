From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/5 v5] Fix virtio-blk issue with SWIOTLB
Date: Wed, 30 Jan 2019 18:11:48 +0000
Message-ID: <616969d8-c03a-5d24-8112-11dd1f60dd9b__40199.5124806248$1548872872$gmane$org@amd.com>
References: <20190130164007.26497-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190130164007.26497-1-joro@8bytes.org>
Content-Language: en-US
Content-ID: <BA468A5C6C008B43B282A2B28B182289@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "jroedel@suse.de" <jroedel@suse.de>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "Grimm,
	Jon" <Jon.Grimm@amd.com>, "jfehlig@suse.com" <jfehlig@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 1/30/19 10:40 AM, Joerg Roedel wrote:
> Hi,
> 
> here is the next version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> 	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/
> 
> 	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v4 are:
> 
> 	- Added Reviewed-by tags from Christoph
> 
> 	- Added missing EXPORT_SYMBOL(_GPL) lines
> 
> Please review.

Looks good. Booted and tested using an SEV guest without any issues.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks,
Tom

> 
> Thanks,
> 
> 	Joerg
> Joerg Roedel (5):
>   swiotlb: Introduce swiotlb_max_mapping_size()
>   swiotlb: Add is_swiotlb_active() function
>   dma: Introduce dma_max_mapping_size()
>   virtio: Introduce virtio_max_dma_size()
>   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> 
>  Documentation/DMA-API.txt    |  8 ++++++++
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 11 +++++++++++
>  include/linux/dma-mapping.h  | 16 ++++++++++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 12 ++++++++++++
>  kernel/dma/swiotlb.c         | 14 ++++++++++++++
>  8 files changed, 80 insertions(+), 4 deletions(-)
> 
