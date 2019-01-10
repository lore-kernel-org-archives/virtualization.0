From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Thu, 10 Jan 2019 14:44:30 +0100
Message-ID: <20190110134433.15672-1-joro__36627.4831154898$1547127761$gmane$org@8bytes.org>
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
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Joerg Roedel <joro@8bytes.org>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Hi,

there is a problem with virtio-blk driven devices when
virtio-ring uses SWIOTLB through the DMA-API. This happens
for example in AMD-SEV enabled guests, where the guest RAM
is mostly encrypted and all emulated DMA has to happen
to/from the SWIOTLB aperture.

The problem is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb. When
the virtio-blk driver tries to read/write a block larger
than that, the allocation of the dma-handle fails and an IO
error is reported.

This patch-set adds a check to the virtio-code whether it
might be using SWIOTLB bounce buffering and limits the
maximum segment size in the virtio-blk driver in this case,
so that it doesn't try to do larger reads/writes.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  swiotlb: Export maximum allocation size
  virtio: Introduce virtio_max_dma_size()
  virtio-blk: Consider virtio_max_dma_size() for maximum segment size

 drivers/block/virtio_blk.c   | 10 ++++++----
 drivers/virtio/virtio_ring.c | 11 +++++++++++
 include/linux/swiotlb.h      | 12 ++++++++++++
 include/linux/virtio.h       |  2 ++
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.17.1
