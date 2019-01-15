From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3 v2] Fix virtio-blk issue with SWIOTLB
Date: Tue, 15 Jan 2019 14:22:54 +0100
Message-ID: <20190115132257.6426-1-joro__12369.0099841498$1547692310$gmane$org@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, jroedel@suse.de, brijesh.singh@amd.com, joro@8bytes.org, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

here is the second version of my patch-set to fix a DMA
mapping size issue triggered by the virtio-blk driver.

The problem is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb.  When
the virtio-blk driver tries to read/write a block larger
than that, the allocation of the dma-handle fails and an IO
error is reported.

v1 of the patch-set can be found here:

https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/

The change to v1 is that the maximum mapping size is now
officially propagated through the DMA-API, as suggested by
Christoph Hellwig.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  swiotlb: Introduce swiotlb_max_mapping_size()
  dma: Introduce dma_max_mapping_size()
  virtio-blk: Consider dma_max_mapping_size() for maximum segment size

 drivers/block/virtio_blk.c  | 10 ++++++----
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 include/linux/swiotlb.h     |  5 +++++
 kernel/dma/direct.c         | 10 ++++++++++
 kernel/dma/swiotlb.c        |  5 +++++
 5 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1
