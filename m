From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 9/9] virtio_scsi: verify if queue is broken after
	virtqueue_get_buf()
Date: Mon,  4 Nov 2013 12:14:57 +0100
Message-ID: <1383563697-37309-2-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1383563697-37309-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1383563697-37309-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

If virtqueue_get_buf() returned with a NULL pointer avoid a possibly
endless loop by checking for a broken virtqueue.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/scsi/virtio_scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 74b88ef..aa25aab 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -224,6 +224,9 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
 		virtqueue_disable_cb(vq);
 		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
 			fn(vscsi, buf);
+
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&virtscsi_vq->vq_lock, flags);
 }
-- 
1.8.3.1
