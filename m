From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 04/11] tuntap: simplify error handling in
	tun_build_skb()
Date: Wed, 12 Sep 2018 11:17:02 +0800
Message-ID: <20180912031709.14112-5-jasowang__12766.023053746$1536722309$gmane$org@redhat.com>
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

There's no need to duplicate page get logic in each action. So this
patch tries to get page and calculate the offset before processing XDP
actions (except for XDP_DROP), and undo them when meet errors (we
don't care the performance on errors). This will be used for factoring
out XDP logic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 372caf7d67d9..257cf7342d54 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1701,17 +1701,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			xdp_do_flush_map();
 			if (err)
 				goto err_redirect;
-			rcu_read_unlock();
-			local_bh_enable();
-			return NULL;
+			goto out;
 		case XDP_TX:
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
 			if (tun_xdp_tx(tun->dev, &xdp) < 0)
 				goto err_redirect;
-			rcu_read_unlock();
-			local_bh_enable();
-			return NULL;
+			goto out;
 		case XDP_PASS:
 			delta = orig_data - xdp.data;
 			len = xdp.data_end - xdp.data;
@@ -1742,7 +1738,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 err_redirect:
 	put_page(alloc_frag->page);
-err_xdp:
+out:
 	rcu_read_unlock();
 	local_bh_enable();
 	this_cpu_inc(tun->pcpu_stats->rx_dropped);
-- 
2.17.1
