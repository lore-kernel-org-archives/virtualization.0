From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 2/2] tuntap: free XDP dropped packets in a batch
Date: Thu, 15 Nov 2018 17:43:10 +0800
Message-ID: <20181115094310.17307-2-jasowang__19675.2144293443$1542274904$gmane$org@redhat.com>
References: <20181115094310.17307-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115094310.17307-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks to the batched XDP buffs through msg_control. Instead of
calling put_page() for each page which involves a atomic operation,
let's batch them by record the last page that needs to be freed and
its refcnt count and free them in a batch.

Testpmd(virtio-user + vhost_net) + XDP_DROP shows 3.8% improvement.

Before: 4.71Mpps
After : 4.89Mpps

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a65779c6d72f..e90a7923a5f6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -188,6 +188,11 @@ struct tun_file {
 	struct xdp_rxq_info xdp_rxq;
 };
 
+struct tun_page {
+	struct page *page;
+	int count;
+};
+
 struct tun_flow_entry {
 	struct hlist_node hash_link;
 	struct rcu_head rcu;
@@ -2377,9 +2382,16 @@ static void tun_sock_write_space(struct sock *sk)
 	kill_fasync(&tfile->fasync, SIGIO, POLL_OUT);
 }
 
+static void tun_put_page(struct tun_page *tpage)
+{
+	if (tpage->page)
+		__page_frag_cache_drain(tpage->page, tpage->count);
+}
+
 static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
-		       struct xdp_buff *xdp, int *flush)
+		       struct xdp_buff *xdp, int *flush,
+		       struct tun_page *tpage)
 {
 	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
 	struct virtio_net_hdr *gso = &hdr->gso;
@@ -2390,6 +2402,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	int buflen = hdr->buflen;
 	int err = 0;
 	bool skb_xdp = false;
+	struct page *page;
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
@@ -2416,7 +2429,14 @@ static int tun_xdp_one(struct tun_struct *tun,
 		case XDP_PASS:
 			break;
 		default:
-			put_page(virt_to_head_page(xdp->data));
+			page = virt_to_head_page(xdp->data);
+			if (tpage->page == page) {
+				++tpage->count;
+			} else {
+				tun_put_page(tpage);
+				tpage->page = page;
+				tpage->count = 1;
+			}
 			return 0;
 		}
 	}
@@ -2480,6 +2500,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		return -EBADFD;
 
 	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+		struct tun_page tpage = {0};
 		int n = ctl->num;
 		int flush = 0;
 
@@ -2488,7 +2509,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
-			tun_xdp_one(tun, tfile, xdp, &flush);
+			tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
 		}
 
 		if (flush)
@@ -2497,6 +2518,8 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		rcu_read_unlock();
 		local_bh_enable();
 
+		tun_put_page(&tpage);
+
 		ret = total_len;
 		goto out;
 	}
-- 
2.17.1
