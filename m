From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 05/11] virtio_config: endian conversion for v1.0.
Date: Tue,  7 Oct 2014 16:39:46 +0200
Message-ID: <1412692792-12325-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/virtio_config.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index a0e16d8..ca22e3a 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -222,12 +222,13 @@ static inline u16 virtio_cread16(struct virtio_device *vdev,
 {
 	u16 ret;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return virtio_to_cpu_u16(vdev, ret);
 }
 
 static inline void virtio_cwrite16(struct virtio_device *vdev,
 				   unsigned int offset, u16 val)
 {
+	val = cpu_to_virtio_u16(vdev, val);
 	vdev->config->set(vdev, offset, &val, sizeof(val));
 }
 
@@ -236,12 +237,13 @@ static inline u32 virtio_cread32(struct virtio_device *vdev,
 {
 	u32 ret;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return virtio_to_cpu_u32(vdev, ret);
 }
 
 static inline void virtio_cwrite32(struct virtio_device *vdev,
 				   unsigned int offset, u32 val)
 {
+	val = cpu_to_virtio_u32(vdev, val);
 	vdev->config->set(vdev, offset, &val, sizeof(val));
 }
 
@@ -250,12 +252,13 @@ static inline u64 virtio_cread64(struct virtio_device *vdev,
 {
 	u64 ret;
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return virtio_to_cpu_u64(vdev, ret);
 }
 
 static inline void virtio_cwrite64(struct virtio_device *vdev,
 				   unsigned int offset, u64 val)
 {
+	val = cpu_to_virtio_u64(vdev, val);
 	vdev->config->set(vdev, offset, &val, sizeof(val));
 }
 
-- 
1.7.9.5
