From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH 04/10] loopback: Turn on UFO6 support.
Date: Wed, 17 Dec 2014 13:20:49 -0500
Message-ID: <1418840455-22598-5-git-send-email-vyasevic__47992.0994992883$1418840519$gmane$org@redhat.com>
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

Turn on UFO6 support.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 drivers/net/loopback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index c76283c..762c28a 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -170,10 +170,10 @@ static void loopback_setup(struct net_device *dev)
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
 	netif_keep_dst(dev);
-	dev->hw_features	= NETIF_F_ALL_TSO | NETIF_F_UFO;
+	dev->hw_features	= NETIF_F_ALL_TSO | NETIF_F_ALL_UFO;
 	dev->features 		= NETIF_F_SG | NETIF_F_FRAGLIST
 		| NETIF_F_ALL_TSO
-		| NETIF_F_UFO
+		| NETIF_F_ALL_UFO
 		| NETIF_F_HW_CSUM
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CSUM
-- 
1.9.3
