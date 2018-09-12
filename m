From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 05/11] tuntap: tweak on the path of skb XDP case
	in tun_build_skb()
Date: Wed, 12 Sep 2018 11:17:03 +0800
Message-ID: <20180912031709.14112-6-jasowang__32170.2600610026$1536722366$gmane$org@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
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
like bh and rcu stuffs. So this patch introduces a helper to build skb
and hold page refcnt. When we found we will go through skb path, build
skb directly.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 257cf7342d54..946c6148ed75 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1635,6 +1635,23 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	return true;
 }
 
+static struct sk_buff *__tun_build_skb(struct page_frag *alloc_frag, char *buf,
+				       int buflen, int len, int pad, int delta)
+{
+	struct sk_buff *skb = build_skb(buf, buflen);
+
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_reserve(skb, pad - delta);
+	skb_put(skb, len);
+
+	get_page(alloc_frag->page);
+	alloc_frag->offset += buflen;
+
+	return skb;
+}
+
 static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct tun_file *tfile,
 				     struct iov_iter *from,
@@ -1642,7 +1659,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
-	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	unsigned int delta = 0;
@@ -1672,10 +1688,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog)
+	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-	else
-		*skb_xdp = 0;
+		return __tun_build_skb(alloc_frag, buf, buflen, len, pad, delta);
+	}
+
+	*skb_xdp = 0;
 
 	local_bh_disable();
 	rcu_read_lock();
@@ -1719,22 +1737,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			trace_xdp_exception(tun->dev, xdp_prog, act);
 			/* fall through */
 		case XDP_DROP:
-			goto err_xdp;
+			goto out;
 		}
 	}
 	rcu_read_unlock();
 	local_bh_enable();
 
-	skb = build_skb(buf, buflen);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	skb_reserve(skb, pad - delta);
-	skb_put(skb, len);
-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
-
-	return skb;
+	return __tun_build_skb(alloc_frag, buf, buflen, len, pad, delta);
 
 err_redirect:
 	put_page(alloc_frag->page);
-- 
2.17.1
