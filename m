From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next] virtio-net: correctly set xdp_xmit for mergeable
	buffer
Date: Fri, 22 Sep 2017 14:38:58 +0800
Message-ID: <1506062338-3617-1-git-send-email-jasowang__43330.5417340764$1506062351$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

We should set xdp_xmit only when xdp_do_redirect() succeed.

Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f6c1f13..dd14a45 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -721,7 +721,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			err = xdp_do_redirect(dev, &xdp, xdp_prog);
-			if (err)
+			if (!err)
 				*xdp_xmit = true;
 			rcu_read_unlock();
 			goto xdp_xmit;
-- 
2.7.4
