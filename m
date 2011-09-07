From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] virtio_blk: unlock vblk->lock during kick
Date: Wed,  7 Sep 2011 14:51:41 +0100
Message-ID: <1315403501-12457-3-git-send-email-stefanha@linux.vnet.ibm.com>
References: <1315403501-12457-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1315403501-12457-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Khoa Huynh <khoa@us.ibm.com>, Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Holding the vblk->lock across kick causes poor scalability in SMP
guests.  If one CPU is doing virtqueue kick and another CPU touches the
vblk->lock it will have to spin until virtqueue kick completes.

This typically results in high system CPU utilization in SMP guests that
are running multithreaded I/O-bound workloads.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 079c088..c2bf0a9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -193,8 +193,14 @@ static void do_virtblk_request(struct request_queue *q)
 		issued++;
 	}
 
-	if (issued)
-		virtqueue_kick(vblk->vq);
+	if (!issued)
+		return;
+
+	if (virtqueue_kick_prepare(vblk->vq)) {
+		spin_unlock(&vblk->lock);
+		virtqueue_kick_notify(vblk->vq);
+		spin_lock(&vblk->lock);
+	}
 }
 
 /* return id (s/n) string for *disk to *id_str
-- 
1.7.5.4
