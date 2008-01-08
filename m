From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Always notify a virtio_ring when it's full
Date: Tue,  8 Jan 2008 14:54:10 -0600
Message-ID: <11998256502093-git-send-email-aliguori@us.ibm.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

I saw that the tx timer was removed in your patch queue but you weren't
notifying when full.  I decided to do it here instead of in the error case on
add_buf for really no great reason other than I thought it made more sense
for it to happen in the notify().

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7fa1c72..57b7ad3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -146,7 +146,8 @@ static void vring_kick(struct virtqueue *_vq)
 	/* Need to update avail index before checking if we should notify */
 	mb();
 
-	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
+	/* Always notify when the queue is full */
+	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY) || !vq->num_free)
 		/* Prod other side to tell it about changes. */
 		vq->notify(&vq->vq);
