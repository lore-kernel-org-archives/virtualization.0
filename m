From: Marek Marczykowski <marmarek@invisiblethingslab.com>
Subject: [PATCH] xen: do not disable netfront in dom0
Date: Sun, 20 May 2012 13:45:10 +0200
Message-ID: <20120522130558.D828E6C7__18119.2663069398$1337708077$gmane$org@duch.mimuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xen.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, netdev@vger.kernel.org, Marek Marczykowski <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Netfront driver can be also useful in dom0, eg when all NICs are assigned to
some domU (aka driver domain). Then using netback in domU and netfront in dom0
is the only way to get network access in dom0.

Signed-off-by: Marek Marczykowski <marmarek@invisiblethingslab.com>
---
 drivers/net/xen-netfront.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 698b905..e31ebff 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1953,9 +1953,6 @@ static int __init netif_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
-	if (xen_initial_domain())
-		return 0;
-
 	printk(KERN_INFO "Initialising Xen virtual ethernet driver.\n");
 
 	return xenbus_register_frontend(&netfront_driver);
@@ -1965,9 +1962,6 @@ module_init(netif_init);
 
 static void __exit netif_exit(void)
 {
-	if (xen_initial_domain())
-		return;
-
 	xenbus_unregister_driver(&netfront_driver);
 }
 module_exit(netif_exit);
-- 
1.7.4.4
