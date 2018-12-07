From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC 1/3] virtio_ring: define flags as shifts consistently
Date: Fri,  7 Dec 2018 16:48:40 +0800
Message-ID: <20181207084842.13133-2-tiwei.bie__20682.3050314144$1544172552$gmane$org@intel.com>
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

Introduce _SPLIT_ and/or _PACKED_ variants for VRING_DESC_F_*,
VRING_AVAIL_F_NO_INTERRUPT and VRING_USED_F_NO_NOTIFY. These
variants are defined as shifts instead of shifted values for
consistency with other _F_ flags.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/uapi/linux/virtio_ring.h | 57 ++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 2414f8af26b3..9b0c0d92ab62 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -37,29 +37,52 @@
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 
-/* This marks a buffer as continuing via the next field. */
+/*
+ * Notice: unlike other _F_ flags, below flags are defined as shifted
+ * values instead of shifts for compatibility.
+ */
+/* Same as VRING_SPLIT_DESC_F_NEXT. */
 #define VRING_DESC_F_NEXT	1
-/* This marks a buffer as write-only (otherwise read-only). */
+/* Same as VRING_SPLIT_DESC_F_WRITE. */
 #define VRING_DESC_F_WRITE	2
-/* This means the buffer contains a list of buffer descriptors. */
+/* Same as VRING_SPLIT_DESC_F_INDIRECT. */
 #define VRING_DESC_F_INDIRECT	4
-
-/*
- * Mark a descriptor as available or used in packed ring.
- * Notice: they are defined as shifts instead of shifted values.
- */
-#define VRING_PACKED_DESC_F_AVAIL	7
-#define VRING_PACKED_DESC_F_USED	15
-
-/* The Host uses this in used->flags to advise the Guest: don't kick me when
- * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
- * will still kick if it's out of buffers. */
+/* Same as VRING_SPLIT_USED_F_NO_NOTIFY. */
 #define VRING_USED_F_NO_NOTIFY	1
-/* The Guest uses this in avail->flags to advise the Host: don't interrupt me
- * when you consume a buffer.  It's unreliable, so it's simply an
- * optimization.  */
+/* Same as VRING_SPLIT_AVAIL_F_NO_INTERRUPT. */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
 
+/* Mark a buffer as continuing via the next field in split ring. */
+#define VRING_SPLIT_DESC_F_NEXT		0
+/* Mark a buffer as write-only (otherwise read-only) in split ring. */
+#define VRING_SPLIT_DESC_F_WRITE	1
+/* Mean the buffer contains a list of buffer descriptors in split ring. */
+#define VRING_SPLIT_DESC_F_INDIRECT	2
+
+/*
+ * The Host uses this in used->flags in split ring to advise the Guest:
+ * don't kick me when you add a buffer.  It's unreliable, so it's simply
+ * an optimization.  Guest will still kick if it's out of buffers.
+ */
+#define VRING_SPLIT_USED_F_NO_NOTIFY		0
+/*
+ * The Guest uses this in avail->flags in split ring to advise the Host:
+ * don't interrupt me when you consume a buffer.  It's unreliable, so it's
+ * simply an optimization.
+ */
+#define VRING_SPLIT_AVAIL_F_NO_INTERRUPT	0
+
+/* Mark a buffer as continuing via the next field in packed ring. */
+#define VRING_PACKED_DESC_F_NEXT	0
+/* Mark a buffer as write-only (otherwise read-only) in packed ring. */
+#define VRING_PACKED_DESC_F_WRITE	1
+/* Mean the buffer contains a list of buffer descriptors in packed ring. */
+#define VRING_PACKED_DESC_F_INDIRECT	2
+
+/* Mark a descriptor as available or used in packed ring. */
+#define VRING_PACKED_DESC_F_AVAIL	7
+#define VRING_PACKED_DESC_F_USED	15
+
 /* Enable events in packed ring. */
 #define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
 /* Disable events in packed ring. */
-- 
2.17.1
