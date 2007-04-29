From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 31/32] xen: --- drivers/net/xen-netfront.c | 6 +++--- 1 file changed, 3 insertions(+), 3 deletions(-)
Date: Sun, 29 Apr 2007 10:29:06 -0700
Message-ID: <20070429172916.861677000@goop.org>
References: <20070429172835.284784000@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030995AbXD2RhO@vger.kernel.org>
Content-Disposition: inline; filename=xen-netfront-netif_poll-nobh.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

===================================================================
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1213,10 +1213,10 @@ static int netif_poll(struct net_device 
 	int pages_flipped = 0;
 	int err;
 
-	spin_lock_bh(&np->rx_lock);
+	spin_lock(&np->rx_lock);
 
 	if (unlikely(!netfront_carrier_ok(np))) {
-		spin_unlock_bh(&np->rx_lock);
+		spin_unlock(&np->rx_lock);
 		return 0;
 	}
 
@@ -1357,7 +1357,7 @@ err:
 		local_irq_restore(flags);
 	}
 
-	spin_unlock_bh(&np->rx_lock);
+	spin_unlock(&np->rx_lock);
 
 	return more_to_do;
 }

-- 
