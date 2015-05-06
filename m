From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH RFC 2/7] linux-headers: sync vhost.h
Date: Wed, 06 May 2015 14:07:44 +0200
Message-ID: <20150506120744.8607.37718.stgit@bahia.huguette.org>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120729.8607.23404.stgit@bahia.huguette.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch brings the cross-endian vhost API to QEMU.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 linux-headers/linux/vhost.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index c656f61..ead86db 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -103,6 +103,20 @@ struct vhost_memory {
 /* Get accessor: reads index, writes value in num */
 #define VHOST_GET_VRING_BASE _IOWR(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
 
+/* Set the vring byte order in num. Valid values are VHOST_VRING_LITTLE_ENDIAN
+ * or VHOST_VRING_BIG_ENDIAN (other values return -EINVAL).
+ * The byte order cannot be changed while the device is active: trying to do so
+ * returns -EBUSY.
+ * This is a legacy only API that is simply ignored when VIRTIO_F_VERSION_1 is
+ * set.
+ * Not all kernel configurations support this ioctl, but all configurations that
+ * support SET also support GET.
+ */
+#define VHOST_VRING_LITTLE_ENDIAN 0
+#define VHOST_VRING_BIG_ENDIAN 1
+#define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
+#define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
