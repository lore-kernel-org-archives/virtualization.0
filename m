From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_config: reorder functions
Date: Tue, 31 Mar 2015 17:17:25 +0200
Message-ID: <1427814977-11504-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

This simply reorders functions in virtio_config
so width access wrapper helpers are all together.
Drops an extra empty line while we are at it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index ed1e0d5..1e306f7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -298,13 +298,6 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 		}							\
 	} while(0)
 
-static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
-{
-	u8 ret;
-	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
-}
-
 /* Read @count fields, @bytes each. */
 static inline void __virtio_cread_many(struct virtio_device *vdev,
 				       unsigned int offset,
@@ -326,7 +319,6 @@ static inline void __virtio_cread_many(struct virtio_device *vdev,
 	} while (gen != old);
 }
 
-
 static inline void virtio_cread_bytes(struct virtio_device *vdev,
 				      unsigned int offset,
 				      void *buf, size_t len)
@@ -334,6 +326,13 @@ static inline void virtio_cread_bytes(struct virtio_device *vdev,
 	__virtio_cread_many(vdev, offset, buf, len, 1);
 }
 
+static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
+{
+	u8 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
 static inline void virtio_cwrite8(struct virtio_device *vdev,
 				  unsigned int offset, u8 val)
 {
-- 
MST
