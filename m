From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/6] virtio: add virtqueue_ vq_ops wrappers
Date: Mon, 12 Apr 2010 16:18:25 +0300
Message-ID: <2232ad0aeff2a3ca62ed8dfa114e5be5436c95d9.1271078235.git.mst@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add inline functions that wrap vq->vq_ops-> calls

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 40d1709..18ccc68 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -77,6 +77,40 @@ struct virtqueue_ops {
 	void *(*detach_unused_buf)(struct virtqueue *vq);
 };
 
+static inline int virtqueue_add_buf(struct virtqueue *vq,
+				    struct scatterlist sg[],
+				    unsigned int out_num,
+				    unsigned int in_num,
+				    void *data)
+{
+	return vq->vq_ops->add_buf(vq, sg, out_num, in_num, data);
+}
+
+static inline int void virtqueue_kick(struct virtqueue *vq)
+{
+	return vq->vq_ops->kick(vq);
+}
+
+static inline void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len)
+{
+	return vq->vq_ops->get_buf(vq, len);
+}
+
+static inline void virtqueue_disable_cb(struct virtqueue *vq)
+{
+	vq->vq_ops->disable_cb(vq);
+}
+
+static inline bool virtqueue_enable_cb(struct virtqueue *vq)
+{
+	return vq->vq_ops->enable_cb(vq);
+}
+
+static inline void *virtqueue_detach_unused_buf(struct virtqueue *vq)
+{
+	return vq->vq_ops->detach_unused_buf(vq);
+}
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
1.7.0.2.280.gc6f05
