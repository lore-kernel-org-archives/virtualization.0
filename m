From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] virtio: Use __skb_queue_purge()
Date: Mon, 26 May 2008 17:53:23 +1000
Message-ID: <200805261753.23860.rusty__42333.615004509$1211788550$gmane$org@rustcorp.com.au>
References: <200805261742.43215.rusty@rustcorp.com.au>
	<200805261748.13449.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805261748.13449.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, Wang Chen <wangchen@cn.fujitsu.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wang Chen <wangchen@cn.fujitsu.com>

Use standard routine for queue purging.

Signed-off-by: Wang Chen <wangchen@cn.fujitsu.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f926b5a..fe7cdf2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -470,8 +470,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 		kfree_skb(skb);
 		vi->num--;
 	}
-	while ((skb = __skb_dequeue(&vi->send)) != NULL)
-		kfree_skb(skb);
+	__skb_queue_purge(&vi->send);
 
 	BUG_ON(vi->num != 0);
