From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 0/2] Fix NULL pointer dereference with virtio-blk-pci and
	virtual IOMMU
Date: Mon, 22 Jul 2019 16:55:07 +0200
Message-ID: <20190722145509.1284-1-eric.auger__44951.2254491978$1563807346$gmane$org@redhat.com>
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
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

When running a guest featuring a virtio-blk-pci protected with a virtual
IOMMU we hit a NULL pointer dereference.

This series removes the dma_max_mapping_size() call in
virtio_max_dma_size when the device does not have any dma_mask set.
A check is also added to early return in dma_addressing_limited()
if the dma_mask is NULL.

Eric Auger (2):
  dma-mapping: Protect dma_addressing_limited against NULL dma_mask
  virtio/virtio_ring: Fix the dma_max_mapping_size call

 drivers/virtio/virtio_ring.c | 2 +-
 include/linux/dma-mapping.h  | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1
