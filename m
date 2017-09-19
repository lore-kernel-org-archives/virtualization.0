From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 2/3] virtio-net: add packet len average only when
	needed during XDP
Date: Tue, 19 Sep 2017 17:42:42 +0800
Message-ID: <1505814163-7315-2-git-send-email-jasowang__30748.8381200985$1505814208$gmane$org@redhat.com>
References: <1505814163-7315-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1505814163-7315-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

There's no need to add packet len average in the case of XDP_PASS
since it will be done soon after skb is created.

Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a0ef4b0..db5924c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -656,6 +656,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		xdp.data_end = xdp.data + (len - vi->hdr_len);
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
+		if (act != XDP_PASS)
+			ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
+
 		switch (act) {
 		case XDP_PASS:
 			/* recalculate offset to account for any header
@@ -671,14 +674,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				put_page(page);
 				head_skb = page_to_skb(vi, rq, xdp_page,
 						       offset, len, PAGE_SIZE);
-				ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
 				return head_skb;
 			}
 			break;
 		case XDP_TX:
 			if (unlikely(!virtnet_xdp_xmit(vi, &xdp)))
 				trace_xdp_exception(vi->dev, xdp_prog, act);
-			ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
 			if (unlikely(xdp_page != page))
 				goto err_xdp;
 			rcu_read_unlock();
@@ -690,7 +691,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		case XDP_DROP:
 			if (unlikely(xdp_page != page))
 				__free_pages(xdp_page, 0);
-			ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
 			goto err_xdp;
 		}
 	}
-- 
2.7.4
