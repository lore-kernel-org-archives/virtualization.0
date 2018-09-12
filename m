From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 02/11] tuntap: switch to use XDP_PACKET_HEADROOM
Date: Wed, 12 Sep 2018 11:17:00 +0800
Message-ID: <20180912031709.14112-3-jasowang__27755.6228488267$1536722160$gmane$org@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 2c548bd20393..d3677a544b56 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -113,7 +113,6 @@ do {								\
 } while (0)
 #endif
 
-#define TUN_HEADROOM 256
 #define TUN_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
 /* TUN device flags */
@@ -1654,7 +1653,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog)
-		pad += TUN_HEADROOM;
+		pad += XDP_PACKET_HEADROOM;
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
 
-- 
2.17.1
