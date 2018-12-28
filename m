From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 1/2] virtio_pci: use queue idx instead of array idx to set
	up the vq
Date: Fri, 28 Dec 2018 10:26:25 +0800
Message-ID: <1545963986-11280-2-git-send-email-wei.w.wang__26547.5841858008$1545965979$gmane$org@intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: dgilbert@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

When find_vqs, there will be no vq[i] allocation if its corresponding
names[i] is NULL. For example, the caller may pass in names[i] (i=4)
with names[2] being NULL because the related feature bit is turned off,
so technically there are 3 queues on the device, and name[4] should
correspond to the 3rd queue on the device.

So we use queue_idx as the queue index, which is increased only when the
queue exists.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_pci_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 465a6f5..d0584c0 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -285,7 +285,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors;
+	int i, err, nvectors, allocated_vectors, queue_idx = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -321,7 +321,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
+		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     msix_vec);
 		if (IS_ERR(vqs[i])) {
@@ -356,7 +356,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 		const char * const names[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i, err;
+	int i, err, queue_idx = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -374,7 +374,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
+		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
-- 
2.7.4
