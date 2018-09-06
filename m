From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 06/11] tuntap: split out XDP logic
Date: Thu,  6 Sep 2018 12:05:21 +0800
Message-ID: <20180906040526.22518-7-jasowang__6208.84192544526$1536206933$gmane$org@redhat.com>
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

This patch split out XDP logic into a single function. This make it to
be reused by XDP batching path in the following patch.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 84 ++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 389aa0727cc6..21b125020b3b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1635,6 +1635,44 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	return true;
 }
 
+static u32 tun_do_xdp(struct tun_struct *tun,
+		      struct tun_file *tfile,
+		      struct bpf_prog *xdp_prog,
+		      struct xdp_buff *xdp,
+		      int *err)
+{
+	u32 act = bpf_prog_run_xdp(xdp_prog, xdp);
+
+	switch (act) {
+	case XDP_REDIRECT:
+		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
+		xdp_do_flush_map();
+		if (*err)
+			break;
+		goto out;
+	case XDP_TX:
+		*err = tun_xdp_tx(tun->dev, xdp);
+		if (*err < 0)
+			break;
+		*err = 0;
+		goto out;
+	case XDP_PASS:
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		/* fall through */
+	case XDP_ABORTED:
+		trace_xdp_exception(tun->dev, xdp_prog, act);
+		/* fall through */
+	case XDP_DROP:
+		break;
+	}
+
+	put_page(virt_to_head_page(xdp->data_hard_start));
+out:
+	return act;
+}
+
 static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct tun_file *tfile,
 				     struct iov_iter *from,
@@ -1645,10 +1683,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	struct sk_buff *skb = NULL;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	unsigned int delta = 0;
 	char *buf;
 	size_t copied;
-	int err, pad = TUN_RX_PAD;
+	int pad = TUN_RX_PAD;
+	int err = 0;
 
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
@@ -1685,9 +1723,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	local_bh_disable();
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog && !*skb_xdp) {
+	if (xdp_prog) {
 		struct xdp_buff xdp;
-		void *orig_data;
 		u32 act;
 
 		xdp.data_hard_start = buf;
@@ -1695,33 +1732,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + len;
 		xdp.rxq = &tfile->xdp_rxq;
-		orig_data = xdp.data;
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-
-		switch (act) {
-		case XDP_REDIRECT:
-			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
-			xdp_do_flush_map();
-			if (err)
-				goto err_xdp;
-			goto out;
-		case XDP_TX:
-			if (tun_xdp_tx(tun->dev, &xdp) < 0)
-				goto err_xdp;
-			goto out;
-		case XDP_PASS:
-			delta = orig_data - xdp.data;
-			len = xdp.data_end - xdp.data;
-			break;
-		default:
-			bpf_warn_invalid_xdp_action(act);
-			/* fall through */
-		case XDP_ABORTED:
-			trace_xdp_exception(tun->dev, xdp_prog, act);
-			/* fall through */
-		case XDP_DROP:
+		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
+		if (err)
 			goto err_xdp;
-		}
+		if (act != XDP_PASS)
+			goto out;
+
+		pad = xdp.data - xdp.data_hard_start;
+		len = xdp.data_end - xdp.data;
 	}
 	rcu_read_unlock();
 	local_bh_enable();
@@ -1729,18 +1747,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 build:
 	skb = build_skb(buf, buflen);
 	if (!skb) {
+		put_page(alloc_frag->page);
 		skb = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	skb_reserve(skb, pad - delta);
+	skb_reserve(skb, pad);
 	skb_put(skb, len);
 
 	return skb;
 
 err_xdp:
-	alloc_frag->offset -= buflen;
-	put_page(alloc_frag->page);
+	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 out:
 	rcu_read_unlock();
 	local_bh_enable();
-- 
2.17.1
