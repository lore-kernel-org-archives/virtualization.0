From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 21/25] virito_scsi: use freezable WQ for events
Date: Mon, 13 Oct 2014 10:51:29 +0300
Message-ID: <1413114332-626-22-git-send-email-mst-v4__44084.5905141488$1413186602$gmane$org@redhat.com>
References: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, netdev@vger.kernel.org, "James E.J. Bottomley" <JBottomley@parallels.com>, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

From: Paolo Bonzini <pbonzini@redhat.com>

Michael S. Tsirkin noticed a race condition:
we reset device on freeze, but system WQ is still
running so it might try adding bufs to a VQ meanwhile.

To fix, switch to handling events from the freezable WQ.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 2b565b3..501838d 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -390,7 +390,7 @@ static void virtscsi_complete_event(struct virtio_scsi *vscsi, void *buf)
 {
 	struct virtio_scsi_event_node *event_node = buf;
 
-	schedule_work(&event_node->work);
+	queue_work(system_freezable_wq, &event_node->work);
 }
 
 static void virtscsi_event_done(struct virtqueue *vq)
-- 
MST
