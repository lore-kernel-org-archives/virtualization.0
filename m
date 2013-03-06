From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/6] virtio_scsi: use virtqueue_add_inbuf() for
	virtscsi_kick_event.
Date: Wed, 06 Mar 2013 16:24:46 +1100
Message-ID: <871ubtayn5.fsf@rustcorp.com.au>
References: <87k3plaz3d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3plaz3d.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It's a bit clearer, and add_buf is going away.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bae0c95..612e320 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -220,8 +220,8 @@ static int virtscsi_kick_event(struct virtio_scsi *vscsi,
 
 	spin_lock_irqsave(&vscsi->event_vq.vq_lock, flags);
 
-	err = virtqueue_add_buf(vscsi->event_vq.vq, &sg, 0, 1, event_node,
-				GFP_ATOMIC);
+	err = virtqueue_add_inbuf(vscsi->event_vq.vq, &sg, 1, event_node,
+				  GFP_ATOMIC);
 	if (!err)
 		virtqueue_kick(vscsi->event_vq.vq);
