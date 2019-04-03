From: Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH] virtio-net: Remove inclusion of pci.h
Date: Wed,  3 Apr 2019 11:20:45 +0300
Message-ID: <20190403082045.16089-1-yuval.shaia__22977.9043862194$1555717697$gmane$org@oracle.com>
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
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

This header is not in use - remove it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7eb38ea9ba56..07c1e81087b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,7 +31,6 @@
 #include <linux/average.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
-- 
2.19.1
