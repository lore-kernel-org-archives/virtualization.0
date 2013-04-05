From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/7] virtio_config: introduce size-based accessors.
Date: Fri,  5 Apr 2013 14:06:59 +1030
Message-ID: <1365133025-5397-2-git-send-email-rusty@rustcorp.com.au>
References: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This lets the transport do endian conversion if necessary, and insulates
the drivers from that change.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/virtio_config.h |  161 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 134 insertions(+), 27 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 29b9104..e8f8f71 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -96,33 +96,6 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return test_bit(fbit, vdev->features);
 }
 
-/**
- * virtio_config_val - look for a feature and get a virtio config entry.
- * @vdev: the virtio device
- * @fbit: the feature bit
- * @offset: the type to search for.
- * @v: a pointer to the value to fill in.
- *
- * The return value is -ENOENT if the feature doesn't exist.  Otherwise
- * the config value is copied into whatever is pointed to by v. */
-#define virtio_config_val(vdev, fbit, offset, v) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(*v))
-
-#define virtio_config_val_len(vdev, fbit, offset, v, len) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), (len))
-
-static inline int virtio_config_buf(struct virtio_device *vdev,
-				    unsigned int fbit,
-				    unsigned int offset,
-				    void *buf, unsigned len)
-{
-	if (!virtio_has_feature(vdev, fbit))
-		return -ENOENT;
-
-	vdev->config->get(vdev, offset, buf, len);
-	return 0;
-}
-
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
@@ -162,5 +135,139 @@ int virtqueue_set_affinity(struct virtqueue *vq, int cpu)
 	return 0;
 }
 
+/* Config space accessors. */
+#define virtio_cread(vdev, structname, member, ptr)			\
+	do {								\
+		/* Must match the member's type, and be integer */	\
+		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+			(*ptr) = 1;					\
+									\
+		switch (sizeof(*ptr)) {					\
+		case 1:							\
+			*(ptr) = virtio_cread8(vdev,			\
+					       offsetof(structname, member)); \
+			break;						\
+		case 2:							\
+			*(ptr) = virtio_cread16(vdev,			\
+						offsetof(structname, member)); \
+			break;						\
+		case 4:							\
+			*(ptr) = virtio_cread32(vdev,			\
+						offsetof(structname, member)); \
+			break;						\
+		case 8:							\
+			*(ptr) = virtio_cread64(vdev,			\
+						offsetof(structname, member)); \
+			break;						\
+		default:						\
+			BUG();						\
+		}							\
+	} while(0)
+
+/* Config space accessors. */
+#define virtio_cwrite(vdev, structname, member, ptr)			\
+	do {								\
+		/* Must match the member's type, and be integer */	\
+		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+			BUG_ON((*ptr) == 1);				\
+									\
+		switch (sizeof(*ptr)) {					\
+		case 1:							\
+			virtio_cwrite8(vdev,				\
+				       offsetof(structname, member),	\
+				       *(ptr));				\
+			break;						\
+		case 2:							\
+			virtio_cwrite16(vdev,				\
+					offsetof(structname, member),	\
+					*(ptr));			\
+			break;						\
+		case 4:							\
+			virtio_cwrite32(vdev,				\
+					offsetof(structname, member),	\
+					*(ptr));			\
+			break;						\
+		case 8:							\
+			virtio_cwrite64(vdev,				\
+					offsetof(structname, member),	\
+					*(ptr));			\
+			break;						\
+		default:						\
+			BUG();						\
+		}							\
+	} while(0)
+
+static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
+{
+	u8 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cread_bytes(struct virtio_device *vdev,
+				      unsigned int offset,
+				      void *buf, size_t len)
+{
+	vdev->config->get(vdev, offset, buf, len);
+}
+
+static inline void virtio_cwrite8(struct virtio_device *vdev,
+				  unsigned int offset, u8 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline u16 virtio_cread16(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	u16 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite16(struct virtio_device *vdev,
+				   unsigned int offset, u16 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline u32 virtio_cread32(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	u32 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite32(struct virtio_device *vdev,
+				   unsigned int offset, u32 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline u64 virtio_cread64(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	u64 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite64(struct virtio_device *vdev,
+				   unsigned int offset, u64 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+/* Conditional config space accessors. */
+#define virtio_cread_feature(vdev, fbit, structname, member, ptr)	\
+	({								\
+		int _r = 0;						\
+		if (!virtio_has_feature(vdev, fbit))			\
+			_r = -ENOENT;					\
+		else							\
+			virtio_cread((vdev), structname, member, ptr);	\
+		_r;							\
+	})
 
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.7.10.4
