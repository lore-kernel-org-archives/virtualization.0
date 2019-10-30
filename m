From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/3] virtiofs: Do not send forget request "struct list_head"
	element
Date: Wed, 30 Oct 2019 11:07:18 -0400
Message-ID: <20191030150719.29048-3-vgoyal__13860.7577116758$1572448095$gmane$org@redhat.com>
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

We are sending whole of virtio_fs_foreget struct to the other end over
virtqueue. Other end does not need to see elements like "struct list".
That's internal detail of guest kernel. Fix it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6cc7be170cb8..43224db8d9ed 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -48,11 +48,15 @@ struct virtio_fs {
 	unsigned int num_request_queues; /* number of request queues */
 };
 
-struct virtio_fs_forget {
+struct virtio_fs_forget_req {
 	struct fuse_in_header ih;
 	struct fuse_forget_in arg;
+};
+
+struct virtio_fs_forget {
 	/* This request can be temporarily queued on virt queue */
 	struct list_head list;
+	struct virtio_fs_forget_req req;
 };
 
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
@@ -325,6 +329,7 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 	struct virtqueue *vq;
 	int ret = 0;
 	bool notify;
+	struct virtio_fs_forget_req *req = &forget->req;
 
 	spin_lock(&fsvq->lock);
 	if (!fsvq->connected) {
@@ -334,7 +339,7 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
-	sg_init_one(&sg, forget, sizeof(*forget));
+	sg_init_one(&sg, req, sizeof(*req));
 	vq = fsvq->vq;
 	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
 
@@ -730,6 +735,7 @@ __releases(fiq->lock)
 {
 	struct fuse_forget_link *link;
 	struct virtio_fs_forget *forget;
+	struct virtio_fs_forget_req *req;
 	struct virtio_fs *fs;
 	struct virtio_fs_vq *fsvq;
 	u64 unique;
@@ -743,14 +749,15 @@ __releases(fiq->lock)
 
 	/* Allocate a buffer for the request */
 	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
+	req = &forget->req;
 
-	forget->ih = (struct fuse_in_header){
+	req->ih = (struct fuse_in_header){
 		.opcode = FUSE_FORGET,
 		.nodeid = link->forget_one.nodeid,
 		.unique = unique,
-		.len = sizeof(*forget),
+		.len = sizeof(*req),
 	};
-	forget->arg = (struct fuse_forget_in){
+	req->arg = (struct fuse_forget_in){
 		.nlookup = link->forget_one.nlookup,
 	};
 
-- 
2.20.1
