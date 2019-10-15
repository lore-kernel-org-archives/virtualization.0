From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 3/5] virtiofs: Set FR_SENT flag only after request has been
	sent
Date: Tue, 15 Oct 2019 13:46:24 -0400
Message-ID: <20191015174626.11593-4-vgoyal@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191015174626.11593-1-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc: miklos@szeredi.hu, chirantan@chromium.org, dgilbert@redhat.com, virtualization@lists.linux-foundation.org, stefanha@redhat.com, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

FR_SENT flag should be set when request has been sent successfuly sent
over virtqueue. This is used by interrupt logic to figure out if interrupt
request should be sent or not.

Also add it to fqp->processing list after sending it successfully.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 3b7f7409e77b..e0fcf3030951 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -857,6 +857,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int i;
 	int ret;
 	bool notify;
+	struct fuse_pqueue *fpq;
 
 	/* Does the sglist fit on the stack? */
 	total_sgs = sg_count_fuse_req(req);
@@ -911,6 +912,15 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
+	/* Request successfuly sent. */
+	fpq = &fsvq->fud->pq;
+	spin_lock(&fpq->lock);
+	list_add_tail(&req->list, fpq->processing);
+	spin_unlock(&fpq->lock);
+	set_bit(FR_SENT, &req->flags);
+	/* matches barrier in request_wait_answer() */
+	smp_mb__after_atomic();
+
 	fsvq->in_flight++;
 	notify = virtqueue_kick_prepare(vq);
 
@@ -939,7 +949,6 @@ __releases(fiq->lock)
 	struct virtio_fs *fs;
 	struct fuse_conn *fc;
 	struct fuse_req *req;
-	struct fuse_pqueue *fpq;
 	struct virtio_fs_vq *fsvq;
 	int ret;
 
@@ -958,14 +967,6 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-	fpq = &fs->vqs[queue_id].fud->pq;
-	spin_lock(&fpq->lock);
-	list_add_tail(&req->list, fpq->processing);
-	spin_unlock(&fpq->lock);
-	set_bit(FR_SENT, &req->flags);
-	/* matches barrier in request_wait_answer() */
-	smp_mb__after_atomic();
-
 retry:
 	fsvq = &fs->vqs[queue_id];
 	ret = virtio_fs_enqueue_req(fsvq, req);
@@ -978,10 +979,6 @@ __releases(fiq->lock)
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
-		spin_lock(&fpq->lock);
-		clear_bit(FR_SENT, &req->flags);
-		list_del_init(&req->list);
-		spin_unlock(&fpq->lock);
 
 		/* Can't end request in submission context. Use a worker */
 		spin_lock(&fsvq->lock);
-- 
2.20.1
