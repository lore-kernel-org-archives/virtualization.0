From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 20/25] virtio_net: enable VQs early on restore
Date: Mon, 13 Oct 2014 10:51:24 +0300
Message-ID: <1413114332-626-21-git-send-email-mst-v4__9731.012924067$1413186584$gmane$org@redhat.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

virtio spec requires drivers to set DRIVER_OK before using VQs.
This is set automatically after restore returns, virtio net violated this
rule by using receive VQs within restore.

To fix, call virtio_device_ready before using VQs.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3551417..6b6e136 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1912,6 +1912,8 @@ static int virtnet_restore(struct virtio_device *vdev)
 	if (err)
 		return err;
 
+	virtio_device_ready(vdev);
+
 	if (netif_running(vi->dev)) {
 		for (i = 0; i < vi->curr_queue_pairs; i++)
 			if (!try_fill_recv(&vi->rq[i], GFP_KERNEL))
-- 
MST
