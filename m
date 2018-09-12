From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 03/11] tuntap: enable bh early during processing
	XDP
Date: Wed, 12 Sep 2018 11:17:01 +0800
Message-ID: <20180912031709.14112-4-jasowang__16540.5287444175$1536722257$gmane$org@redhat.com>
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

This patch move the bh enabling a little bit earlier, this will be
used for factoring out the core XDP logic of tuntap.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d3677a544b56..372caf7d67d9 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1726,22 +1726,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			goto err_xdp;
 		}
 	}
+	rcu_read_unlock();
+	local_bh_enable();
 
 	skb = build_skb(buf, buflen);
-	if (!skb) {
-		rcu_read_unlock();
-		local_bh_enable();
+	if (!skb)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	skb_reserve(skb, pad - delta);
 	skb_put(skb, len);
 	get_page(alloc_frag->page);
 	alloc_frag->offset += buflen;
 
-	rcu_read_unlock();
-	local_bh_enable();
-
 	return skb;
 
 err_redirect:
-- 
2.17.1
