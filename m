From: Asias He <asias@redhat.com>
Subject: [PATCH v2 05/11] vhost: Simplify dev->vqs[i] access
Date: Mon,  6 May 2013 16:38:23 +0800
Message-ID: <1367829509-5371-6-git-send-email-asias__32547.7798389786$1367829588$gmane$org@redhat.com>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367829509-5371-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/vhost.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e406d5f..74bc779 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -260,17 +260,16 @@ static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
 /* Helper to allocate iovec buffers for all vqs. */
 static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
 {
+	struct vhost_virtqueue *vq;
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		dev->vqs[i]->indirect = kmalloc(sizeof *dev->vqs[i]->indirect *
-					       UIO_MAXIOV, GFP_KERNEL);
-		dev->vqs[i]->log = kmalloc(sizeof *dev->vqs[i]->log * UIO_MAXIOV,
-					  GFP_KERNEL);
-		dev->vqs[i]->heads = kmalloc(sizeof *dev->vqs[i]->heads *
-					    UIO_MAXIOV, GFP_KERNEL);
-		if (!dev->vqs[i]->indirect || !dev->vqs[i]->log ||
-			!dev->vqs[i]->heads)
+		vq = dev->vqs[i];
+		vq->indirect = kmalloc(sizeof *vq->indirect * UIO_MAXIOV,
+				       GFP_KERNEL);
+		vq->log = kmalloc(sizeof *vq->log * UIO_MAXIOV, GFP_KERNEL);
+		vq->heads = kmalloc(sizeof *vq->heads * UIO_MAXIOV, GFP_KERNEL);
+		if (!vq->indirect || !vq->log || !vq->heads)
 			goto err_nomem;
 	}
 	return 0;
@@ -292,6 +291,7 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
 long vhost_dev_init(struct vhost_dev *dev,
 		    struct vhost_virtqueue **vqs, int nvqs)
 {
+	struct vhost_virtqueue *vq;
 	int i;
 
 	dev->vqs = vqs;
@@ -306,15 +306,16 @@ long vhost_dev_init(struct vhost_dev *dev,
 	dev->worker = NULL;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		dev->vqs[i]->log = NULL;
-		dev->vqs[i]->indirect = NULL;
-		dev->vqs[i]->heads = NULL;
-		dev->vqs[i]->dev = dev;
-		mutex_init(&dev->vqs[i]->mutex);
-		vhost_vq_reset(dev, dev->vqs[i]);
-		if (dev->vqs[i]->handle_kick)
-			vhost_poll_init(&dev->vqs[i]->poll,
-					dev->vqs[i]->handle_kick, POLLIN, dev);
+		vq = dev->vqs[i];
+		vq->log = NULL;
+		vq->indirect = NULL;
+		vq->heads = NULL;
+		vq->dev = dev;
+		mutex_init(&vq->mutex);
+		vhost_vq_reset(dev, vq);
+		if (vq->handle_kick)
+			vhost_poll_init(&vq->poll, vq->handle_kick,
+					POLLIN, dev);
 	}
 
 	return 0;
-- 
1.8.1.4
