From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Fix used_idx wrap-around in virtio
Date: Wed,  7 Nov 2007 15:49:24 -0600
Message-ID: <11944721642196-git-send-email-aliguori__15601.1283085265$1194472245$gmane$org@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The more_used() function compares the vq->vring.used->idx with last_used_idx.
Since vq->vring.used->idx is a 16-bit integer, and last_used_idx is an
unsigned int, this results in unpredictable behavior when vq->vring.used->idx
wraps around.

This patch corrects this by changing last_used_idx to the correct type.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0e4baca..0e1bf05 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -53,7 +53,7 @@ struct vring_virtqueue
 	unsigned int num_added;
 
 	/* Last used index we've seen. */
-	unsigned int last_used_idx;
+	u16 last_used_idx;
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
 	void (*notify)(struct virtqueue *vq);
