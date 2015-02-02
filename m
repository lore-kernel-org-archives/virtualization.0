From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH net v3 2/3] Revert "drivers/net,
	ipv6: Select IPv6 fragment idents for virtio UFO packets"
Date: Mon,  2 Feb 2015 10:01:08 -0500
Message-ID: <1422889269-16007-3-git-send-email-vyasevic__23803.0740096749$1422889313$gmane$org@redhat.com>
References: <1422889269-16007-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1422889269-16007-1-git-send-email-vyasevic@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: eric.dumazet@gmail.com, mst@redhat.com, virtualization@lists.linux-foundation.org, hannes@stressinduktion.org, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit 5188cd44c55db3e92cd9e77a40b5baa7ed4340f7.

Now that GSO layer can track if fragment id has been selected
and can allocate one if necessary, we don't need to do this in
tap and macvtap.  This reverts most of the code and only keeps
the new ipv6 fragment id generation function that is still needed.

Fixes: 3d0ad09412ff (drivers/net: Disable UFO through virtio)
Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 drivers/net/macvtap.c | 3 ---
 drivers/net/tun.c     | 6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 7df2217..0b86e46 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include <linux/uio.h>
 
-#include <net/ipv6.h>
 #include <net/net_namespace.h>
 #include <net/rtnetlink.h>
 #include <net/sock.h>
@@ -589,8 +588,6 @@ static int macvtap_skb_from_vnet_hdr(struct macvtap_queue *q,
 			pr_warn_once("macvtap: %s: using disabled UFO feature; please fix this program\n",
 				     current->comm);
 			gso_type = SKB_GSO_UDP;
-			if (skb->protocol == htons(ETH_P_IPV6))
-				ipv6_proxy_select_ident(skb);
 			break;
 		default:
 			return -EINVAL;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8c8dc16..5ca42b7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -65,7 +65,6 @@
 #include <linux/nsproxy.h>
 #include <linux/virtio_net.h>
 #include <linux/rcupdate.h>
-#include <net/ipv6.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/rtnetlink.h>
@@ -1167,8 +1166,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	skb_reset_network_header(skb);
-
 	if (gso.gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		pr_debug("GSO!\n");
 		switch (gso.gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -1189,8 +1186,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 					    current->comm);
 			}
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP;
-			if (skb->protocol == htons(ETH_P_IPV6))
-				ipv6_proxy_select_ident(skb);
 			break;
 		}
 		default:
@@ -1221,6 +1216,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb_shinfo(skb)->tx_flags |= SKBTX_SHARED_FRAG;
 	}
 
+	skb_reset_network_header(skb);
 	skb_probe_transport_header(skb, 0);
 
 	rxhash = skb_get_hash(skb);
-- 
1.9.3
