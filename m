From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [PATCH RFC 3/3] xen/virtio_ring: introduce cpu_to_virtio_addr and
	virtio_addr_to_cpu
Date: Mon, 7 Dec 2015 16:19:43 +0000
Message-ID: <1449505183-29740-3-git-send-email-stefano.stabellini__49482.1185865023$1449505567$gmane$org@eu.citrix.com>
References: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When running on Xen inside as virtual machine (nested virt scenario),
addresses need to be translated from phys to machine to get the actual
guest pseudo-physical address.

Introduce a new pair of functions, cpu_to_virtio_addr and
virtio_addr_to_cpu, which call the appriopriate __virtio64_to_cpu and
__cpu_to_virtio64 functions after doing the phys_to_bus and bus_to_phys
translations for Xen.

No changes in behavior for the non-Xen case.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

I realize that this patch is not very nice, but at least it is easy to
understand. I welcome any suggestions on how to improve it.

I considered introducing regular dma API calls, like
dma_map/unmap_single and dma_map/unmap_sg. However they would make the
non-Xen code path more complex than it is today.  We would also need to
keep track of the physical or virtual address in addition to the dma
address for each vring_desc to be able to free the memory in detach_buf.
---
 drivers/virtio/virtio_ring.c  |    9 +++++----
 include/linux/virtio_config.h |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 096b857..34a1d42 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -16,6 +16,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/dma-mapping.h>
 #include <linux/virtio.h>
 #include <linux/virtio_ring.h>
 #include <linux/virtio_config.h>
@@ -172,7 +173,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	if (desc) {
 		/* Use a single buffer which doesn't continue */
 		vq->vring.desc[head].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
-		vq->vring.desc[head].addr = cpu_to_virtio64(_vq->vdev, virt_to_phys(desc));
+		vq->vring.desc[head].addr = cpu_to_virtio_addr(_vq->vdev, virt_to_phys(desc));
 		/* avoid kmemleak false positive (hidden by virt_to_phys) */
 		kmemleak_ignore(desc);
 		vq->vring.desc[head].len = cpu_to_virtio32(_vq->vdev, total_sg * sizeof(struct vring_desc));
@@ -206,7 +207,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
+			desc[i].addr = cpu_to_virtio_addr(_vq->vdev, sg_phys(sg));
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
@@ -215,7 +216,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
+			desc[i].addr = cpu_to_virtio_addr(_vq->vdev, sg_phys(sg));
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
@@ -433,7 +434,7 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 
 	/* Free the indirect table */
 	if (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT))
-		kfree(phys_to_virt(virtio64_to_cpu(vq->vq.vdev, vq->vring.desc[i].addr)));
+		kfree(phys_to_virt(virtio_addr_to_cpu(vq->vq.vdev, vq->vring.desc[i].addr)));
 
 	while (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT)) {
 		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e5ce8ab..861803f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -6,6 +6,8 @@
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
 #include <uapi/linux/virtio_config.h>
+#include <xen/xen.h>
+#include <xen/swiotlb-xen.h>
 
 /**
  * virtio_config_ops - operations for configuring a virtio device
@@ -237,11 +239,23 @@ static inline u64 virtio64_to_cpu(struct virtio_device *vdev, __virtio64 val)
 	return __virtio64_to_cpu(virtio_is_little_endian(vdev), val);
 }
 
+static inline u64 virtio_addr_to_cpu(struct virtio_device *vdev, __virtio64 val)
+{
+	val = xen_pv_domain() ? xen_bus_to_phys(val) : val;
+	return __virtio64_to_cpu(virtio_is_little_endian(vdev), val);
+}
+
 static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 {
 	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
 }
 
+static inline __virtio64 cpu_to_virtio_addr(struct virtio_device *vdev, u64 val)
+{
+	val = xen_pv_domain() ? xen_phys_to_bus(val) : val;
+	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
+}
+
 /* Config space accessors. */
 #define virtio_cread(vdev, structname, member, ptr)			\
 	do {								\
-- 
1.7.10.4
