From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 11/15] virtio: set VIRTIO_F_IOMMU_PLATFORM when
	necessary
Date: Fri,  7 Apr 2017 20:24:51 +0100
Message-ID: <20170407192455.26814-12-jean-philippe.brucker__17817.6208785318$1491593245$gmane$org@arm.com>
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

Pass the VIRTIO_F_IOMMU_PLATFORM to tell the guest when a device is behind
an IOMMU.

Other feature bits in virtio do not depend on the device type and could be
factored the same way. For instance our vring implementation always
supports indirect descriptors (VIRTIO_RING_F_INDIRECT_DESC), so we could
advertise it for all devices at once (only net, scsi and blk at the
moment). However, this might modify guest behaviour: in Linux whenever the
driver attempts to add a chain of descriptors, it will allocate an
indirect table and use a single ring descriptor, which might slightly
reduce performance. Cowardly ignore this.

VIRTIO_RING_F_EVENT_IDX is another feature of the vring, but that one
needs the device to call virtio_queue__should_signal before signaling to
the guest. Arguably we could factor all calls to signal_vq, but let's keep
this patch simple.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/virtio.h | 2 ++
 virtio/core.c        | 6 ++++++
 virtio/mmio.c        | 4 +++-
 virtio/pci.c         | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
index cdc960cd..97bd5bdb 100644
--- a/include/kvm/virtio.h
+++ b/include/kvm/virtio.h
@@ -293,4 +293,6 @@ virtio__iommu_get_properties(struct device_header *dev);
 int virtio__iommu_attach(void *, struct virtio_device *vdev, int flags);
 int virtio__iommu_detach(void *, struct virtio_device *vdev);
 
+u32 virtio_get_common_features(struct kvm *kvm, struct virtio_device *vdev);
+
 #endif /* KVM__VIRTIO_H */
diff --git a/virtio/core.c b/virtio/core.c
index ba35e5f1..66e0cecb 100644
--- a/virtio/core.c
+++ b/virtio/core.c
@@ -1,3 +1,4 @@
+#include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/types.h>
 #include <sys/uio.h>
@@ -266,6 +267,11 @@ bool virtio_queue__should_signal(struct virt_queue *vq)
 	return false;
 }
 
+u32 virtio_get_common_features(struct kvm *kvm, struct virtio_device *vdev)
+{
+	return vdev->use_iommu ? VIRTIO_F_IOMMU_PLATFORM : 0;
+}
+
 const struct iommu_properties *
 virtio__iommu_get_properties(struct device_header *dev)
 {
diff --git a/virtio/mmio.c b/virtio/mmio.c
index 24a14a71..699d4403 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -127,9 +127,11 @@ static void virtio_mmio_config_in(struct kvm_cpu *vcpu,
 		ioport__write32(data, *(u32 *)(((void *)&vmmio->hdr) + addr));
 		break;
 	case VIRTIO_MMIO_HOST_FEATURES:
-		if (vmmio->hdr.host_features_sel == 0)
+		if (vmmio->hdr.host_features_sel == 0) {
 			val = vdev->ops->get_host_features(vmmio->kvm,
 							   vmmio->dev);
+			val |= virtio_get_common_features(vmmio->kvm, vdev);
+		}
 		ioport__write32(data, val);
 		break;
 	case VIRTIO_MMIO_QUEUE_PFN:
diff --git a/virtio/pci.c b/virtio/pci.c
index 88b1a129..c9f0e558 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -126,6 +126,7 @@ static bool virtio_pci__io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 p
 	switch (offset) {
 	case VIRTIO_PCI_HOST_FEATURES:
 		val = vdev->ops->get_host_features(kvm, vpci->dev);
+		val |= virtio_get_common_features(kvm, vdev);
 		ioport__write32(data, val);
 		break;
 	case VIRTIO_PCI_QUEUE_PFN:
-- 
2.12.1
