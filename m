From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v3 1/5] virtio: add helper virtio_get_status
Date: Sun, 17 Dec 2017 21:45:49 +0800
Message-ID: <2348dc6e8a318f1ba64c2f0cad998ae0c2d48a1c.1513517240.git.zhangweiping@didichuxing.com>
References: <cover.1513517240.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513517240.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

add helper function to simplify dev->config->get_status().

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/virtio/virtio.c       | 6 ++++++
 include/linux/virtio_config.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index bf7ff39..c5b057bd 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -165,6 +165,12 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+unsigned int virtio_get_status(struct virtio_device *dev)
+{
+	return dev->config->get_status(dev);
+}
+EXPORT_SYMBOL_GPL(virtio_get_status);
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 5559a2d..30972c4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -429,6 +429,8 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 	vdev->config->set(vdev, offset, &val, sizeof(val));
 }
 
+unsigned int virtio_get_status(struct virtio_device *dev);
+
 /* Conditional config space accessors. */
 #define virtio_cread_feature(vdev, fbit, structname, member, ptr)	\
 	({								\
-- 
2.9.4
