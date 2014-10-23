From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v4 06/17] virtio: make endian-ness depend on virtio 1.0
Date: Thu, 23 Oct 2014 19:24:28 +0300
Message-ID: <1414081380-14623-7-git-send-email-mst@redhat.com>
References: <1414081380-14623-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1414081380-14623-1-git-send-email-mst@redhat.com>
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

virtio 1.0 is LE, virtio without 1.0 is native endian.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4bc2ebe..952b6d7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -157,11 +157,11 @@ int virtqueue_set_affinity(struct virtqueue *vq, int cpu)
 #define DEFINE_VIRTIO_XX_TO_CPU(bits) \
 static inline u##bits virtio##bits##_to_cpu(struct virtio_device *vdev, __virtio##bits val) \
 { \
-	return __virtio##bits##_to_cpu(false, val); \
+	return __virtio##bits##_to_cpu(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val); \
 } \
 static inline __virtio##bits cpu_to_virtio##bits(struct virtio_device *vdev, u##bits val) \
 { \
-	return __cpu_to_virtio##bits(false, val); \
+	return __cpu_to_virtio##bits(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val); \
 }
 
 static inline u16 virtio16_to_cpu(struct virtio_device *vdev, __virtio16 val)
-- 
MST
