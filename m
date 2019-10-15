From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/5] virtiofs: No need to check fpq->connected state
Date: Tue, 15 Oct 2019 13:46:23 -0400
Message-ID: <20191015174626.11593-3-vgoyal@redhat.com>
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

In virtiofs we keep per queue connected state in virtio_fs_vq->connected
and use that to end request if queue is not connected. And virtiofs does
not even touch fpq->connected state.

We probably need to merge these two at some point of time. For now, simplify
the code a bit and do not worry about checking state of fpq->connected.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 24ac6f8bf3f7..3b7f7409e77b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -960,13 +960,6 @@ __releases(fiq->lock)
 
 	fpq = &fs->vqs[queue_id].fud->pq;
 	spin_lock(&fpq->lock);
-	if (!fpq->connected) {
-		spin_unlock(&fpq->lock);
-		req->out.h.error = -ENODEV;
-		pr_err("virtio-fs: %s disconnected\n", __func__);
-		fuse_request_end(fc, req);
-		return;
-	}
 	list_add_tail(&req->list, fpq->processing);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
-- 
2.20.1
