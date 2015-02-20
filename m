From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH 1/3] vhost: add VHOST_VRING_F_LEGACY_BIG_ENDIAN flag
Date: Fri, 20 Feb 2015 11:07:39 +0100
Message-ID: <20150220100731.18608.2797.stgit@bahia.local>
References: <20150220100724.18608.74654.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150220100724.18608.74654.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The VHOST_VRING_F_LEGACY_BIG_ENDIAN flag informs the kernel that the
associated device is big endian. Of course, this only makes sense for
legacy virtio devices since modern virtio devices are always little
endian.

It will be used by the vhost memory accessors to byteswap vring data when
we have a legacy device, in case host and guest endianness differ.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 drivers/vhost/vhost.c      |    6 +++++-
 drivers/vhost/vhost.h      |    3 +++
 include/uapi/linux/vhost.h |    2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2ee2826..dad3c37 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -199,6 +199,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->call = NULL;
 	vq->log_ctx = NULL;
 	vq->memory = NULL;
+	vq->legacy_big_endian = false;
 }
 
 static int vhost_worker(void *data)
@@ -701,7 +702,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
 			r = -EFAULT;
 			break;
 		}
-		if (a.flags & ~(0x1 << VHOST_VRING_F_LOG)) {
+		if (a.flags & ~(0x1 << VHOST_VRING_F_LOG|
+				0x1 << VHOST_VRING_F_LEGACY_BIG_ENDIAN)) {
 			r = -EOPNOTSUPP;
 			break;
 		}
@@ -751,6 +753,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
 		vq->avail = (void __user *)(unsigned long)a.avail_user_addr;
 		vq->log_addr = a.log_guest_addr;
 		vq->used = (void __user *)(unsigned long)a.used_user_addr;
+		vq->legacy_big_endian =
+			!!(a.flags & (0x1 << VHOST_VRING_F_LEGACY_BIG_ENDIAN));
 		break;
 	case VHOST_SET_VRING_KICK:
 		if (copy_from_user(&f, argp, sizeof f)) {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 8c1c792..ce2c68e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -106,6 +106,9 @@ struct vhost_virtqueue {
 	/* Log write descriptors */
 	void __user *log_base;
 	struct vhost_log *log;
+
+	/* We need to know the device endianness with legacy virtio. */
+	bool legacy_big_endian;
 };
 
 struct vhost_dev {
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index bb6a5b4..0bf4491 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -34,6 +34,8 @@ struct vhost_vring_addr {
 	/* Flag values: */
 	/* Whether log address is valid. If set enables logging. */
 #define VHOST_VRING_F_LOG 0
+	/* Whether we have a big-endian legacy virtio device. */
+#define VHOST_VRING_F_LEGACY_BIG_ENDIAN 1
 
 	/* Start of array of descriptors (virtually contiguous) */
 	__u64 desc_user_addr;
