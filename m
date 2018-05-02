From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH V2 net-next 6/6] ipvlan: Add support for SCTP checksum offload
Date: Tue,  1 May 2018 22:07:39 -0400
Message-ID: <20180502020739.19239-7-vyasevic__48273.3951452703$1525226796$gmane$org@redhat.com>
References: <20180502020739.19239-1-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180502020739.19239-1-vyasevic@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, marcelo.leitner@gmail.com, nhorman@tuxdriver.com, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-sctp@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Since ipvlan is a software device, we can turn on SCTP checksum
offload and let the checksum be computed at the lower layer.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 450eec2..ddb1590 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -161,7 +161,8 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
 	 NETIF_F_GSO | NETIF_F_TSO | NETIF_F_GSO_ROBUST | \
 	 NETIF_F_TSO_ECN | NETIF_F_TSO6 | NETIF_F_GRO | NETIF_F_RXCSUM | \
-	 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)
+	 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER | \
+	 NETIF_F_SCTP_CRC)
 
 #define IPVLAN_STATE_MASK \
 	((1<<__LINK_STATE_NOCARRIER) | (1<<__LINK_STATE_DORMANT))
-- 
2.9.5
