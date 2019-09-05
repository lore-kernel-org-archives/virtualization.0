From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 02/18] virtiofs: Check whether hiprio queue is connected at
	submission time
Date: Thu,  5 Sep 2019 15:48:43 -0400
Message-ID: <20190905194859.16219-3-vgoyal__34054.7642366559$1567713084$gmane$org@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

For hiprio queue (forget requests), we are keeping a state in queue whether
queue is connected or not. If queue is not connected, do not try to submit
request and return error instead.

As of now, we are checking for this state only in path where worker tries
to submit forget after first attempt failed. Check this state even in
the path when request is being submitted first time.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a708ccb65662..e9497b565dd8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -577,9 +577,16 @@ __releases(fiq->waitq.lock)
 	sg_init_one(&sg, forget, sizeof(*forget));
 
 	/* Enqueue the request */
+	spin_lock(&fsvq->lock);
+
+	if (!fsvq->connected) {
+		kfree(forget);
+		spin_unlock(&fsvq->lock);
+		goto out;
+	}
+
 	vq = fsvq->vq;
 	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
-	spin_lock(&fsvq->lock);
 
 	ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
 	if (ret < 0) {
-- 
2.20.1
