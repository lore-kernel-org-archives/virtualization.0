From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 08/12] tuntap: tweak on the path of non-xdp case
	in tun_build_skb()
Date: Mon, 21 May 2018 17:04:29 +0800
Message-ID: <1526893473-20128-9-git-send-email-jasowang__31137.8718623475$1526893730$gmane$org@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If we're sure not to go native XDP, there's no need for several things
like touching preemption counter and rcu stuffs.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f6e0f96..ed04291 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1645,10 +1645,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog)
+	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-	else
-		*skb_xdp = 0;
+		goto build;
+	}
+
+	*skb_xdp = 0;
 
 	preempt_disable();
 	rcu_read_lock();
@@ -1695,6 +1697,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	preempt_enable();
 
+build:
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		skb = ERR_PTR(-ENOMEM);
-- 
2.7.4
