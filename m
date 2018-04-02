From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH net-next 2/5] sctp: Handle sctp packets with CHECKSUM_PARTIAL
Date: Mon,  2 Apr 2018 09:40:03 -0400
Message-ID: <20180402134006.10111-3-vyasevic__4770.93237354911$1522676339$gmane$org@redhat.com>
References: <20180402134006.10111-1-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180402134006.10111-1-vyasevic@redhat.com>
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
Cc: nhorman@tuxdriver.com, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-sctp@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

With SCTP checksum offload available in virtio, it is now
possible for virtio to receive a sctp packet with CHECKSUM_PARTIAL
set (guest-to-guest traffic).  SCTP doesn't really have a
partial checksum like TCP does because CRC32c can't do partial
additive checksumming.  It's all or nothing.  So an SCTP packet
with CHECKSUM_PARTIAL will have checksum set to 0.  Let SCTP
treat this as a valid checksum if CHECKSUM_PARTIAL is set.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 net/sctp/input.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index ba8a6e6..055b8ffa 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -80,8 +80,17 @@ static inline int sctp_rcv_checksum(struct net *net, struct sk_buff *skb)
 {
 	struct sctphdr *sh = sctp_hdr(skb);
 	__le32 cmp = sh->checksum;
-	__le32 val = sctp_compute_cksum(skb, 0);
+	__le32 val = 0;
 
+	/* In sctp PARTIAL checksum is always 0.  This is a case of
+	 * a packet received from guest that supports checksum offload.
+	 * Assume it's correct as there is really no way to verify,
+	 * and we want to avaoid computing it unnecesarily.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		return 0;
+
+	val = sctp_compute_cksum(skb, 0);
 	if (val != cmp) {
 		/* CRC failure, dump it. */
 		__SCTP_INC_STATS(net, SCTP_MIB_CHECKSUMERRORS);
-- 
2.9.5
