From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH 05/10] veth: Enable UFO6 support.
Date: Wed, 17 Dec 2014 13:20:50 -0500
Message-ID: <1418840455-22598-6-git-send-email-vyasevic__18911.8641581901$1418840544$gmane$org@redhat.com>
References: <1418840455-22598-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418840455-22598-1-git-send-email-vyasevic@redhat.com>
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
Cc: mst@redhat.com, ben@decadent.org.uk, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Turn on UFO6 feature.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 8ad5965..0052db5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -280,7 +280,7 @@ static const struct net_device_ops veth_netdev_ops = {
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_ALL_TSO |    \
 		       NETIF_F_HW_CSUM | NETIF_F_RXCSUM | NETIF_F_HIGHDMA | \
 		       NETIF_F_GSO_GRE | NETIF_F_GSO_UDP_TUNNEL |	    \
-		       NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT | NETIF_F_UFO	|   \
+		       NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT | NETIF_F_ALL_UFO | \
 		       NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX | \
 		       NETIF_F_HW_VLAN_STAG_TX | NETIF_F_HW_VLAN_STAG_RX )
 
-- 
1.9.3
