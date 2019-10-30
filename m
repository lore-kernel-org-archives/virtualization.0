From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 1/3] virtiofs: Use a common function to send forget
Date: Wed, 30 Oct 2019 11:07:17 -0400
Message-ID: <20191030150719.29048-2-vgoyal__28663.9947373018$1572448099$gmane$org@redhat.com>
References: <20191030150719.29048-1-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191030150719.29048-1-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Cc: dgilbert@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently we are duplicating logic to send forgets at two places. Consolidate
the code by calling one helper function.

This also uses virtqueue_add_outbuf() instead of virtqueue_add_sgs(). Former
is simpler to call.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 150 +++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 87 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a5c86048b96e..6cc7be170cb8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -313,17 +313,71 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 	}
 }
 
+/*
+ * Returns 1 if queue is full and sender should wait a bit before sending
+ * next request, 0 otherwise.
+ */
+static int send_forget_request(struct virtio_fs_vq *fsvq,
+			       struct virtio_fs_forget *forget,
+			       bool in_flight)
+{
+	struct scatterlist sg;
+	struct virtqueue *vq;
+	int ret = 0;
+	bool notify;
+
+	spin_lock(&fsvq->lock);
+	if (!fsvq->connected) {
+		if (in_flight)
+			dec_in_flight_req(fsvq);
+		kfree(forget);
+		goto out;
+	}
+
+	sg_init_one(&sg, forget, sizeof(*forget));
+	vq = fsvq->vq;
+	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+
+	ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
+	if (ret < 0) {
+		if (ret == -ENOMEM || ret == -ENOSPC) {
+			pr_debug("virtio-fs: Could not queue FORGET: err=%d."
+				 " Will try later\n", ret);
+			list_add_tail(&forget->list, &fsvq->queued_reqs);
+			schedule_delayed_work(&fsvq->dispatch_work,
+					      msecs_to_jiffies(1));
+			if (!in_flight)
+				inc_in_flight_req(fsvq);
+			/* Queue is full */
+			ret = 1;
+		} else {
+			pr_debug("virtio-fs: Could not queue FORGET: err=%d."
+				 " Dropping it.\n", ret);
+			kfree(forget);
+			if (in_flight)
+				dec_in_flight_req(fsvq);
+		}
+		goto out;
+	}
+
+	if (!in_flight)
+		inc_in_flight_req(fsvq);
+	notify = virtqueue_kick_prepare(vq);
+	spin_unlock(&fsvq->lock);
+
+	if (notify)
+		virtqueue_notify(vq);
+	return ret;
+out:
+	spin_unlock(&fsvq->lock);
+	return ret;
+}
+
 static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 {
 	struct virtio_fs_forget *forget;
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 dispatch_work.work);
-	struct virtqueue *vq = fsvq->vq;
-	struct scatterlist sg;
-	struct scatterlist *sgs[] = {&sg};
-	bool notify;
-	int ret;
-
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
 	while (1) {
 		spin_lock(&fsvq->lock);
@@ -335,43 +389,9 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 		}
 
 		list_del(&forget->list);
-		if (!fsvq->connected) {
-			dec_in_flight_req(fsvq);
-			spin_unlock(&fsvq->lock);
-			kfree(forget);
-			continue;
-		}
-
-		sg_init_one(&sg, forget, sizeof(*forget));
-
-		/* Enqueue the request */
-		dev_dbg(&vq->vdev->dev, "%s\n", __func__);
-		ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
-		if (ret < 0) {
-			if (ret == -ENOMEM || ret == -ENOSPC) {
-				pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
-					 ret);
-				list_add_tail(&forget->list,
-						&fsvq->queued_reqs);
-				schedule_delayed_work(&fsvq->dispatch_work,
-						msecs_to_jiffies(1));
-			} else {
-				pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
-					 ret);
-				dec_in_flight_req(fsvq);
-				kfree(forget);
-			}
-			spin_unlock(&fsvq->lock);
-			return;
-		}
-
-		notify = virtqueue_kick_prepare(vq);
 		spin_unlock(&fsvq->lock);
-
-		if (notify)
-			virtqueue_notify(vq);
-		pr_debug("virtio-fs: worker %s dispatched one forget request.\n",
-			 __func__);
+		if (send_forget_request(fsvq, forget, true))
+			return;
 	}
 }
 
@@ -710,14 +730,9 @@ __releases(fiq->lock)
 {
 	struct fuse_forget_link *link;
 	struct virtio_fs_forget *forget;
-	struct scatterlist sg;
-	struct scatterlist *sgs[] = {&sg};
 	struct virtio_fs *fs;
-	struct virtqueue *vq;
 	struct virtio_fs_vq *fsvq;
-	bool notify;
 	u64 unique;
-	int ret;
 
 	link = fuse_dequeue_forget(fiq, 1, NULL);
 	unique = fuse_get_unique(fiq);
@@ -739,46 +754,7 @@ __releases(fiq->lock)
 		.nlookup = link->forget_one.nlookup,
 	};
 
-	sg_init_one(&sg, forget, sizeof(*forget));
-
-	/* Enqueue the request */
-	spin_lock(&fsvq->lock);
-
-	if (!fsvq->connected) {
-		kfree(forget);
-		spin_unlock(&fsvq->lock);
-		goto out;
-	}
-
-	vq = fsvq->vq;
-	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
-
-	ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
-	if (ret < 0) {
-		if (ret == -ENOMEM || ret == -ENOSPC) {
-			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later.\n",
-				 ret);
-			list_add_tail(&forget->list, &fsvq->queued_reqs);
-			schedule_delayed_work(&fsvq->dispatch_work,
-					msecs_to_jiffies(1));
-			inc_in_flight_req(fsvq);
-		} else {
-			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
-				 ret);
-			kfree(forget);
-		}
-		spin_unlock(&fsvq->lock);
-		goto out;
-	}
-
-	inc_in_flight_req(fsvq);
-	notify = virtqueue_kick_prepare(vq);
-
-	spin_unlock(&fsvq->lock);
-
-	if (notify)
-		virtqueue_notify(vq);
-out:
+	send_forget_request(fsvq, forget, false);
 	kfree(link);
 }
 
-- 
2.20.1
