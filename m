From: Gonglei <arei.gonglei@huawei.com>
Subject: [PATCH v2 1/2] virtio: introduce little edian functions for
	virtio_cread/write# family
Date: Tue, 22 Nov 2016 16:10:22 +0800
Message-ID: <1479802223-121104-2-git-send-email-arei.gonglei__31760.8485733674$1479802294$gmane$org@huawei.com>
References: <1479802223-121104-1-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479802223-121104-1-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: weidong.huang@huawei.com, claudio.fontana@huawei.com, mst@redhat.com, luonengjun@huawei.com, hanweidong@huawei.com, xuquan8@huawei.com, salvatore.benedetto@intel.com, Gonglei <arei.gonglei@huawei.com>, stefanha@redhat.com, jianjay.zhou@huawei.com, longpeng2@huawei.com, arei.gonglei@hotmail.com, davem@davemloft.net, wu.wubin@huawei.com, herbert@gondor.apana.org.au
List-Id: virtualization@lists.linuxfoundation.org

Virtio modern devices are always little edian, let's introduce
the LE functions for read/write configuration space for
virtio modern devices, which avoid complaint by Sparse when
we use the virtio_creaed/virtio_cwrite in VIRTIO_1 devices.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 include/linux/virtio_config.h | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 26c155b..de05707 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -414,4 +414,49 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
+static inline __le16 virtio_cread16_le(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	__le16 ret;
+
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite16_le(struct virtio_device *vdev,
+				   unsigned int offset, __le16 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline __le32 virtio_cread32_le(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	__le32 ret;
+
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite32_le(struct virtio_device *vdev,
+				   unsigned int offset, __le32 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline __le64 virtio_cread64_le(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	__le64 ret;
+
+	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite64_le(struct virtio_device *vdev,
+				   unsigned int offset, __le64 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.8.3.1
