From: Jia He <justin.he@arm.com>
Subject: [PATCH] vhost: add mutex_lock/unlock for vhost_vq_reset
Date: Thu, 30 Apr 2020 10:41:40 +0800
Message-ID: <20200430024140.42065-1-justin.he@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kaly.Xin@arm.com, Jia He <justin.he@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

vq->mutex is to protect any vq accessing, hence adding mutex_lock/unlock
makes sense to avoid potential race condition.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d450e16c5c25..622bfba2e5ab 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -297,6 +297,7 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
 static void vhost_vq_reset(struct vhost_dev *dev,
 			   struct vhost_virtqueue *vq)
 {
+	mutex_lock(&vq->mutex);
 	vq->num = 1;
 	vq->desc = NULL;
 	vq->avail = NULL;
@@ -323,6 +324,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->umem = NULL;
 	vq->iotlb = NULL;
 	__vhost_vq_meta_reset(vq);
+	mutex_unlock(&vq->mutex);
 }
 
 static int vhost_worker(void *data)
-- 
2.17.1
