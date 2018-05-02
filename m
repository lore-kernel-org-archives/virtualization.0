From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH V2 net-next 4/6] tun: Add support for SCTP checksum offload
Date: Tue,  1 May 2018 22:07:37 -0400
Message-ID: <20180502020739.19239-5-vyasevic__4721.50453501872$1525226781$gmane$org@redhat.com>
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

Adds a new tun offload flag to allow for SCTP checksum offload.
The flag has to be set by the user and defaults to "no offload".
Add SCTP checksum support to the supported tun features.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 drivers/net/tun.c           | 7 ++++++-
 include/uapi/linux/if_tun.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a1ba262..4f314a6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -216,7 +216,7 @@ struct tun_struct {
 	struct net_device	*dev;
 	netdev_features_t	set_features;
 #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
-			  NETIF_F_TSO6)
+			  NETIF_F_TSO6|NETIF_F_SCTP_CRC)
 
 	int			align;
 	int			vnet_hdr_sz;
@@ -2719,6 +2719,11 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 		arg &= ~TUN_F_UFO;
 	}
 
+	if (arg & TUN_F_SCTP_CSUM) {
+		features |= NETIF_F_SCTP_CRC;
+		arg &= ~TUN_F_SCTP_CSUM;
+	}
+
 	/* This gives the user a way to test for new features in future by
 	 * trying to set them. */
 	if (arg)
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index ee432cd..061aea8 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -86,6 +86,7 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_SCTP_CSUM 0x20	/* I can handle SCTP checksums offloads */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.9.5
