From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC 2/3] virtio_ring: add VIRTIO_RING_NO_LEGACY
Date: Fri,  7 Dec 2018 16:48:41 +0800
Message-ID: <20181207084842.13133-3-tiwei.bie__15255.0075705678$1544172566$gmane$org@intel.com>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181207084842.13133-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Introduce VIRTIO_RING_NO_LEGACY to support disabling legacy
macros and layout definitions.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
VRING_AVAIL_ALIGN_SIZE, VRING_USED_ALIGN_SIZE and VRING_DESC_ALIGN_SIZE
are not pre-virtio 1.0, but can also be disabled by VIRTIO_RING_NO_LEGACY
in this patch, because their names are not consistent with other names.
Not sure whether this is a good idea. If we want this, we may also want
to define _SPLIT_ version for them.

 include/uapi/linux/virtio_ring.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9b0c0d92ab62..192573827850 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -37,6 +37,7 @@
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 
+#ifndef VIRTIO_RING_NO_LEGACY
 /*
  * Notice: unlike other _F_ flags, below flags are defined as shifted
  * values instead of shifts for compatibility.
@@ -51,6 +52,7 @@
 #define VRING_USED_F_NO_NOTIFY	1
 /* Same as VRING_SPLIT_AVAIL_F_NO_INTERRUPT. */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
+#endif /* VIRTIO_RING_NO_LEGACY */
 
 /* Mark a buffer as continuing via the next field in split ring. */
 #define VRING_SPLIT_DESC_F_NEXT		0
@@ -151,6 +153,7 @@ struct vring {
 	struct vring_used *used;
 };
 
+#ifndef VIRTIO_RING_NO_LEGACY
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -203,6 +206,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
+#endif /* VIRTIO_RING_NO_LEGACY */
 
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
 /* Assuming a given event_idx value from the other side, if
-- 
2.17.1
