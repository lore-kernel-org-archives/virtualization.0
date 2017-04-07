From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 15/15] virtio: use virtio-iommu when available
Date: Fri,  7 Apr 2017 20:24:55 +0100
Message-ID: <20170407192455.26814-16-jean-philippe.brucker__37521.8972484165$1491593309$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

This is for development only. Virtual devices might blow up unexpectedly.
In general it seems to work (slowing devices down by a factor of two of
course). virtio-scsi, virtio-rng and virtio-balloon are still untested.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 virtio/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virtio/core.c b/virtio/core.c
index 66e0cecb..4ca632f9 100644
--- a/virtio/core.c
+++ b/virtio/core.c
@@ -1,4 +1,5 @@
 #include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
 #include <linux/types.h>
 #include <sys/uio.h>
@@ -369,6 +370,8 @@ int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 {
 	void *virtio;
 
+	vdev->use_iommu = kvm->cfg.viommu && subsys_id != VIRTIO_ID_IOMMU;
+
 	switch (trans) {
 	case VIRTIO_PCI:
 		virtio = calloc(sizeof(struct virtio_pci), 1);
-- 
2.12.1
