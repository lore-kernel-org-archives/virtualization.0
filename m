From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 10/10] drivers/net/xen-netfront.c: Use DIV_ROUND_UP
Date: Sat, 2 Aug 2008 17:16:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808021715500.20095@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: jeremy@xensource.com, chrisw@sous-sol.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.orgkerne
List-Id: virtualization@lists.linuxfoundation.org

From: Julia Lawall <julia@diku.dk>

The kernel.h macro DIV_ROUND_UP performs the computation (((n) + (d) - 1) /
(d)) but is perhaps more readable.

An extract of the semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@haskernel@
@@

#include <linux/kernel.h>

@depends on haskernel@
expression n,d;
@@

(
- (n + d - 1) / d
+ DIV_ROUND_UP(n,d)
|
- (n + (d - 1)) / d
+ DIV_ROUND_UP(n,d)
)

@depends on haskernel@
expression n,d;
@@

- DIV_ROUND_UP((n),d)
+ DIV_ROUND_UP(n,d)

@depends on haskernel@
expression n,d;
@@

- DIV_ROUND_UP(n,(d))
+ DIV_ROUND_UP(n,d)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/net/xen-netfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -471,7 +471,7 @@ static int xennet_start_xmit(struct sk_b
 	unsigned int offset = offset_in_page(data);
 	unsigned int len = skb_headlen(skb);
 
-	frags += (offset + len + PAGE_SIZE - 1) / PAGE_SIZE;
+	frags += DIV_ROUND_UP(offset + len, PAGE_SIZE);
 	if (unlikely(frags > MAX_SKB_FRAGS + 1)) {
 		printk(KERN_ALERT "xennet: skb rides the rocket: %d frags\n",
 		       frags);
