From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 9/9] virtio_scsi: verify if queue is broken after
	virtqueue_get_buf()
Date: Thu, 24 Oct 2013 17:23:20 +0200
Message-ID: <1382628200-42956-10-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

If virtqueue_get_buf() returned with a NULL pointer avoid a possibly
endless loop by checking for a broken virtqueue.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/scsi/virtio_scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 74b88ef..45bcdb5 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -224,7 +224,8 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
 		virtqueue_disable_cb(vq);
 		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
 			fn(vscsi, buf);
-	} while (!virtqueue_enable_cb(vq));
+	} while (unlikely(!virtqueue_is_broken(vq)) &&
+		 !virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&virtscsi_vq->vq_lock, flags);
 }
 
-- 
1.8.3.1
