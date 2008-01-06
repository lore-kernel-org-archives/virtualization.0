From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH][RESEND] Relax BUG_ON()s when enabling/disabling virt_ring
	interrupts
Date: Sat,  5 Jan 2008 20:43:51 -0600
Message-ID: <11995874312740-git-send-email-aliguori@us.ibm.com>
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

Currently, the virt_ring->enable_cb and virt_ring->disable_cb functions enforce
that they were called only when callbacks were disabled and enabled
respectively.  However, in the current vring implementation, this isn't
actually a bug.  What's more, the virtio_net driver does not guard against
double enabling or double disabling.  All that needs to happen is for an rx
notification to happen twice beforce the virtnet_poll function is invoked to
trigger the BUG_ON.

This patch removes the BUG_ON()s since there are no negative side effects in
the current vring code.  In the future, if a ring implementation cannot support
double enabling or double disabling, it is far easier for them to handle this
by maintaining an enabled flag than forcing every virtio driver to maintain
this sort of state.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 15ee2fa..9599236 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -227,7 +227,6 @@ static void vring_disable_cb(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	START_USE(vq);
-	BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
 	vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 	END_USE(vq);
 }
@@ -237,7 +236,6 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	START_USE(vq);
-	BUG_ON(!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT));
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
