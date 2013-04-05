From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/7] virtio_config: helpers for non-converting accessors.
Date: Fri,  5 Apr 2013 14:07:01 +1030
Message-ID: <1365133025-5397-4-git-send-email-rusty@rustcorp.com.au>
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

Simply redirect everything via the byte-at-a-time accessor.  Slow, but simple
and this is config reading, which mostly only happens at probe time.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio.c       |   69 +++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_config.h |   19 ++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ee59b74..2b154f3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -219,6 +219,75 @@ out:
 }
 EXPORT_SYMBOL_GPL(register_virtio_device);
 
+static void noconv_get(struct virtio_device *vdev, unsigned offset,
+		       size_t len, void *p)
+{
+	u8 *buf = p;
+	while (len) {
+		*buf = vdev->config->get8(vdev, offset);
+		buf++;
+		offset++;
+		len--;
+	}
+}
+
+u16 virtio_config_get_noconv16(struct virtio_device *vdev, unsigned offset)
+{
+	u16 v;
+	noconv_get(vdev, offset, sizeof(v), &v);
+	return v;
+}
+EXPORT_SYMBOL_GPL(virtio_config_get_noconv16);
+
+u32 virtio_config_get_noconv32(struct virtio_device *vdev, unsigned offset)
+{
+	u32 v;
+	noconv_get(vdev, offset, sizeof(v), &v);
+	return v;
+}
+EXPORT_SYMBOL_GPL(virtio_config_get_noconv32);
+
+u64 virtio_config_get_noconv64(struct virtio_device *vdev, unsigned offset)
+{
+	u64 v;
+	noconv_get(vdev, offset, sizeof(v), &v);
+	return v;
+}
+EXPORT_SYMBOL_GPL(virtio_config_get_noconv64);
+
+static void noconv_set(struct virtio_device *vdev, unsigned offset,
+		       size_t len, const void *p)
+{
+	const u8 *buf = p;
+	while (len) {
+		vdev->config->set8(vdev, offset, *buf);
+		buf++;
+		offset++;
+		len--;
+	}
+}
+
+void virtio_config_set_noconv16(struct virtio_device *vdev,
+				unsigned offset, u16 v)
+{
+	noconv_set(vdev, offset, sizeof(v), &v);
+}
+EXPORT_SYMBOL_GPL(virtio_config_set_noconv16);
+
+void virtio_config_set_noconv32(struct virtio_device *vdev,
+				unsigned offset, u32 v)
+{
+	noconv_set(vdev, offset, sizeof(v), &v);
+}
+EXPORT_SYMBOL_GPL(virtio_config_set_noconv32);
+
+void virtio_config_set_noconv64(struct virtio_device *vdev,
+				unsigned offset, u64 v)
+{
+	noconv_set(vdev, offset, sizeof(v), &v);
+}
+EXPORT_SYMBOL_GPL(virtio_config_set_noconv64);
+
 void unregister_virtio_device(struct virtio_device *dev)
 {
 	int index = dev->index; /* save for after device release */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e8f8f71..12a777f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -270,4 +270,23 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
+/* Helpers for non-endian converting transports. */
+u16 virtio_config_get_noconv16(struct virtio_device *vdev, unsigned offset);
+u32 virtio_config_get_noconv32(struct virtio_device *vdev, unsigned offset);
+u64 virtio_config_get_noconv64(struct virtio_device *vdev, unsigned offset);
+void virtio_config_set_noconv16(struct virtio_device *vdev,
+				unsigned offset, u16 v);
+void virtio_config_set_noconv32(struct virtio_device *vdev,
+				unsigned offset, u32 v);
+void virtio_config_set_noconv64(struct virtio_device *vdev,
+				unsigned offset, u64 v);
+
+#define VIRTIO_CONFIG_OPS_NOCONV		\
+	.get16 = virtio_config_get_noconv16,	\
+	.set16 = virtio_config_set_noconv16,	\
+	.get32 = virtio_config_get_noconv32,	\
+	.set32 = virtio_config_set_noconv32,	\
+	.get64 = virtio_config_get_noconv64,	\
+	.set64 = virtio_config_set_noconv64
+
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.7.10.4
