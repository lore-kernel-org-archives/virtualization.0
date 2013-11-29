From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: [PATCH] virtio_net: Fixed a trivial typo (fitler --> filter)
Date: Fri, 29 Nov 2013 10:02:19 +0100
Message-ID: <1385715739-12299-1-git-send-email-thuth__48521.99184611$1385715863$gmane$org@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, trivial@kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

"MAC filter" sounds more reasonable than "MAC fitler".

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 drivers/net/virtio_net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 01f4eb5..fd96f09 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1075,7 +1075,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET,
 				  sg, NULL))
-		dev_warn(&dev->dev, "Failed to set MAC fitler table.\n");
+		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
 	kfree(buf);
 }
-- 
1.7.1
