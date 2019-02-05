From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Date: Tue, 5 Feb 2019 15:52:38 -0500
Message-ID: <20190205155133-mutt-send-email-mst__49061.803105154$1549446391$gmane$org@kernel.org>
References: <20190131163403.11363-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190131163403.11363-1-joro@8bytes.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Thomas.Lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 31, 2019 at 05:33:58PM +0100, Joerg Roedel wrote:
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
> 	V5: https://lore.kernel.org/lkml/20190130164007.26497-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v5 are:
> 
> 	- Changed patch 3 to uninline dma_max_mapping_size()

And this lead to problems reported by kbuild :(

BTW when you repost, can I ask you to pls include
the version in all patches? Both --subject-prefix
and -v flags to git format-patch will do this for you.


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
>  Documentation/DMA-API.txt    |  8 ++++++++
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 11 +++++++++++
>  include/linux/dma-mapping.h  |  8 ++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 11 +++++++++++
>  kernel/dma/mapping.c         | 14 ++++++++++++++
>  kernel/dma/swiotlb.c         | 14 ++++++++++++++
>  9 files changed, 85 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
