From: Joe Perches <joe@perches.com>
Subject: [PATCH 31/44] drivers/xen: Remove unnecessary semicolons
Date: Sun, 14 Nov 2010 19:04:50 -0800
Message-ID: <b3f95cd997859d5d714de322ce17810fe73460cd.1289789605.git.joe@perches.com>
References: <cover.1289789604.git.joe@perches.com>
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <cover.1289789604.git.joe@perches.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jiri Kosina <trivial@kernel.org>
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/xen/swiotlb-xen.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 54469c3..65ea21a 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -54,7 +54,7 @@ u64 start_dma_addr;
 
 static dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
 {
-	return phys_to_machine(XPADDR(paddr)).maddr;;
+	return phys_to_machine(XPADDR(paddr)).maddr;
 }
 
 static phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
-- 
1.7.3.1.g432b3.dirty
