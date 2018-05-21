From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 06/12] tuntap: enable premmption early
Date: Mon, 21 May 2018 17:04:27 +0800
Message-ID: <1526893473-20128-7-git-send-email-jasowang__6711.62037547237$1526893643$gmane$org@redhat.com>
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
 drivers/net/tun.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 44d4f3d..24ecd82 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1697,6 +1697,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			goto err_xdp;
 		}
 	}
+	rcu_read_unlock();
+	preempt_enable();
 
 	skb = build_skb(buf, buflen);
 	if (!skb) {
@@ -1710,9 +1712,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	get_page(alloc_frag->page);
 	alloc_frag->offset += buflen;
 
-	rcu_read_unlock();
-	preempt_enable();
-
 	return skb;
 
 err_redirect:
-- 
2.7.4
