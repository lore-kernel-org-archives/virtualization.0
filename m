From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6/6] virtio: core support for config generation
Date: Mon, 15 Dec 2014 23:23:22 +0200
Message-ID: <1418678575-31755-7-git-send-email-mst__1176.73365534774$1418678654$gmane$org@redhat.com>
References: <1418678575-31755-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418678575-31755-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio 1.0 spec says:

Drivers MUST NOT assume reads from fields greater than 32 bits wide are
atomic, nor are reads from multiple fields: drivers SHOULD read device
configuration space fields like so:
	u32 before, after;
	do {
		before = get_config_generation(device);
		// read config entry/entries.
		after = get_config_generation(device);
	} while (after != before);

Do exactly this, for transports that support it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index a61cd37..ca3ed78 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -19,6 +19,9 @@
  *	offset: the offset of the configuration field
  *	buf: the buffer to read the field value from.
  *	len: the length of the buffer
+ * @generation: config generation counter
+ *	vdev: the virtio_device
+ *	Returns the config generation counter
  * @get_status: read the status byte
  *	vdev: the virtio_device
  *	Returns the status byte
@@ -60,6 +63,7 @@ struct virtio_config_ops {
 		    void *buf, unsigned len);
 	void (*set)(struct virtio_device *vdev, unsigned offset,
 		    const void *buf, unsigned len);
+	u32 (*generation)(struct virtio_device *vdev);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
@@ -301,14 +305,33 @@ static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
 	return ret;
 }
 
+/* Read @count fields, @bytes each. */
+static inline void __virtio_cread_many(struct virtio_device *vdev,
+				       unsigned int offset,
+				       void *buf, size_t count, size_t bytes)
+{
+	u32 old, gen = vdev->config->generation ?
+		vdev->config->generation(vdev) : 0;
+	int i;
+
+	do {
+		old = gen;
+
+		for (i = 0; i < count; i++)
+			vdev->config->get(vdev, offset + bytes * i,
+					  buf + i * bytes, bytes);
+
+		gen = vdev->config->generation ?
+			vdev->config->generation(vdev) : 0;
+	} while (gen != old);
+}
+
+
 static inline void virtio_cread_bytes(struct virtio_device *vdev,
 				      unsigned int offset,
 				      void *buf, size_t len)
 {
-	int i;
-
-	for (i = 0; i < len; i++)
-		vdev->config->get(vdev, offset + i, buf + i, 1);
+	__virtio_cread_many(vdev, offset, buf, len, 1);
 }
 
 static inline void virtio_cwrite8(struct virtio_device *vdev,
@@ -352,6 +375,7 @@ static inline u64 virtio_cread64(struct virtio_device *vdev,
 {
 	u64 ret;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
 	return virtio64_to_cpu(vdev, (__force __virtio64)ret);
 }
 
-- 
MST
