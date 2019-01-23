From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/5 v3] Fix virtio-blk issue with SWIOTLB
Date: Wed, 23 Jan 2019 12:09:48 -0500
Message-ID: <20190123170946.GB22672__4815.56514730386$1548263634$gmane$org@Konrads-MacBook-Pro.local>
References: <20190123163049.24863-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-1-joro@8bytes.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, jroedel@suse.de, brijesh.singh@amd.com, "Michael S . Tsirkin" <mst@redhat.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 23, 2019 at 05:30:44PM +0100, Joerg Roedel wrote:
> Hi,
> 
> here is the third version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v2 are:
> 
> 	* Check if SWIOTLB is active before returning its limit in
> 	  dma_direct_max_mapping_size()
> 
> 	* Only apply the maximum segment limit in virtio-blk when
> 	  DMA-API is used for the vring
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>   swiotlb: Introduce swiotlb_max_mapping_size()
>   swiotlb: Add is_swiotlb_active() function
>   dma: Introduce dma_max_mapping_size()
>   virtio: Introduce virtio_max_dma_size()
>   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> 
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 10 ++++++++++

The kvm-devel mailing list should have been copied on those.

When you do can you please put 'Reviewed-by: Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com>' on all of them?

Thank you!

P.S.
Christopher, I am assuming you are OK with this idea, if so - and once
the owners of 'virtio' Ack, do you want to put it in my tree?

Thanks!
>  include/linux/dma-mapping.h  | 16 ++++++++++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 11 +++++++++++
>  kernel/dma/swiotlb.c         | 10 ++++++++++
>  7 files changed, 66 insertions(+), 4 deletions(-)


> 
> -- 
> 2.17.1
> 
