From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 07/12] tuntap: simplify error handling in
	tun_build_skb()
Date: Mon, 21 May 2018 17:04:28 +0800
Message-ID: <1526893473-20128-8-git-send-email-jasowang__13447.0902536579$1526893689$gmane$org@redhat.com>
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

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 24ecd82..f6e0f96 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1612,7 +1612,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	unsigned int delta = 0;
@@ -1638,6 +1638,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	if (copied != len)
 		return ERR_PTR(-EFAULT);
 
+	get_page(alloc_frag->page);
+	alloc_frag->offset += buflen;
+
 	/* There's a small window that XDP may be set after the check
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
@@ -1665,24 +1668,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 		switch (act) {
 		case XDP_REDIRECT:
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
 			xdp_do_flush_map();
 			if (err)
-				goto err_redirect;
-			rcu_read_unlock();
-			preempt_enable();
-			return NULL;
+				goto err_xdp;
+			goto out;
 		case XDP_TX:
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
 			if (tun_xdp_tx(tun->dev, &xdp))
-				goto err_redirect;
+				goto err_xdp;
 			tun_xdp_flush(tun->dev);
-			rcu_read_unlock();
-			preempt_enable();
-			return NULL;
+			goto out;
 		case XDP_PASS:
 			delta = orig_data - xdp.data;
 			len = xdp.data_end - xdp.data;
@@ -1702,25 +1697,22 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 	skb = build_skb(buf, buflen);
 	if (!skb) {
-		rcu_read_unlock();
-		preempt_enable();
-		return ERR_PTR(-ENOMEM);
+		skb = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
 	skb_reserve(skb, pad - delta);
 	skb_put(skb, len);
-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
 
 	return skb;
 
-err_redirect:
-	put_page(alloc_frag->page);
 err_xdp:
+	alloc_frag->offset -= buflen;
+	put_page(alloc_frag->page);
+out:
 	rcu_read_unlock();
 	preempt_enable();
-	this_cpu_inc(tun->pcpu_stats->rx_dropped);
-	return NULL;
+	return skb;
 }
 
 /* Get packet from user space buffer */
-- 
2.7.4
