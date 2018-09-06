From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 05/11] tuntap: tweak on the path of non-xdp case in
	tun_build_skb()
Date: Thu,  6 Sep 2018 12:05:20 +0800
Message-ID: <20180906040526.22518-6-jasowang__46403.632258489$1536206871$gmane$org@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180906040526.22518-1-jasowang@redhat.com>
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

If we're sure not to go native XDP, there's no need for several things
like bh and rcu stuffs.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8cdcfa392c3..389aa0727cc6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1675,10 +1675,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
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
 
 	local_bh_disable();
 	rcu_read_lock();
@@ -1724,6 +1726,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	local_bh_enable();
 
+build:
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		skb = ERR_PTR(-ENOMEM);
-- 
2.17.1
