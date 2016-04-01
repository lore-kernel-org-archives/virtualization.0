From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] virtio: silence uninitialized variable warnings
Date: Fri, 1 Apr 2016 14:02:48 +0300
Message-ID: <20160401110248.GA6048@mwanda>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Most ->get() functions seem to call BUG_ON() if offset + len is out of
range, but rproc_virtio_get() returns early without initializing ret.
Presumably it can't actually happen but it leads to a static checker
warning.  Let's just initialize "ret".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6e6cb0c9..597dbef 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -334,7 +334,7 @@ static inline void virtio_cread_bytes(struct virtio_device *vdev,
 
 static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
 {
-	u8 ret;
+	u8 ret = 0;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
 	return ret;
 }
@@ -348,7 +348,7 @@ static inline void virtio_cwrite8(struct virtio_device *vdev,
 static inline u16 virtio_cread16(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u16 ret;
+	u16 ret = 0;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
 	return virtio16_to_cpu(vdev, (__force __virtio16)ret);
 }
@@ -363,7 +363,7 @@ static inline void virtio_cwrite16(struct virtio_device *vdev,
 static inline u32 virtio_cread32(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u32 ret;
+	u32 ret = 0;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
 	return virtio32_to_cpu(vdev, (__force __virtio32)ret);
 }
@@ -378,7 +378,7 @@ static inline void virtio_cwrite32(struct virtio_device *vdev,
 static inline u64 virtio_cread64(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u64 ret;
+	u64 ret = 0;
 	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
 	return virtio64_to_cpu(vdev, (__force __virtio64)ret);
 }
