From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio, vhost: fixes, features, performance
Date: Tue, 16 Jul 2019 11:31:51 -0400
Message-ID: <20190716113151-mutt-send-email-mst__11114.59155088$1563291140$gmane$org@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aarcange@redhat.com, James.Bottomley@hansenpartnership.com, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, eric.auger@redhat.com, jean-philippe.brucker@arm.com, netdev@vger.kernel.org, gustavo@embeddedor.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, linux-mm@kvack.org, jglisse@redhat.com, mst@redhat.com, ihor.matushchak@foobox.net, bhelgaas@google.com, natechancellor@gmail.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit c1ea02f15ab5efb3e93fc3144d895410bf79fcf2:

  vhost: scsi: add weight support (2019-05-27 11:08:23 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5e663f0410fa2f355042209154029842ba1abd43:

  virtio-mmio: add error check for platform_get_irq (2019-07-11 16:22:29 -0400)

----------------------------------------------------------------
virtio, vhost: fixes, features, performance

new iommu device
vhost guest memory access using vmap (just meta-data for now)
minor fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Note: due to code driver changes the driver-core tree, the following
patch is needed when merging tree with commit 92ce7e83b4e5
("driver_find_device: Unify the match function with
class_find_device()") in the driver-core tree:

From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iommu/virtio: Constify data parameter in viommu_match_node

After commit 92ce7e83b4e5 ("driver_find_device: Unify the match
function with class_find_device()") in the driver-core tree.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 4620dd221ffd..433f4d2ee956 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -839,7 +839,7 @@ static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;

-static int viommu_match_node(struct device *dev, void *data)
+static int viommu_match_node(struct device *dev, const void *data)
 {
 	return dev->parent->fwnode == data;
 }

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      scsi: virtio_scsi: Use struct_size() helper

Ihor Matushchak (1):
      virtio-mmio: add error check for platform_get_irq

Jason Wang (6):
      vhost: generalize adding used elem
      vhost: fine grain userspace memory accessors
      vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
      vhost: introduce helpers to get the size of metadata area
      vhost: factor out setting vring addr and num
      vhost: access vq metadata through kernel virtual address

Jean-Philippe Brucker (7):
      dt-bindings: virtio-mmio: Add IOMMU description
      dt-bindings: virtio: Add virtio-pci-iommu node
      of: Allow the iommu-map property to omit untranslated devices
      PCI: OF: Initialize dev->fwnode appropriately
      iommu: Add virtio-iommu driver
      iommu/virtio: Add probe request
      iommu/virtio: Add event queue

Michael S. Tsirkin (1):
      vhost: fix clang build warning

 Documentation/devicetree/bindings/virtio/iommu.txt |   66 ++
 Documentation/devicetree/bindings/virtio/mmio.txt  |   30 +
 MAINTAINERS                                        |    7 +
 drivers/iommu/Kconfig                              |   11 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/virtio-iommu.c                       | 1158 ++++++++++++++++++++
 drivers/of/base.c                                  |   10 +-
 drivers/pci/of.c                                   |    8 +
 drivers/scsi/virtio_scsi.c                         |    2 +-
 drivers/vhost/net.c                                |    4 +-
 drivers/vhost/vhost.c                              |  850 +++++++++++---
 drivers/vhost/vhost.h                              |   43 +-
 drivers/virtio/virtio_mmio.c                       |    7 +-
 include/uapi/linux/virtio_ids.h                    |    1 +
 include/uapi/linux/virtio_iommu.h                  |  161 +++
 15 files changed, 2228 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h
