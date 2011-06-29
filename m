From: Bastian Blank <waldi@debian.org>
Subject: [PATCH 4/4] xen/netback: Add module alias for autoloading
Date: Wed, 29 Jun 2011 14:41:32 +0200
Message-ID: <20110629124132.GD31038__29108.9143873707$1309356646$gmane$org@wavehammer.waldi.eu.org>
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
To: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add xen-backend:vif module alias to the xen-netback module. This allows
automatic loading of the module.

Signed-off-by: Bastian Blank <waldi@debian.org>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/net/xen-netback/netback.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 0e4851b..fd00f25 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1743,3 +1743,4 @@ failed_init:
 module_init(netback_init);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("xen-backend:vif");
-- 
1.7.5.4
