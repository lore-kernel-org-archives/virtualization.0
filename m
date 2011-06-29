From: Bastian Blank <waldi@debian.org>
Subject: [PATCH 3/4] xen/blkback: Add module alias for autoloading
Date: Wed, 29 Jun 2011 14:40:50 +0200
Message-ID: <20110629124050.GC31038__5154.76544756002$1309356590$gmane$org@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add xen-backend:vbd module alias to the xen-blkback module. This allows
automatic loading of the module.

Signed-off-by: Bastian Blank <waldi@debian.org>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/block/xen-blkback/blkback.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 5cf2993..ed62008 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -824,3 +824,4 @@ static int __init xen_blkif_init(void)
 module_init(xen_blkif_init);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("xen-backend:vbd");
-- 
1.7.5.4
