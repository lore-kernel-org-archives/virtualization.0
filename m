From: Shyam Saini <mayhs11saini@gmail.com>
Subject: [PATCH] net: Use kmemdup instead of kmalloc and memcpy
Date: Sat, 24 Dec 2016 00:44:58 +0530
Message-ID: <1482520498-28259-1-git-send-email-mayhs11saini__6679.73044696755$1483728387$gmane$org@gmail.com>
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
To: mst@redhat.com
Cc: netdev@vger.kernel.org, Shyam Saini <mayhs11saini@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

when some other buffer is immediately copied into allocated region.
Replace calls to kmalloc followed by a memcpy with a direct
call to kmemdup.

Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
---
 drivers/net/virtio_net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba1aa24..dde4bc4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1206,10 +1206,9 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 	struct sockaddr *addr;
 	struct scatterlist sg;
 
-	addr = kmalloc(sizeof(*addr), GFP_KERNEL);
+	addr = kmemdup(p, sizeof(*addr), GFP_KERNEL);
 	if (!addr)
 		return -ENOMEM;
-	memcpy(addr, p, sizeof(*addr));
 
 	ret = eth_prepare_mac_addr_change(dev, addr);
 	if (ret)
-- 
2.7.4
